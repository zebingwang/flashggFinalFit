#!/usr/bin/env bash
node="cHHH2p45"
procs='GluGluToHHTo2G4Q'
year='2017'
cat='HHWWggTag_1'
doHHWWgg='True'
TreePath='/eos/user/a/atishelm/ntuples/HHWWgg_flashgg/January_2021_Production/2017/Signal/FH_NLO_2017_hadded/'
DataTreeFile='/eos/user/a/atishelm/ntuples/HHWWgg_flashgg/January_2021_Production/2017/Data_Trees/Data_2017.root'
doSelections="0"
Selections='dipho_pt > 54' # Seletions you want to applied.
eval `scramv1 runtime -sh`
source ./setup.sh
############################################
#  Tree selectors#
#
############################################
path=`pwd`
cd ./Reweight/
if [ $doSelections -eq "1" ]
then
  echo "Selection start"
  cp Selections.C Selections_Run.C
  cp DataSelections.C DataSelections_Run.C
  sed -i "s#NODE#${node}#g" Selections_Run.C 
  sed -i "s#CAT#${cat}#g" Selections_Run.C
  sed -i "s#PROCS#${procs}#g" Selections_Run.C
  sed -i "s#YEAR#${year}#g" Selections_Run.C
  sed -i "s#INPUTPATH#${TreePath}#g" Selections_Run.C
  sed -i "s#SELECTIONS#${Selections}#g" Selections_Run.C
  ##########Data selection #####
  sed -i "s#CAT#${cat}#g" DataSelections_Run.C
  sed -i "s#YEAR#${year}#g" DataSelections_Run.C
  sed -i "s#INPUTFILE#${DataTreeFile}#g" DataSelections_Run.C
  sed -i "s#SELECTIONS#${Selections}#g" DataSelections_Run.C

  root -b -q Selections_Run.C
  root -b -q DataSelections_Run.C
  rm Selections_Run.C
  rm DataSelections_Run.C
else
  echo "Do not apply any selections ,just copy tree file "
  # cp ${TreePath}${procs}_node_${node}_${year}.root ./${procs}_node_${node}_${year}.root
  # cp ${DataTreeFile} ./Data_13TeV_${cat}_${year}.root
fi

mv ${procs}_node_${node}_${year}.root  ../Trees2WS/
mv Data_13TeV_${cat}_${year}.root ../Trees2WS/
cd ../Trees2WS/

#########################################
# start tree to workspace
########################################

if [ ! -d "../Signal/Input/" ]; then
  mkdir ../Signal/Input/
fi
if [ ! -d "../Background/Input/${procs}_${year}" ]; then
  mkdir -p ../Background/Input/${procs}_${year}
fi


# Signal tree to data ws
# python trees2ws.py --inputConfig HHWWgg_config.py --inputTreeFile ./${procs}_node_${node}_${year}.root --inputMass node_${node} --productionMode ${procs}  --year ${year} --doSystematics

# data tree to data ws
if [ ! -f "../Background/Input/${procs}_${year}/allData.root" ]; then
  echo "Do not have an input Data WS, convert tree to workspace "
  # python trees2ws_data.py --inputConfig HHWWgg_config.py --inputTreeFile ./Data_13TeV_${cat}_${year}.root
  mv ws/Data_13TeV_${cat}_${year}.root ../Background/Input/${year}/allData.root
fi
mv ws_${procs}/${procs}_node_${node}_${year}_${procs}.root ../Signal/Input/output_M125_${procs}_node_${node}_${cat}.root
rm ${procs}_node_${node}_${year}.root
rm Data_13TeV_${cat}_${year}.root

#########################################
#shift dataset
#########################################
cd ../Signal/
python ./scripts/shiftHiggsDatasets_test.py --inputDir ./Input/ --procs ${procs} --cats ${cat} --HHWWggLabel node_${node}


#######################################
# Run ftest
######################################
sed -i "s#PROCS_Replacement#${procs}#g" tools/replacementMap.py ##Set replacements while WV events < 100
sed -i "s#CAT_Replacement#${cat}#g" tools/replacementMap.py
echo "Run FTest"
cp HHWWgg_config_test_2017.py HHWWgg_config_Run_2017.py
sed -i "s#NODE#node_${node}#g" HHWWgg_config_Run_2017.py
sed -i "s#PROCS#${procs}#g" HHWWgg_config_Run_2017.py
sed -i "s#DOHHWWGG#${doHHWWgg}#g" HHWWgg_config_Run_2017.py
sed -i "s#CAT#${cat}#g" HHWWgg_config_Run_2017.py
sed -i "s#INPUTDIR#${path}/Signal/Input/#g" HHWWgg_config_Run_2017.py
python RunSignalScripts.py --inputConfig HHWWgg_config_Run_2017.py --mode fTest --modeOpts "doPlots"


#######################################
# Run photon sys
######################################
python RunSignalScripts.py --inputConfig HHWWgg_config_Run_2017.py --mode calcPhotonSyst


#######################################
#Run signal Fit
#######################################
python RunSignalScripts.py --inputConfig HHWWgg_config_Run_2017.py --mode signalFit --groupSignalFitJobsByCat





rm HHWWgg_config_Run_2017.py
sed -i "s#${procs}#PROCS_Replacement#g" tools/replacementMap.py
sed -i "s#${cat}#CAT_Replacement#g" tools/replacementMap.py

########################################
#           BKG model                  #
#                                      #
########################################
cd ../Background
cp HHWWgg_cofig_test.py HHWWgg_cofig_Run.py
sed -i "s#CAT#${cat}#g" HHWWgg_cofig_Run.py
sed -i "s#YEAR#${year}#g" HHWWgg_cofig_Run.py
cmsenv
# make clean
make

python RunBackgroundScripts.py --inputConfig HHWWgg_cofig_Run.py --mode fTestParallel

rm HHWWgg_cofig_Run.py

########################################
#           DATACARD                   #
#                                      #
########################################
echo "Start generate datacard(no systeamtics)"
cd ../Datacard
if [ ! -d "./${procs}_node_${node}" ]; then
  mkdir ./${procs}_node_${node}
fi
rm Datacard*.txt
rm -rf yields_test/
#copy signal  and bkg model
cp ${path}/Signal/outdir_HHWWggTest_${year}_node_${node}/signalFit/output/CMS-HGG_sigfit_HHWWggTest_${year}_node_${node}_${procs}_${year}_${cat}.root ./${procs}_node_${node}/CMS-HGG_sigfit_packaged_${cat}_${year}.root 
cp ${path}/Background/outdir_HHWWggTest_$year/CMS-HGG_multipdf_${cat}.root ./${procs}_node_${node}/CMS-HGG_multipdf_${cat}_$year.root 

python RunYields.py --cats $cat --inputWSDirMap $year=../Signal/Input/ --procs ${procs} --doHHWWgg ${doHHWWgg} --HHWWggLabel node_${node} --batch local --sigModelWSDir ./ --bkgModelWSDir ./
python makeDatacard.py --years $year --prune --ext test #--doSystematics
python cleanDatacard.py --datacard Datacard.txt --factor 2 --removeDoubleSided
cp Datacard_cleaned.txt ./${procs}_node_${node}/HHWWgg_${procs}_node_${node}_${cat}_${year}.txt

########################################
#           combine                    #
#                                      #
########################################
cd ./${procs}_node_${node}/

combine HHWWgg_${procs}_node_${node}_${cat}_${year}.txt  -m 125 -M AsymptoticLimits --run=blind  --setParameterRanges  MH=120,130

