#!/usr/bin/env bash
nodes=("cHHH1")
years=("2017")
singleHiggs="tth,wzh,vbf,ggh"
for node in ${nodes[@]}
do
  for year in ${years[@]}
  do
    echo "==================="
    echo "Start ${year} ${node}"
    ext='SL'
    procs='GluGluToHHTo2G2Qlnu'
    
    InputTreeCats='HHWWggTag_SL_0,HHWWggTag_SL_1,HHWWggTag_SL_2,HHWWggTag_SL_3' #input cat name in the Signal tree
    InputDataTreeCats='HHWWggTag_0,HHWWggTag_1,HHWWggTag_2,HHWWggTag_3' #input cat name in the Data tree
    
    cat='HHWWggTag_SLDNN_0,HHWWggTag_SLDNN_1,HHWWggTag_SLDNN_2,HHWWggTag_SLDNN_3' #Final cat name 
    
    catNames=(${cat//,/ })
    # catNames=("HHWWggTag_SLDNN_0" "HHWWggTag_SLDNN_1" "HHWWggTag_SLDNN_2" "HHWWggTag_SLDNN_3") #shell format array, should same as "cat",just a different format
   
    SignalTreeFile="/afs/cern.ch/work/a/atishelm/public/ForChu/January_2021_SLDNN/Signal_withSystematics/signal_2017_CategorizedTrees.root"
    DataTreeFile="/afs/cern.ch/work/a/atishelm/public/ForChu/January_2021_SLDNN/Data/Data_2017.root"

    Replace='HHWWggTag_SLDNN_0'
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
  cp Selections.C Selections_Run.C
  cp DataSelections.C DataSelections_Run.C
  sed -i "s#NODE#${node}#g" Selections_Run.C 
  sed -i "s#NEW_Cat_NAME#${cat}#g" Selections_Run.C 
  sed -i "s#CAT#${InputTreeCats}#g" Selections_Run.C
  sed -i "s#PROCS#${procs}#g" Selections_Run.C
  sed -i "s#YEAR#${year}#g" Selections_Run.C
  sed -i "s#2017#${year}#g" Selections_Run.C
  sed -i "s#INPUTFILE#${SignalTreeFile}#g" Selections_Run.C
if [ "$ext" = "SL" ]
then
  sed -i "s#tagsDumper/trees/##g" Selections_Run.C
  sed -i "s#tagsDumper/trees/##g" DataSelections_Run.C
fi

if [ $year -eq "2018" ]
then
  sed -i "s#metUncUncertainty"#metUncUncertainty","JetHEM"#g" Selections_Run.C
fi
##########Data selection #####
  sed -i "s#CAT#${InputDataTreeCats}#g" DataSelections_Run.C
  sed -i "s#NEW_Cat_NAME#${cat}#g" DataSelections_Run.C 
  sed -i "s#YEAR#${year}#g" DataSelections_Run.C
  sed -i "s#INPUTFILE#${DataTreeFile}#g" DataSelections_Run.C


if [ $doSelections -eq "1" ]
then
  echo "Selection start"
  sed -i "s#SELECTIONS#${Selections}#g" Selections_Run.C
  ##########Data selection #####
  sed -i "s#SELECTIONS#${Selections}#g" DataSelections_Run.C

else
  echo "Do not apply any selections ,just copytree "
  sed -i "s#SELECTIONS##g" Selections_Run.C # No Selection 
  sed -i "s#SELECTIONS##g" DataSelections_Run.C #No Selection
fi

root -l  Selections_Run.C
root -b -q DataSelections_Run.C
exit
rm Selections_Run.C
rm DataSelections_Run.C
mv ${procs}_node_${node}_${year}.root  ../Trees2WS/
mv Data_13TeV_${year}.root ../Trees2WS/
cd ../Trees2WS/
#########################################
# start tree to workspace
########################################

if [ ! -d "../Signal/Input/" ]; then
  mkdir ../Signal/Input/
fi
# Signal tree to signal ws

if [ $year -ne "2017" ] 
then
  echo "not 2017"
  cp HHWWgg_config_noprefire.py HHWWgg_config_run.py
else
  cp HHWWgg_config.py HHWWgg_config_run.py
fi
sed -i "s#2017#${year}#g" HHWWgg_config_run.py
sed -i "s#auto#${cat}#g" HHWWgg_config_run.py
python trees2ws.py --inputConfig HHWWgg_config_run.py --inputTreeFile ./${procs}_node_${node}_${year}.root --inputMass node_${node} --productionMode ${procs}  --year ${year} --doSystematics
# data tree to data ws
python trees2ws_data.py --inputConfig HHWWgg_config_run.py --inputTreeFile ./Data_13TeV_${year}.root
rm HHWWgg_config_run.py
for catName in ${catNames[@]}
do
  if [ ! -d "../Background/Input/${procs}_${year}" ]; then
    mkdir -p ../Background/Input/${procs}_${year}
  fi
  cp ws_${procs}/${procs}_node_${node}_${year}_${procs}.root ../Signal/Input/output_M125_${procs}_node_${node}_${catName}.root
  cp ws/Data_13TeV_${year}.root ../Background/Input/${procs}_${year}/allData.root
  # cp ../January_2021_SLDNN/Data/newData.root ../Background/Input/${procs}_${year}/allData.root
done
rm ${procs}_node_${node}_${year}.root
rm Data_13TeV_${year}.root

#########################################
#shift dataset
#########################################
cd ../Signal/
python ./scripts/shiftHiggsDatasets_test.py --inputDir ./Input/ --procs ${procs} --cats ${cat} --HHWWggLabel node_${node}
cp ./tools/replacementMapHHWWgg.py ./tools/replacementMap.py
sed -i "s#REPLACEMET_CATWV#${Replace}#g" ./tools/replacementMap.py
#######################################
# Run ftest
######################################
echo "Run FTest"
cp HHWWgg_config_test.py HHWWgg_config_Run.py
sed -i "s#NODE#node_${node}#g" HHWWgg_config_Run.py
sed -i "s#YEAR#${year}#g" HHWWgg_config_Run.py
sed -i "s#PROCS#${procs}#g" HHWWgg_config_Run.py
sed -i "s#CAT#${cat}#g" HHWWgg_config_Run.py
sed -i "s#HHWWggTest#${ext}#g" HHWWgg_config_Run.py
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
for catName in ${catNames[@]}
do
cp outdir_${ext}_${year}_node_${node}/signalFit/output/CMS-HGG_sigfit_${ext}_${year}_node_${node}_${procs}_${year}_${catName}.root outdir_${ext}_${year}_node_${node}/CMS-HGG_sigfit_${ext}_${year}_node_${node}_${catName}.root
python RunPlotter.py --procs all --years $year --cats $catName --ext ${ext}_${year}_node_${node}
done

rm HHWWgg_config_Run.py
########################################
#           BKG model                  #
#                                      #
########################################
cd ../Background
cp HHWWgg_cofig_test.py HHWWgg_cofig_Run.py
sed -i "s#CAT#${cat}#g" HHWWgg_cofig_Run.py
sed -i "s#YEAR#${year}#g" HHWWgg_cofig_Run.py
sed -i "s#HHWWggTest#${ext}#g" HHWWgg_cofig_Run.py
sed -i "s#PROCS#${procs}#g" HHWWgg_cofig_Run.py
cmsenv
# make clean
make

python RunBackgroundScripts.py --inputConfig HHWWgg_cofig_Run.py --mode fTestParallel

rm HHWWgg_cofig_Run.py
########################################
#           DATACARD                   #
#                                      #
########################################
echo "Start generate datacard"
cd ../Datacard
rm Datacard*.txt
rm -rf yields_*/
cp systematics_${year}.py systematics.py 
#copy signal  and bkg model
rm -rf SingleHiggs_${procs}_node_${node}_${year}
cp -rf SingleHiggs_${ext}_${year}/ SingleHiggs_${procs}_node_${node}_${year}/
if [ ! -d "./SingleHiggs_${procs}_node_${node}_${year}/Models/" ]; then
  mkdir -p ./SingleHiggs_${procs}_node_${node}_${year}/Models/
fi
####################
#
#   Add singleHiggs procs to RunYields.py 
###################
python RunYields.py --cats ${cat} --inputWSDirMap ${year}=${path}/Signal/Input --procs ${procs},${singleHiggs} --doSystematics --doHHWWgg True --HHWWggLabel node_${node} --batch local --ext SingleHiggs  --bkgModelWSDir ./Models --sigModelWSDir ./Models
####################
python makeDatacard.py --years ${year} --prune True --ext SingleHiggs  --doSystematics --pruneThreshold 0.00001
python cleanDatacard.py --datacard Datacard.txt --factor 2 --removeDoubleSided
mv ./SingleHiggs_${procs}_node_${node}_${year}/*${cat}*.root SingleHiggs_${procs}_node_${node}_${year}/Models/
for catName in ${catNames[@]}
do
cp ${path}/Background/outdir_${ext}_$year/CMS-HGG_multipdf_${catName}.root ./SingleHiggs_${procs}_node_${node}_${year}/Models/CMS-HGG_multipdf_${catName}_$year.root 
cp ${path}/Signal/outdir_${ext}_${year}_node_${node}/signalFit/output/CMS-HGG_sigfit_${ext}_${year}_node_${node}_${procs}_${year}_${catName}.root ./SingleHiggs_${procs}_node_${node}_${year}/Models/CMS-HGG_sigfit_packaged_${procs}_${catName}_${year}.root 
done
cp Datacard_cleaned.txt ./SingleHiggs_${procs}_node_${node}_${year}/HHWWgg_${procs}_node_${node}_${cat}_${year}.txt

python RunYields.py --cats $cat --inputWSDirMap $year=../Signal/Input/ --procs ${procs} --doHHWWgg True --HHWWggLabel node_${node} --batch local --sigModelWSDir ./Models --bkgModelWSDir ./Models --doSystematics --ext ${procs}_node_${node}
python makeDatacard.py --years $year --prune True --ext ${procs}_node_${node} --pruneThreshold 0.00001 --doSystematics
python cleanDatacard.py --datacard Datacard.txt --factor 2 --removeDoubleSided
cp Datacard_cleaned.txt ./SingleHiggs_${procs}_node_${node}_${year}/HHWWgg_${procs}_node_${node}_${cat}_${year}_no_singleH.txt
#
cd ./SingleHiggs_${procs}_node_${node}_${year}
echo "Combine results without singleH:"
combine HHWWgg_${procs}_node_${node}_${cat}_${year}_no_singleH.txt  -m 125 -M AsymptoticLimits --run=blind  --setParameterRanges  MH=120,130
echo "Combine results singleH:"
sed -i "24c process  0 2 3 4 5  1" ./HHWWgg_${procs}_node_${node}_${cat}_${year}.txt
combine HHWWgg_${procs}_node_${node}_${cat}_${year}.txt  -m 125 -M AsymptoticLimits --run=blind  --setParameterRanges  MH=120,130
cd $path
done
done


