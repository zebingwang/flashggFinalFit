#!/bin/bash
echo "Starting job"
echo "copying proxy file to /tmp area"
echo "start running"

cmssw-el7

cd /afs/cern.ch/work/z/zewang/private/HZGamma/flashggfinalfit/CMSSW_10_2_13/src/flashggFinalFit/ZGCoreShape
cmsenv

python CreatCoreFunction_01jet_NAFCorr.py

echo "running done"