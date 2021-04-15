#!/usr/bin/env bash
eval `scramv1 runtime -sh`
source ../setup.sh
cats="HHWWggTag_SLDNN_0,HHWWggTag_SLDNN_1,HHWWggTag_SLDNN_2,HHWWggTag_SLDNN_3"
ext="SL"
python RunPackager.py --cats ${cats} --exts ${ext}_${1}_2016_single_Higgs,${ext}_${1}_2017_single_Higgs,${ext}_${1}_2018_single_Higgs --mergeYears --batch local  --massPoints 125
years=("2016" "2017" "2018")
catNames=(${cats//,/ })
  for cat in ${catNames[@]}
do
  if [ "${cat}" = HHWWggTag_SLDNN_0 ]
  then
  python RunPlotter.py --procs all --years 2017,2018 --cats HHWWggTag_SLDNN_0 --ext packaged --HHWWggLabel ${ext}_${1}
  else
  python RunPlotter.py --procs all --years 2016,2017,2018 --cats $cat --ext packaged --HHWWggLabel ${ext}_${1}
  fi
for year in ${years[@]}
do
  if [ "$year" = 2016 -a "${cat}" = HHWWggTag_SLDNN_0 ] 
  then
    continue
  else
python RunPlotter.py --procs all --years $year --cats $cat --ext packaged --HHWWggLabel ${ext}_${1}
python RunPlotter.py --procs all --years $year --cats all --ext packaged --HHWWggLabel ${ext}_${1}
  fi
done
done
# python RunPlotter.py --procs all --years 2016,2017,2018 --cats all --ext packaged --HHWWggLabel ${ext}_${1}
# mv ./outdir_packaged ./outdir_packaged_${ext}_${1}

