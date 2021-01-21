#!/usr/bin/env bash
eval `scramv1 runtime -sh`
source ./setup.sh
############################################
SingleHiggs=("tth" "wzh" "vbf")
# SingleHiggs=("vbf")
Names=("ttHJetToGG" "VHToGG" "VBFHToGG")
# Names=("VBFHToGG")
for (( i = 0 ; i < 3 ; i++ ))
do
echo "Start process ${Names[$i]}"
Name=${Names[$i]}
procs=${SingleHiggs[$i]}
echo $Name $procs
year='2017'
cat='HHWWggTag_2'
mass='125'
doHHWWgg='False'
TreePath='/eos/user/a/atishelm/ntuples/HHWWgg_flashgg/January_2021_Production/2017/Single_H_2017_Hadded/'
doSelections="1"
Selections='dipho_pt > 54' # Seletions you want to applied.
############################################
#  Tree selectors#
#
############################################
path=`pwd`
cd ./Reweight/
  cp SingleHiggsSelections.C SingleHiggsSelections_Run.C
  sed -i "s#NAME#${Name}#g" SingleHiggsSelections_Run.C 
  sed -i "s#CAT#${cat}#g" SingleHiggsSelections_Run.C
  sed -i "s#PROCS#${procs}#g" SingleHiggsSelections_Run.C
  sed -i "s#YEAR#${year}#g" SingleHiggsSelections_Run.C
  sed -i "s#INPUTPATH#${TreePath}#g" SingleHiggsSelections_Run.C


if [ $doSelections -eq "1" ]
then
  echo "Selection start"
  sed -i "s#SELECTIONS#${Selections}#g" SingleHiggsSelections_Run.C
else
  echo "Do not apply any selections ,just copytree "
  sed -i "s#SELECTIONS##g" SingleHiggsSelections_Run.C # No Selection 
fi

root -b -q SingleHiggsSelections_Run.C
mv ${Name}_${cat}_${year}.root  ../Trees2WS/
cd ../Trees2WS/

#########################################
# start tree to workspace
########################################

if [ ! -d "../Signal/Input/" ]; then
  mkdir ../Signal/Input/
fi
# Signal tree to data ws
# echo "python trees2ws.py --inputConfig HHWWgg_config.py --inputTreeFile ./${Name}_${cat}_${year}.root --inputMass ${mass} --productionMode ${procs}  --year ${year} --doSystematics "
python trees2ws.py --inputConfig HHWWgg_config.py --inputTreeFile ./${Name}_${cat}_${year}.root --inputMass ${mass} --productionMode ${procs}  --year ${year} --doSystematics 

# data tree to data ws
cp ws_${procs}/${Name}_${cat}_${year}_${procs}.root ../Signal/Input/output_M125_${procs}_${cat}.root
# rm ${Name}_${cat}_${year}.root

#########################################
#shift dataset
#########################################
cd ../Signal/
python ./scripts/shiftHiggsDatasets_single_higgs.py --inputDir ./Input/ --procs ${procs} --cats ${cat} 


#######################################
# Run ftest
######################################
echo "Run FTest"
cp HHWWgg_single_higgs.py HHWWgg_config_Run.py
sed -i "s#NODE#node_${node}#g" HHWWgg_config_Run.py
sed -i "s#YEAR#${year}#g" HHWWgg_config_Run.py
sed -i "s#PROCS#${procs}#g" HHWWgg_config_Run.py
sed -i "s#CAT#${cat}#g" HHWWgg_config_Run.py
sed -i "s#INPUTDIR#${path}/Signal/Input/#g" HHWWgg_config_Run.py
python RunSignalScripts.py --inputConfig HHWWgg_config_Run.py --mode fTest --modeOpts "doPlots"


#######################################
# Run photon sys
######################################
python RunSignalScripts.py --inputConfig HHWWgg_config_Run.py --mode calcPhotonSyst


#######################################
#Run signal Fit
#######################################
python RunSignalScripts.py --inputConfig HHWWgg_config_Run.py --mode signalFit --groupSignalFitJobsByCat





rm HHWWgg_config_Run.py


########################################
#           DATACARD                   #
#                                      #
########################################
echo "Start generate datacard(no systeamtics)"
cd ../Datacard
if [ ! -d "./SingleHiggs" ]; then
  mkdir -p ./SingleHiggs/
fi
rm Datacard*.txt
rm -rf yields_test/
#copy signal  and bkg model
cp ${path}/Signal/outdir_HHWWggTest_${year}_single_Higgs/signalFit/output/CMS-HGG_sigfit_HHWWggTest_${year}_single_Higgs_${procs}_${year}_${cat}.root ./SingleHiggs/CMS-HGG_sigfit_packaged_${procs}_${cat}_${year}.root 

# python RunYields.py --cats $cat --inputWSDirMap $year=../Signal/Input/ --procs ${procs} --doHHWWgg ${doHHWWgg} --HHWWggLabel node_${node} --batch local --sigModelWSDir ./${procs}_node_${node}/ --bkgModelWSDir ./${procs}_node_${node}/
# python makeDatacard.py --years $year --prune --ext test #--doSystematics
# python cleanDatacard.py --datacard Datacard.txt --factor 2 --removeDoubleSided
# cp Datacard_cleaned.txt ./${procs}_node_${node}/HHWWgg_${procs}_node_${node}_${cat}_${year}.txt
#
cd ${path}
done
