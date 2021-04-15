#!/usr/bin/env bash
eval `scramv1 runtime -sh`
source ../setup.sh
cats="HHWWggTag_FH_0"
ext="FH"
python RunPackager.py --cats ${cats} --exts ${ext}_${1}_2016_single_Higgs,${ext}_${1}_2017_single_Higgs,${ext}_${1}_2018_single_Higgs --mergeYears --batch local  --massPoints 125
years=("2016" "2017" "2018")
catNames=(${cats//,/ })
for year in ${years[@]}
do
  for cat in ${catNames[@]}
do
python RunPlotter.py --procs all --years $year --cats $cat --ext packaged --HHWWggLabel ${ext}_${1}
python RunPlotter.py --procs all --years 2016,2017,2018 --cats $cat --ext packaged --HHWWggLabel ${ext}_${1}
done
done
python RunPlotter.py --procs all --years 2016,2017,2018 --cats all --ext packaged --HHWWggLabel ${ext}_${1}
mv ./outdir_packaged ./outdir_packaged_${ext}_${1}

