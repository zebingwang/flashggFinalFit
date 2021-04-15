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
args = parser.parse_args()
tfile = ROOT.TFile("/eos/user/p/pmandrik/HHWWgg_central/January_2021_Production_v2/2016/Signal/FL_LO_2016_hadded/GluGluToHHTo2G2l2nu_"+args.input+"_2016.root")
tfile.cd("tagsDumper/trees")

print ROOT.gDirectory.GetListOfKeys()
for key in ROOT.gDirectory.GetListOfKeys():
    kname=key.GetName()
    print kname


