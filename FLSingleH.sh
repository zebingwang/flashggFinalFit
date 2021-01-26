#!/usr/bin/env bash
eval `scramv1 runtime -sh`
source ./setup.sh
############################################
SingleHiggs=("tth" "wzh" "vbf" )
# SingleHiggs=("vbf" )
Names=("ttHJetToGG" "VHToGG" "VBFHToGG")
# Names=("VBFHToGG")
for (( i = 0 ; i < 3 ; i++ ))
do
  Name=${Names[$i]}
  procs=${SingleHiggs[$i]}
  year='2017'
  ext='FL'
  cat='HHWWggTag_FL_0'
  TreeCats='"HHWWggTag_2"'
  mass='125'
  doHHWWgg='False'
  TreePath='/eos/user/a/atishelm/ntuples/HHWWgg_flashgg/January_2021_Production/2017/Single_H_2017_Hadded/'
  doSelections="1"
  Selections='dipho_pt > 54' # Seletions you want to applied.
  ############################################
  #  Tree selectors#
  #
  ############################################
  sed -i "s#REPLACEMET_CATWV#${cat}#g" ./Signal/tools/replacementMap.py
  path=`pwd`
  cd ./Reweight/
  echo $Name $procs
  cp SingleHiggsSelections.C SingleHiggsSelections_Run.C
  sed -i "s#NEW_Cat_NAME#${cat}#g" SingleHiggsSelections_Run.C 
  sed -i "s#NAME#${Name}#g" SingleHiggsSelections_Run.C 
  sed -i "s#CAT#${TreeCats}#g" SingleHiggsSelections_Run.C
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
python trees2ws.py --inputConfig HHWWgg_config.py --inputTreeFile ./${Name}_${cat}_${year}.root --inputMass ${mass} --productionMode ${procs}  --year ${year} --doSystematics
cp ws_${procs}/${Name}_${cat}_${year}_${procs}.root ../Signal/Input/output_M125_${procs}_${cat}.root
rm ${Name}_${cat}_${year}.root
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
sed -i "s#HHWWggTest#${ext}#g" HHWWgg_config_Run.py
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



sed -i "s#${cat}#REPLACEMET_CATWV#g" ./tools/replacementMap.py


rm HHWWgg_config_Run.py


########################################
#           DATACARD                   #
#                                      #
########################################
echo "Start generate datacard(no systeamtics)"
cd ../Datacard
if [ ! -d "./SingleHiggs_${ext}_${year}" ]; then
  mkdir -p ./SingleHiggs_${ext}_${year}/
fi
rm Datacard*.txt
rm -rf yields_test/
#copy signal modl
cp ${path}/Signal/outdir_${ext}_${year}_single_Higgs/signalFit/output/CMS-HGG_sigfit_${ext}_${year}_single_Higgs_${procs}_${year}_${cat}.root ./SingleHiggs_${ext}_${year}/CMS-HGG_sigfit_packaged_${procs}_${cat}_${year}.root 
cd ${path}
done
