#!/usr/bin/env bash
node=("NLO_2")
singleHiggs="tth,wzh"
echo "==================="
ext='FL_Run2combinedData_dipho_pt91'
procs='GluGluToHHTo2G2l2nu'
cat='HHWWggTag_FL_0' #Final cat name 
InputWorkspace="/eos/user/c/chuw/HHWWggWorkspace/FL_withPt_over_Mass_dipho_pt91_LO/" 
hadd_workspaceDir="/afs/cern.ch/user/c/chuw/chuw/HHWWgg/flashgg/CMSSW_10_6_8/" #flashgg Dir,used hadd_workspaces
catNames=(${cat//,/ })

path=`pwd`
########################################
#           hadd_workspace             #
#                                      #
########################################
cd $hadd_workspaceDir 
eval `scramv1 runtime -sh`
cd $InputWorkspace
cd Background/Input/
mkdir $ext
cd $ext
cp ../${procs}_2016/allData.root Data2016.root
cp ../${procs}_2017/allData.root Data2017.root
cp ../${procs}_2018/allData.root Data2018.root
hadd_workspaces allData.root Data201*
########################################
#           BKG model                  #
#                                      #
########################################
cd $path
eval `scramv1 runtime -sh`
source ./setup.sh
cd ./Background
cp HHWWgg_cofig_test.py HHWWgg_cofig_Run.py
sed -i "s#CAT#${cat}#g" HHWWgg_cofig_Run.py
sed -i "s#PROCS_YEAR#${ext}#g" HHWWgg_cofig_Run.py
sed -i "s#HHWWggTest_YEAR#${ext}#g" HHWWgg_cofig_Run.py
sed -i "s#YEAR#combined#g" HHWWgg_cofig_Run.py
sed -i "s#PROCS#${procs}#g" HHWWgg_cofig_Run.py
sed -i "s#INPUT#${InputWorkspace}#g" HHWWgg_cofig_Run.py
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
rm -rf ./FL_run2_dipho_pt91_${node}
cp systematics_merged.py systematics.py
#copy signal  and bkg model
if [ ! -d "./FL_run2_dipho_pt91_${node}/Models/" ]; then
  mkdir -p ./FL_run2_dipho_pt91_${node}/Models/
fi
####################
#
#   Add singleHiggs procs to RunYields.py 
###################
if [ "$node" = "cHHH1" ]
then
XS=31.049
elif [ "$node" = "cHHH2p45" ]
then
XS=13.126
elif [ "$node" = "cHHH5" ]
then
XS=91.174
else
XS=1
fi
cp ${path}/Background/outdir_${ext}/CMS-HGG_multipdf_*.root ./FL_run2_dipho_pt91_${node}/Models/
cp -rf ./SingleHiggs_${procs}_node_${node}_2016/* FL_run2_dipho_pt91_${node}/
cp -rf ./SingleHiggs_${procs}_node_${node}_2017/* FL_run2_dipho_pt91_${node}/
cp -rf ./SingleHiggs_${procs}_node_${node}_2018/* FL_run2_dipho_pt91_${node}/

python RunYields.py --cats ${cat} --inputWSDirMap 2016=${InputWorkspace}/Signal/Input/2016,2017=${InputWorkspace}/Signal/Input/2017,2018=${InputWorkspace}/Signal/Input/2018/ --procs ${procs},${singleHiggs} --doSystematics True --doHHWWgg True --HHWWggLabel node_${node} --batch local --ext SingleHiggs  --bkgModelWSDir ./Models --sigModelWSDir ./Models --mergeYears True --ignore-warnings True
python makeDatacard.py --years 2016,2017,2018 --prune True --ext SingleHiggs --pruneThreshold 0.00001 --doSystematics
python cleanDatacard.py --datacard Datacard.txt --factor 2 --removeDoubleSided
cp Datacard_cleaned.txt  FL_run2_dipho_pt91_${node}/FL_run2_dipho_pt91_${node}_merged.txt
cd FL_run2_dipho_pt91_${node}/
echo "xs_HH         rateParam * GluGluToHHTo2G2l2nu_*_hwwhgg_node_${node} $XS" >>FL_run2_dipho_pt91_${node}_merged.txt
echo "br_HH_WWgg    rateParam * GluGluToHHTo2G2l2nu_*_hwwhgg_node_${node} 0.000910198" >>FL_run2_dipho_pt91_${node}_merged.txt
echo "br_WW_2l2nu   rateParam * GluGluToHHTo2G2l2nu_*_hwwhgg_node_${node} 0.1071" >> FL_run2_dipho_pt91_${node}_merged.txt
echo "nuisance edit  freeze xs_HH" >> FL_run2_dipho_pt91_${node}_merged.txt
echo "nuisance edit  freeze br_WW_2l2nu" >> FL_run2_dipho_pt91_${node}_merged.txt
echo "nuisance edit  freeze br_HH_WWgg" >> FL_run2_dipho_pt91_${node}_merged.txt 
combineCards.py HHWWgg_${procs}_node_${node}_FL_2016.txt HHWWgg_${procs}_node_${node}_FL_2017.txt HHWWgg_${procs}_node_${node}_FL_2018.txt >FL_run2_dipho_pt91_${node}_separate_year.txt
echo "Combine results with merged:"
combine FL_run2_dipho_pt91_${node}_merged.txt  -m 125.38 -M AsymptoticLimits --run=blind --freezeParameters MH 
echo "Combine results with separate data:"
combine FL_run2_dipho_pt91_${node}_separate_year.txt  -m 125.38 -M AsymptoticLimits --run=blind  --freezeParameters MH
cd $path


