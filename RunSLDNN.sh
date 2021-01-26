#!/usr/bin/env bash
node="cHHH1"
procs='GluGluToHHTo2G2Qlnu'
year='2017'
doHHWWgg="True"
ext='SL'
cat='HHWWggTag_0,HHWWggTag_1,HHWWggTag_2,HHWWggTag_3'
catNames=("HHWWggTag_0" "HHWWggTag_1" "HHWWggTag_2" "HHWWggTag_3") #change variable ${cat} to shell array format 
path=`pwd`
SignalFile='/afs/cern.ch/user/c/chuw/chuw/HHWWgg/FinalFit/CMSSW_10_2_13/src/flashggFinalFit/January_2021_SLDNN/Signal/GluGluToHHTo2G2Qlnu_node_cHHH1_2017.root'
DataFile='/afs/cern.ch/user/c/chuw/chuw/HHWWgg/FinalFit/CMSSW_10_2_13/src/flashggFinalFit/January_2021_SLDNN/Data/allData.root'
Replace='HHWWggTag_0'


eval `scramv1 runtime -sh`
source ./setup.sh
sed -i "s#REPLACEMET_CATWV#${cat}#g" ./Signal/tools/replacementMap.py
sed -i "s#dest='skipSystematics', default=False,#dest='skipSystematics', default=True,#g" ./Signal/scripts/signalFit.py
#########################################
#Copy signal and bkg file as a new name
#########################################
if [ ! -d "./Signal/Input/" ]; then
  mkdir ./Signal/Input/
fi
cd ./Trees2WS/
for catName in ${catNames[@]}
do
echo "Copy...." $catName
if [ ! -d "../Background/Input/${procs}_${year}" ]; then
  mkdir -p ../Background/Input/${procs}_${year}
fi
cp ${SignalFile} ../Signal/Input/output_M125_${procs}_node_${node}_${catName}.root
cp ${DataFile} ../Background/Input/${procs}_${year}/allData.root
done

#########################################
#shift dataset
#########################################
cd ../Signal/
python ./scripts/shiftHiggsDatasets_test.py --inputDir ./Input/ --procs ${procs} --cats ${cat} --HHWWggLabel node_${node}


#######################################
# Run ftest
######################################
echo "Run FTest"
cp HHWWgg_config_test.py HHWWgg_config_Run.py
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
for catName in ${catNames[@]}
do
cp outdir_${ext}_${year}_node_${node}/signalFit/output/CMS-HGG_sigfit_${ext}_${year}_node_${node}_${procs}_${year}_${catName}.root outdir_${ext}_${year}_node_${node}/CMS-HGG_sigfit_${ext}_${year}_node_${node}_${catName}.root
python RunPlotter.py --procs all --years $year --cats $catName --ext ${ext}_${year}_node_${node}
done


sed -i "s#${Replace}#REPLACEMET_CATWV#g" ./tools/replacementMap.py
sed -i "s#dest='skipSystematics', default=True,#dest='skipSystematics', default=False,#g" ./scripts/signalFit.py



rm HHWWgg_config_Run.py

########################################
#           BKG model                  #
#                                      #
########################################
cd ../Background
cp HHWWgg_cofig_test.py HHWWgg_cofig_Run.py
sed -i "s#CAT#${cat}#g" HHWWgg_cofig_Run.py
sed -i "s#HHWWggTest#${ext}#g" HHWWgg_cofig_Run.py
sed -i "s#YEAR#${year}#g" HHWWgg_cofig_Run.py
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
if [ ! -d "./${procs}_node_${node}/${procs}_node_${node}/" ]; then
  mkdir -p ./${procs}_node_${node}/${procs}_node_${node}
fi
rm Datacard*.txt
rm -rf yields_*/

# cp -rf SingleHiggs_${ext}_${year} SingleHiggs_${procs}_node_${node}_${year}
mkdir SingleHiggs_${procs}_node_${node}_${year}
if [ ! -d "./SingleHiggs_${procs}_node_${node}_${year}/Models/" ]; then
mkdir -p ./SingleHiggs_${procs}_node_${node}_${year}/Models/
fi

#copy signal  and bkg model
for catName in ${catNames[@]}
  do
  cp ${path}/Background/outdir_${ext}_$year/CMS-HGG_multipdf_${catName}.root ./SingleHiggs_${procs}_node_${node}_${year}/Models/CMS-HGG_multipdf_${catName}_$year.root
  cp ${path}/Signal/outdir_${ext}_${year}_node_${node}/signalFit/output/CMS-HGG_sigfit_${ext}_${year}_node_${node}_${procs}_${year}_${catName}.root ./SingleHiggs_${procs}_node_${node}_${year}/Models/CMS-HGG_sigfit_packaged_${procs}_${catName}_${year}.root
done
  cp Datacard_cleaned.txt ./SingleHiggs_${procs}_node_${node}_${year}/HHWWgg_${procs}_node_${node}_${ext}_${year}.txt
  python RunYields.py --cats $cat --inputWSDirMap $year=../Signal/Input/ --procs ${procs} --doHHWWgg ${doHHWWgg} --HHWWggLabel node_${node} --batch local --sigModelWSDir ./Models --bkgModelWSDir ./Models  --ext ${procs}_node_${node}
  python makeDatacard.py --years $year --prune True --ext ${procs}_node_${node} --pruneThreshold 0.00001 
  python cleanDatacard.py --datacard Datacard.txt --factor 2 --removeDoubleSided
  cp Datacard_cleaned.txt ./SingleHiggs_${procs}_node_${node}_${year}/HHWWgg_${procs}_node_${node}_${ext}_${year}_no_singleH.txt
  
  cd ./SingleHiggs_${procs}_node_${node}_${year}
  combine HHWWgg_${procs}_node_${node}_${ext}_${year}_no_singleH.txt  -m 125 -M AsymptoticLimits --run=blind  --setParameterRanges  MH=120,130
