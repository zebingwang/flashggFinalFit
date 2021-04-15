#!/usr/bin/env bash
eval `scramv1 runtime -sh`
source ../setup.sh
cats="HHWWggTag_FL_0"
ext="FL"
node="NLO_2"
python RunPackager.py --cats ${cats} --exts ${ext}_2016_node_${node},${ext}_2017_node_${node},${ext}_2018_node_${node}, --mergeYears --batch local  --massPoints 125
years=("2016" "2017" "2018")
catNames=(${cats//,/ })
rm -rf ./outdir_packaged_$ext
for year in ${years[@]}
do
  for cat in ${catNames[@]}
do
python RunPlotter.py --procs all --years $year --cats $cat --ext packaged --HHWWggLabel $ext
python RunPlotter.py --procs all --years 2016,2017,2018 --cats $cat --ext packaged --HHWWggLabel $ext
done
done
python RunPlotter.py --procs all --years 2016,2017,2018 --cats all --ext packaged --HHWWggLabel $ext
mv ./outdir_packaged ./outdir_packaged_${ext}_${node}

