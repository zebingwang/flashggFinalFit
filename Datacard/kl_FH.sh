#!/usr/bin/env bash
eval `scramv1 runtime -sh`
source ../setup.sh
InputWorkspace="/eos/user/l/lipe/HHWWggWorkspace/FH"
procs="GluGluToHHTo2G4Q,GluGluToHHTo2G2ZTo2G4Q"
dir="FH_kl_combine"
mkdir -p ${dir}/${dir}
cats="HHWWggTag_FH_0"
singleH="tth,wzh,vbf,ggh"
nodes="1,5,2p45"
years="2016,2017,2018"
nodeNames=(${nodes//,/ })
catNames=(${cats//,/ })
yearNames=(${years//,/ })
procNames=(${procs//,/ })
for proc in ${procNames[@]} 
do
for year in ${yearNames[@]}
do
for cat in ${catNames[@]}
do  
  for node in ${nodeNames[@]}
  do
cp ./SingleHiggs_${proc}_node_cHHH${node}_${year}/Models/CMS-HGG_sigfit_packaged_${proc}_${cat}_${year}.root ./${dir}/${dir}/CMS-HGG_sigfit_packaged_${proc}_node_cHHH${node}_${cat}_${year}.root
cp ./SingleHiggs_${proc}_node_cHHH${node}_${year}/Models/CMS-HGG_multipdf_${cat}_${year}.root ./${dir}/${dir}/
cp ./SingleHiggs_${proc}_node_cHHH${node}_${year}/Models/CMS-HGG_multipdf_${cat}_${year}.root ./${dir}/${dir}/
cp ./SingleHiggs_${proc}_node_cHHH${node}_${year}/Models/CMS-HGG_sigfit_packaged_tth_${cat}_${year}.root ./${dir}/${dir}/
cp ./SingleHiggs_${proc}_node_cHHH${node}_${year}/Models/CMS-HGG_sigfit_packaged_ggh_${cat}_${year}.root ./${dir}/${dir}/
cp ./SingleHiggs_${proc}_node_cHHH${node}_${year}/Models/CMS-HGG_sigfit_packaged_vbf_${cat}_${year}.root ./${dir}/${dir}/
cp ./SingleHiggs_${proc}_node_cHHH${node}_${year}/Models/CMS-HGG_sigfit_packaged_wzh_${cat}_${year}.root ./${dir}/${dir}/
done
done
done
done
rm -rf ./yields_*
# cp ./systematics_${year}.py ./systematics.py
cp ./systematics_merged_kl.py ./systematics.py
# python RunYields.py --cats ${cats} --inputWSDirMap ${year}=${InputWorkspace}/Signal/Input/${year} --procs ${proc}_node_cHHH1,${proc}_node_cHHH5,${proc}_node_cHHH2p45,${singleH} --doSystematics --doHHWWgg True  --batch local --ext ${dir} --klScan True --bkgModelWSDir ${dir} --sigModelWSDir ${dir}
python RunYields.py --cats ${cats} --inputWSDirMap 2016=${InputWorkspace}/Signal/Input/2016/,2017=${InputWorkspace}/Signal/Input/2017/,2018=${InputWorkspace}/Signal/Input/2018/ --procs GluGluToHHTo2G4Q_node_cHHH1,GluGluToHHTo2G4Q_node_cHHH5,GluGluToHHTo2G4Q_node_cHHH2p45,GluGluToHHTo2G2ZTo2G4Q_node_cHHH5,GluGluToHHTo2G2ZTo2G4Q_node_cHHH2p45,GluGluToHHTo2G2ZTo2G4Q_node_cHHH1,${singleH} --doSystematics --doHHWWgg True  --batch local --ext ${dir} --klScan True --bkgModelWSDir ${dir} --sigModelWSDir ${dir}  --ignore-warnings True
python makeDatacard.py --years ${years} --prune True  --doSystematics --pruneThreshold 0.00001 --ext ${dir}
python cleanDatacard.py --datacard Datacard.txt --factor 2 --removeDoubleSided
cp Datacard.txt $dir/${dir}.txt
for year in ${yearNames[@]}
do
for cat in ${catNames[@]}
do
  for node in ${nodeNames[@]}
  do
sed -i "s#GluGluToHHTo2G4Q_node_cHHH${node}_${year}_hwwhgg#ggHH_kl_${node}_kt_1_${year}_hwwhgg4Q#g" $dir/${dir}.txt
sed -i "s#GluGluToHHTo2G2ZTo2G4Q_node_cHHH${node}_${year}_hwwhgg#ggHH_kl_${node}_kt_1_${year}_hzzhgg4Q#g" $dir/${dir}.txt
sed -i "s#tth#ttH#g" $dir/${dir}.txt
sed -i "s#vbf#qqH#g" $dir/${dir}.txt
sed -i "s#ggh#ggH#g" $dir/${dir}.txt
sed -i "s#wzh#VH#g" $dir/${dir}.txt
sed -i 's#ggH_HHWWggTag#ggh_HHWWggTag#g' $dir/${dir}.txt
sed -i 's#qqH_HHWWggTag#vbf_HHWWggTag#g' $dir/${dir}.txt
sed -i 's#ttH_HHWWggTag#tth_HHWWggTag#g' $dir/${dir}.txt
sed -i 's#VH_HHWWggTag#wzh_HHWWggTag#g' $dir/${dir}.txt
sed -i 's#ttH_single_Higgs#tth_single_Higgs#g' $dir/${dir}.txt
sed -i 's#qqH_single_Higgs#vbf_single_Higgs#g' $dir/${dir}.txt
sed -i 's#VH_single_Higgs#wzh_single_Higgs#g' $dir/${dir}.txt
sed -i 's#ggH_single_Higgs#ggh_single_Higgs#g' $dir/${dir}.txt
if [ "${node}" == "1" ]
then
echo "xs_HH_cHHH${node}        rateParam ${cat} ggHH_kl_${node}_kt_1_*4Q 31.049" >> $dir/${dir}.txt
elif [ "${node}" == "2p45" ]
then
echo "xs_HH_cHHH${node}        rateParam ${cat} ggHH_kl_${node}_kt_1_*4Q 13.126" >> $dir/${dir}.txt
else
echo "xs_HH_cHHH${node}        rateParam ${cat} ggHH_kl_${node}_kt_1_*4Q 91.174" >> $dir/${dir}.txt
fi
done
done
done
echo "br_HH_WWgg    rateParam  * ggHH_kl_*_kt_1_*_hwwhgg4Q 0.000970198" >>$dir/${dir}.txt
echo "br_HH_ZZgg    rateParam  * ggHH_kl_*_kt_1_*_hzzhgg4Q 0.000119992" >>$dir/${dir}.txt
echo "br_WW_4Q    rateParam  * ggHH_kl_*_kt_1_*_hwwhgg4Q 0.4544" >>$dir/${dir}.txt
echo "br_ZZ_4Q    rateParam  * ggHH_kl_*_kt_1_*_hzzhgg4Q 0.4888" >>$dir/${dir}.txt
echo "nuisance edit  freeze br_HH_WWgg" >> $dir/${dir}.txt
echo "nuisance edit  freeze br_HH_ZZgg" >> $dir/${dir}.txt
echo "nuisance edit  freeze br_ZZ_4Q" >> $dir/${dir}.txt
echo "nuisance edit  freeze br_WW_4Q" >> $dir/${dir}.txt
  for node in ${nodeNames[@]}
  do
echo "nuisance edit  freeze xs_HH_cHHH${node}" >> $dir/${dir}.txt
done
