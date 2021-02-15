#!/usr/bin/env bash
eval `scramv1 runtime -sh`
source ../setup.sh
InputWorkspace="/eos/user/c/chuw/HHWWggWorkspace/SL/"
proc="GluGluToHHTo2G2Qlnu"
year="2018"
dir="SL_kl_${year}"
mkdir -p ${dir}/${dir}
cats="HHWWggTag_SLDNN_0,HHWWggTag_SLDNN_1,HHWWggTag_SLDNN_2,HHWWggTag_SLDNN_3"
singleH="tth,wzh,vbf,ggh"
nodes="1,5,2p45"
nodeNames=(${nodes//,/ })
catNames=(${cats//,/ })
for cat in ${catNames[@]}
do  
  for node in ${nodeNames[@]}
  do
cp ./SingleHiggs_${proc}_node_cHHH${node}_${year}/Models/CMS-HGG_sigfit_packaged_${proc}_${cat}_${year}.root ./${dir}/${dir}/CMS-HGG_sigfit_packaged_${proc}_node_cHHH${node}_${cat}_${year}.root
cp ./SingleHiggs_${proc}_node_cHHH${node}_${year}/Models/CMS-HGG_multipdf_${cat}_${year}.root ./${dir}/${dir}/
cp ./SingleHiggs_${proc}_node_cHHH${node}_${year}/Models/CMS-HGG_sigfit_packaged_tth_${cat}_${year}.root ./${dir}/${dir}/
cp ./SingleHiggs_${proc}_node_cHHH${node}_${year}/Models/CMS-HGG_sigfit_packaged_ggh_${cat}_${year}.root ./${dir}/${dir}/
cp ./SingleHiggs_${proc}_node_cHHH${node}_${year}/Models/CMS-HGG_sigfit_packaged_vbf_${cat}_${year}.root ./${dir}/${dir}/
cp ./SingleHiggs_${proc}_node_cHHH${node}_${year}/Models/CMS-HGG_sigfit_packaged_wzh_${cat}_${year}.root ./${dir}/${dir}/
done
done
rm -rf ./yields_*
cp ./systematics_${year}.py ./systematics.py
python RunYields.py --cats ${cats} --inputWSDirMap ${year}=${InputWorkspace}/Signal/Input/${year} --procs ${proc}_node_cHHH1,${proc}_node_cHHH5,${proc}_node_cHHH2p45,${singleH} --doSystematics --doHHWWgg True  --batch local --ext ${dir} --klScan True --bkgModelWSDir ${dir} --sigModelWSDir ${dir}
python makeDatacard.py --years ${year} --prune True  --doSystematics --pruneThreshold 0.00001 --ext ${dir}
cp Datacard.txt $dir/${dir}.txt
for cat in ${catNames[@]}
do
  for node in ${nodeNames[@]}
  do
sed -i "s#${proc}_node_cHHH${node}_${year}_hwwhgg#ggHH_kl_${node}_kt_1_hwwhgg2Qlnu#g" $dir/${dir}.txt
sed -i "s#tth#ttH#g" $dir/${dir}.txt
sed -i "s#vbf#qqH#g" $dir/${dir}.txt
sed -i "s#ggh#ggH#g" $dir/${dir}.txt
sed -i "s#wzh#VH#g" $dir/${dir}.txt
if [ "${node}" == "1" ]
then
echo "xs_HH_cHHH${node}        rateParam ${cat}_${year} ggHH_kl_${node}_kt_1_hwwhgg2Qlnu 31.049" >> $dir/${dir}.txt
elif [ "${node}" == "2p45" ]
then
echo "xs_HH_cHHH${node}        rateParam ${cat}_${year} ggHH_kl_${node}_kt_1_hwwhgg2Qlnu 13.126" >> $dir/${dir}.txt
else
echo "xs_HH_cHHH${node}        rateParam ${cat}_${year} ggHH_kl_${node}_kt_1_hwwhgg2Qlnu 91.174" >> $dir/${dir}.txt
fi
done
done
echo "br_HH_WWgg    rateParam  * ggHH_kl_*_kt_1_hwwhgg2Qlnu 0.000970198" >>$dir/${dir}.txt
echo "br_WW_2Qlnu    rateParam  * ggHH_kl_*_kt_1_hwwhgg2Qlnu 0.441" >>$dir/${dir}.txt
echo "nuisance edit  freeze br_HH_WWgg" >> $dir/${dir}.txt
echo "nuisance edit  freeze br_WW_2Qlnu" >> $dir/${dir}.txt
  for node in ${nodeNames[@]}
  do
echo "nuisance edit  freeze xs_HH_cHHH${node}" >> $dir/${dir}.txt
done
