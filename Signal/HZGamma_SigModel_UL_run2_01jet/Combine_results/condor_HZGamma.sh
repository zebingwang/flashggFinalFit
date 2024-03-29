#!/bin/sh
ulimit -s unlimited
set -e
cd /afs/cern.ch/work/z/zewang/private/flashggfit/CMSSW_10_2_13/src
export SCRAM_ARCH=slc7_amd64_gcc700
source /cvmfs/cms.cern.ch/cmsset_default.sh
eval `scramv1 runtime -sh`
cd /afs/cern.ch/work/z/zewang/private/HZGamma/flashggfinalfit/CMSSW_10_2_13/src/flashggFinalFit/Signal/HZGamma_SigModel_UL_run2_01jet/Combine_results

if [ $1 -eq 0 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.90 -d datacard_allCats.txt -n .Test.POINT.0.90
fi
if [ $1 -eq 1 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.91 -d datacard_allCats.txt -n .Test.POINT.0.91
fi
if [ $1 -eq 2 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.92 -d datacard_allCats.txt -n .Test.POINT.0.92
fi
if [ $1 -eq 3 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.93 -d datacard_allCats.txt -n .Test.POINT.0.93
fi
if [ $1 -eq 4 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.94 -d datacard_allCats.txt -n .Test.POINT.0.94
fi
if [ $1 -eq 5 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.95 -d datacard_allCats.txt -n .Test.POINT.0.95
fi
if [ $1 -eq 6 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.96 -d datacard_allCats.txt -n .Test.POINT.0.96
fi
if [ $1 -eq 7 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.97 -d datacard_allCats.txt -n .Test.POINT.0.97
fi
if [ $1 -eq 8 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.98 -d datacard_allCats.txt -n .Test.POINT.0.98
fi
if [ $1 -eq 9 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.99 -d datacard_allCats.txt -n .Test.POINT.0.99
fi
if [ $1 -eq 10 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.00 -d datacard_allCats.txt -n .Test.POINT.1.00
fi
if [ $1 -eq 11 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.01 -d datacard_allCats.txt -n .Test.POINT.1.01
fi
if [ $1 -eq 12 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.02 -d datacard_allCats.txt -n .Test.POINT.1.02
fi
if [ $1 -eq 13 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.03 -d datacard_allCats.txt -n .Test.POINT.1.03
fi
if [ $1 -eq 14 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.04 -d datacard_allCats.txt -n .Test.POINT.1.04
fi
if [ $1 -eq 15 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.05 -d datacard_allCats.txt -n .Test.POINT.1.05
fi
if [ $1 -eq 16 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.06 -d datacard_allCats.txt -n .Test.POINT.1.06
fi
if [ $1 -eq 17 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.07 -d datacard_allCats.txt -n .Test.POINT.1.07
fi
if [ $1 -eq 18 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.08 -d datacard_allCats.txt -n .Test.POINT.1.08
fi
if [ $1 -eq 19 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.09 -d datacard_allCats.txt -n .Test.POINT.1.09
fi
if [ $1 -eq 20 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.10 -d datacard_allCats.txt -n .Test.POINT.1.10
fi
if [ $1 -eq 21 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.11 -d datacard_allCats.txt -n .Test.POINT.1.11
fi
if [ $1 -eq 22 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.12 -d datacard_allCats.txt -n .Test.POINT.1.12
fi
if [ $1 -eq 23 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.13 -d datacard_allCats.txt -n .Test.POINT.1.13
fi
if [ $1 -eq 24 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.14 -d datacard_allCats.txt -n .Test.POINT.1.14
fi
if [ $1 -eq 25 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.15 -d datacard_allCats.txt -n .Test.POINT.1.15
fi
if [ $1 -eq 26 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.16 -d datacard_allCats.txt -n .Test.POINT.1.16
fi
if [ $1 -eq 27 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.17 -d datacard_allCats.txt -n .Test.POINT.1.17
fi
if [ $1 -eq 28 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.18 -d datacard_allCats.txt -n .Test.POINT.1.18
fi
if [ $1 -eq 29 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.19 -d datacard_allCats.txt -n .Test.POINT.1.19
fi
if [ $1 -eq 30 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.20 -d datacard_allCats.txt -n .Test.POINT.1.20
fi
if [ $1 -eq 31 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.21 -d datacard_allCats.txt -n .Test.POINT.1.21
fi
if [ $1 -eq 32 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.22 -d datacard_allCats.txt -n .Test.POINT.1.22
fi
if [ $1 -eq 33 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.23 -d datacard_allCats.txt -n .Test.POINT.1.23
fi
if [ $1 -eq 34 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.24 -d datacard_allCats.txt -n .Test.POINT.1.24
fi
if [ $1 -eq 35 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.25 -d datacard_allCats.txt -n .Test.POINT.1.25
fi
if [ $1 -eq 36 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.26 -d datacard_allCats.txt -n .Test.POINT.1.26
fi
if [ $1 -eq 37 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.27 -d datacard_allCats.txt -n .Test.POINT.1.27
fi
if [ $1 -eq 38 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.28 -d datacard_allCats.txt -n .Test.POINT.1.28
fi
if [ $1 -eq 39 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.29 -d datacard_allCats.txt -n .Test.POINT.1.29
fi
if [ $1 -eq 40 ]; then
  combine --LHCmode LHC-significance --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.30 -d datacard_allCats.txt -n .Test.POINT.1.30
fi