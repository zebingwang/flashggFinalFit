#!/bin/sh
ulimit -s unlimited
set -e
cd /afs/cern.ch/work/z/zewang/private/flashggfit/CMSSW_10_2_13/src
export SCRAM_ARCH=slc7_amd64_gcc700
source /cvmfs/cms.cern.ch/cmsset_default.sh
eval `scramv1 runtime -sh`
cd /afs/cern.ch/work/z/zewang/private/HZGamma/flashggfinalfit/CMSSW_10_2_13/src/flashggFinalFit/Signal/HZGamma_SigModel_UL_run2_01jet/Combine_results

if [ $1 -eq 0 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.80 -d datacard_allCats.txt -n .Test.POINT.0.80
fi
if [ $1 -eq 1 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.81 -d datacard_allCats.txt -n .Test.POINT.0.81
fi
if [ $1 -eq 2 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.82 -d datacard_allCats.txt -n .Test.POINT.0.82
fi
if [ $1 -eq 3 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.83 -d datacard_allCats.txt -n .Test.POINT.0.83
fi
if [ $1 -eq 4 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.84 -d datacard_allCats.txt -n .Test.POINT.0.84
fi
if [ $1 -eq 5 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.85 -d datacard_allCats.txt -n .Test.POINT.0.85
fi
if [ $1 -eq 6 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.86 -d datacard_allCats.txt -n .Test.POINT.0.86
fi
if [ $1 -eq 7 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.87 -d datacard_allCats.txt -n .Test.POINT.0.87
fi
if [ $1 -eq 8 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.88 -d datacard_allCats.txt -n .Test.POINT.0.88
fi
if [ $1 -eq 9 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.89 -d datacard_allCats.txt -n .Test.POINT.0.89
fi
if [ $1 -eq 10 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.90 -d datacard_allCats.txt -n .Test.POINT.0.90
fi
if [ $1 -eq 11 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.91 -d datacard_allCats.txt -n .Test.POINT.0.91
fi
if [ $1 -eq 12 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.92 -d datacard_allCats.txt -n .Test.POINT.0.92
fi
if [ $1 -eq 13 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.93 -d datacard_allCats.txt -n .Test.POINT.0.93
fi
if [ $1 -eq 14 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.94 -d datacard_allCats.txt -n .Test.POINT.0.94
fi
if [ $1 -eq 15 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.95 -d datacard_allCats.txt -n .Test.POINT.0.95
fi
if [ $1 -eq 16 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.96 -d datacard_allCats.txt -n .Test.POINT.0.96
fi
if [ $1 -eq 17 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.97 -d datacard_allCats.txt -n .Test.POINT.0.97
fi
if [ $1 -eq 18 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.98 -d datacard_allCats.txt -n .Test.POINT.0.98
fi
if [ $1 -eq 19 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 0.99 -d datacard_allCats.txt -n .Test.POINT.0.99
fi
if [ $1 -eq 20 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.00 -d datacard_allCats.txt -n .Test.POINT.1.00
fi
if [ $1 -eq 21 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.01 -d datacard_allCats.txt -n .Test.POINT.1.01
fi
if [ $1 -eq 22 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.02 -d datacard_allCats.txt -n .Test.POINT.1.02
fi
if [ $1 -eq 23 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.03 -d datacard_allCats.txt -n .Test.POINT.1.03
fi
if [ $1 -eq 24 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.04 -d datacard_allCats.txt -n .Test.POINT.1.04
fi
if [ $1 -eq 25 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.05 -d datacard_allCats.txt -n .Test.POINT.1.05
fi
if [ $1 -eq 26 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.06 -d datacard_allCats.txt -n .Test.POINT.1.06
fi
if [ $1 -eq 27 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.07 -d datacard_allCats.txt -n .Test.POINT.1.07
fi
if [ $1 -eq 28 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.08 -d datacard_allCats.txt -n .Test.POINT.1.08
fi
if [ $1 -eq 29 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.09 -d datacard_allCats.txt -n .Test.POINT.1.09
fi
if [ $1 -eq 30 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.10 -d datacard_allCats.txt -n .Test.POINT.1.10
fi
if [ $1 -eq 31 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.11 -d datacard_allCats.txt -n .Test.POINT.1.11
fi
if [ $1 -eq 32 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.12 -d datacard_allCats.txt -n .Test.POINT.1.12
fi
if [ $1 -eq 33 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.13 -d datacard_allCats.txt -n .Test.POINT.1.13
fi
if [ $1 -eq 34 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.14 -d datacard_allCats.txt -n .Test.POINT.1.14
fi
if [ $1 -eq 35 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.15 -d datacard_allCats.txt -n .Test.POINT.1.15
fi
if [ $1 -eq 36 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.16 -d datacard_allCats.txt -n .Test.POINT.1.16
fi
if [ $1 -eq 37 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.17 -d datacard_allCats.txt -n .Test.POINT.1.17
fi
if [ $1 -eq 38 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.18 -d datacard_allCats.txt -n .Test.POINT.1.18
fi
if [ $1 -eq 39 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.19 -d datacard_allCats.txt -n .Test.POINT.1.19
fi
if [ $1 -eq 40 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.20 -d datacard_allCats.txt -n .Test.POINT.1.20
fi
if [ $1 -eq 41 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.21 -d datacard_allCats.txt -n .Test.POINT.1.21
fi
if [ $1 -eq 42 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.22 -d datacard_allCats.txt -n .Test.POINT.1.22
fi
if [ $1 -eq 43 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.23 -d datacard_allCats.txt -n .Test.POINT.1.23
fi
if [ $1 -eq 44 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.24 -d datacard_allCats.txt -n .Test.POINT.1.24
fi
if [ $1 -eq 45 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.25 -d datacard_allCats.txt -n .Test.POINT.1.25
fi
if [ $1 -eq 46 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.26 -d datacard_allCats.txt -n .Test.POINT.1.26
fi
if [ $1 -eq 47 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.27 -d datacard_allCats.txt -n .Test.POINT.1.27
fi
if [ $1 -eq 48 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.28 -d datacard_allCats.txt -n .Test.POINT.1.28
fi
if [ $1 -eq 49 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.29 -d datacard_allCats.txt -n .Test.POINT.1.29
fi
if [ $1 -eq 50 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.30 -d datacard_allCats.txt -n .Test.POINT.1.30
fi
if [ $1 -eq 51 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.31 -d datacard_allCats.txt -n .Test.POINT.1.31
fi
if [ $1 -eq 52 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.32 -d datacard_allCats.txt -n .Test.POINT.1.32
fi
if [ $1 -eq 53 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.33 -d datacard_allCats.txt -n .Test.POINT.1.33
fi
if [ $1 -eq 54 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.34 -d datacard_allCats.txt -n .Test.POINT.1.34
fi
if [ $1 -eq 55 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.35 -d datacard_allCats.txt -n .Test.POINT.1.35
fi
if [ $1 -eq 56 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.36 -d datacard_allCats.txt -n .Test.POINT.1.36
fi
if [ $1 -eq 57 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.37 -d datacard_allCats.txt -n .Test.POINT.1.37
fi
if [ $1 -eq 58 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.38 -d datacard_allCats.txt -n .Test.POINT.1.38
fi
if [ $1 -eq 59 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.39 -d datacard_allCats.txt -n .Test.POINT.1.39
fi
if [ $1 -eq 60 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.40 -d datacard_allCats.txt -n .Test.POINT.1.40
fi
if [ $1 -eq 61 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.41 -d datacard_allCats.txt -n .Test.POINT.1.41
fi
if [ $1 -eq 62 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.42 -d datacard_allCats.txt -n .Test.POINT.1.42
fi
if [ $1 -eq 63 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.43 -d datacard_allCats.txt -n .Test.POINT.1.43
fi
if [ $1 -eq 64 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.44 -d datacard_allCats.txt -n .Test.POINT.1.44
fi
if [ $1 -eq 65 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.45 -d datacard_allCats.txt -n .Test.POINT.1.45
fi
if [ $1 -eq 66 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.46 -d datacard_allCats.txt -n .Test.POINT.1.46
fi
if [ $1 -eq 67 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.47 -d datacard_allCats.txt -n .Test.POINT.1.47
fi
if [ $1 -eq 68 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.48 -d datacard_allCats.txt -n .Test.POINT.1.48
fi
if [ $1 -eq 69 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.49 -d datacard_allCats.txt -n .Test.POINT.1.49
fi
if [ $1 -eq 70 ]; then
  combine --LHCmode LHC-limits --saveToys --saveHybridResult -T 100 --clsAcc 0 --rAbsAcc 0 --freezeParameters MH -M HybridNew -m 125 --singlePoint 1.50 -d datacard_allCats.txt -n .Test.POINT.1.50
fi