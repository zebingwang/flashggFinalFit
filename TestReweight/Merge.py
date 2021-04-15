#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
import argparse
from os import environ
import numpy as n
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
from math import *
ROOT.gROOT.SetBatch(True)
parser = argparse.ArgumentParser(description='Copy trees')
parser.add_argument('--input', required=True, type=str, help="Input nodes")
parser.add_argument('--year', required=True, type=str, help="Input nodes")
args = parser.parse_args()
outfile = ROOT.TFile("/eos/user/c/chuw/Reweight/"+args.input+"_"+args.year+".root","RECREATE")
outfile.mkdir("tagsDumper/trees/")
outfile.Close()
tfile = ROOT.TFile("/eos/user/p/pmandrik/HHWWgg_central/January_2021_Production_v2/"+args.year+"/Signal/FL_LO_"+args.year+"_hadded/GluGluToHHTo2G2l2nu_"+args.input+"_"+args.year+".root")
tfile.cd("tagsDumper/trees")
for key in ROOT.gDirectory.GetListOfKeys():
    treename=key.GetName()
    newtreename=treename.replace(args.input,"FL")
    print "old:",treename,"new:",newtreename
    newtreename=treename.replace(args.input,"FL")
    tree = tfile.Get("tagsDumper/trees/"+treename)
    outfile = ROOT.TFile("/eos/user/c/chuw/Reweight/"+args.input+"_"+args.year+".root","UPDATE")
    outfile.cd("tagsDumper/trees/")
    new_tree=tree.CopyTree("((Leading_Photon_pt/CMS_hgg_mass) > 1/3. && (Subleading_Photon_pt/CMS_hgg_mass) > 1/4. ) && dipho_pt > 91")
    new_tree.SetName(newtreename)
    new_tree.Write()
    outfile.Close()

