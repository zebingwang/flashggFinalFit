#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import argparse
from os import environ
import numpy as np
from ROOT import TH1F, TFile, TCanvas, THStack
from ROOT import gStyle
import ROOT
from ROOT import gROOT, TChain, TH1F, kBlue, kRed, TLegend, TCanvas
from array import array
import operator
import math
import sys
import os
import argparse
import random
import pandas as pd
from math import *
from root_numpy import root2array, tree2array,array2tree
ROOT.gROOT.SetBatch(True)
parser = argparse.ArgumentParser(description='Copy trees')
parser.add_argument('--input', required=True, type=str, help="Input nodes")
parser.add_argument('--year', required=True, type=str, help="Input nodes")
args = parser.parse_args()
#  Benchmark=args.input
benchname=args.input
#  if "NLO" in Benchmark:
    #  benchname=Benchmark.replace("NLO_","_")
#  else:
    #  benchname=Benchmark.replace("LO_","_")
#  print benchname
outfile = ROOT.TFile("/eos/user/c/chuw/Reweight/GluGluToHHTo2G2l2nu_node_"+benchname+"_13TeV_HHWWggTag_2_"+args.year+".root","RECREATE")
outfile.mkdir("tagsDumper/trees")
outfile.Close()
tfile = ROOT.TFile("/eos/user/c/chuw/Reweight/LO_Samples_"+args.year+".root")
tfile.cd("tagsDumper/trees")
for key in ROOT.gDirectory.GetListOfKeys():
    treename=key.GetName()
    print key.GetName()
    tree = tfile.Get("tagsDumper/trees/"+treename)
    print tree.GetEntries()
    outfile = ROOT.TFile("/eos/user/c/chuw/Reweight/GluGluToHHTo2G2l2nu_node_"+benchname+"_13TeV_HHWWggTag_2_"+args.year+".root","UPDATE")
    outfile.cd("tagsDumper/trees")
    data_arr = tree2array(tree=tree)   
    names = list(data_arr.dtype.names)
    i=0
    index=[]
    for name in enumerate(names):
        #  print name,i
        if "pdfWeights" in name or "alphaSWeights" in name or "scaleWeights" in name :
            #  print "Need remove"
            index.append(i)
        i+=1
    #  print index[0]
    #  print index[len(index)-1]
    if ( len(index) != 0):
        endnum=index[len(index)-1]+1
        del names[index[0]:endnum]
    #  print names
    #  print data_arr.dtype.names
    new_data_arr =data_arr[names]
    #  print new_data_arr.dtype.names
    data = pd.DataFrame(new_data_arr)
    data["new_weight"]=data.weight*data["weight_"+args.input]/12
    data.drop('weight',axis=1, inplace=True)
    data.rename(columns={'new_weight':'weight'},inplace=True)
    newArr = data.to_records(index=False)
    newtree=array2tree(newArr)
    newtreename=treename.replace("FL","node_"+benchname)
    newtreename2=newtreename.replace("HHWWggTag_2","HHWWggTag_FL_0")
    print "new:",newtreename2
    newtree.SetName(newtreename2)
    newtree.Write("",ROOT.TObject.kOverwrite)
    outfile.Close()

