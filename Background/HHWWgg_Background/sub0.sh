#!/bin/bash
cd /afs/cern.ch/work/c/chuw/HHWWgg/flashggFinalFit/CMSSW_10_2_13/src/flashggFinalFit/Background
eval `scramv1 runtime -sh`
$CMSSW_BASE/src/flashggFinalFit/Background/bin/makeBkgPlots -f SL -b HHWWgg_Background.root -o HHWWgg_Background/BkgPlots_cat0.root -d HHWWgg_Background -c 0 -l "Category 0" --sqrts 13  --intLumi 0.000000  --doBands --massStep 1.000 --nllTolerance 0.050 -L 100 -H 180 --higgsResolution 1.0 --isMultiPdf --useBinnedData
