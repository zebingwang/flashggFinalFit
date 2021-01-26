#!/usr/bin/env python
# -*- coding: utf-8 -*-


import pickle
import pandas as pd
pd.set_option('display.max_columns', 1000000)
pd.set_option('display.max_rows', 1000000)

# 重点是rb和r的区别，rb是打开2进制文件，文本文件用r
f=open('/afs/cern.ch/work/c/chuw/HHWWgg/FinalFit/CMSSW_10_2_13/src/flashggFinalFit/Signal/outdir_HHWWggTest_2017_node_cHHH1/calcPhotonSyst/pkl/HHWWggTag_2.pkl','rb')
data = pickle.load(f)
print(data)
