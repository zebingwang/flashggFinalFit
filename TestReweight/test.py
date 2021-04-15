#!/usr/bin/env python
# -*- coding: utf-8 -*-
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
parser = argparse.ArgumentParser(description='Deploy keras model.')
parser.add_argument('--input', required=True, type=str, help="Input Keras model (hdf5)")
args = parser.parse_args()
tfile = ROOT.TFile("/eos/user/c/chuw/Reweight/GluGluToHHTo2G2l2nu_node_NLO_7_13TeV_HHWWggTag_2_2018.root")
#  SM_tfile = ROOT.TFile("/eos/user/a/atishelm/ntuples/HHWWgg_flashgg/January_2021_Production/2017/Signal/FL_NLO_2017_hadded/GluGluToHHTo2G2l2nu_node_cHHH1_2017.root")
SM_tfile = ROOT.TFile("/eos/user/a/atishelm/ntuples/HHWWgg_flashgg/January_2021_Production/2018/Signal/FL_NLO_2018_hadded/GluGluToHHTo2G2l2nu_node_cHHH1_2018.root")
tree = tfile.Get("tagsDumper/trees/GluGluToHHTo2G2l2nu_node_NLO_7_13TeV_HHWWggTag_FL_0")
SM_tree = SM_tfile.Get("tagsDumper/trees/GluGluToHHTo2G2l2nu_node_cHHH1_13TeV_HHWWggTag_2")
hist_unreweight= TH1F("hist_unreweight","hist_unreweight",80,100,180)
hist_reweighted= TH1F("hist_reweighted","hist_reweighted",80,100,180)
hist_SM= TH1F("hist_SM","hist_SM",80,100,180)
tree.Project("hist_unreweight","CMS_hgg_mass","weight")
SM_tree.Project("hist_SM","CMS_hgg_mass","weight*(((Leading_Photon_pt/CMS_hgg_mass) > 1/3. && (Subleading_Photon_pt/CMS_hgg_mass) > 1/4. ) && dipho_pt >91)")
tree.Project("hist_reweighted","CMS_hgg_mass","weight_"+args.input+"*weight")
hist_unreweight_MHH= TH1F("hist_unreweight_MHH","hist_unreweight_MHH",500,0,1500)
hist_reweighted_MHH= TH1F("hist_reweighted_MHH","hist_reweighted_MHH",500,0,1500)
hist_SM_MHH= TH1F("hist_SM_MHH","hist_SM",500,0,1500)
tree.Project("hist_unreweight_MHH","genMhh","weight")
SM_tree.Project("hist_SM_MHH","genMhh","weight*(((Leading_Photon_pt/CMS_hgg_mass) > 1/3. && (Subleading_Photon_pt/CMS_hgg_mass) > 1/4. ) && dipho_pt >91)")
tree.Project("hist_reweighted_MHH","genMhh","weight_"+args.input+"*weight")

hist_SM.SetLineColor(1)
hist_unreweight.SetLineColor(2)
hist_reweighted.SetLineColor(3)
hist_SM.SetMarkerColor(1)
hist_unreweight.SetMarkerColor(2)
hist_reweighted.SetMarkerColor(3)
hist_SM_MHH.SetLineColor(1)
hist_unreweight_MHH.SetLineColor(2)
hist_reweighted_MHH.SetLineColor(3)
hist_SM_MHH.SetMarkerColor(1)
hist_unreweight_MHH.SetMarkerColor(2)
hist_reweighted_MHH.SetMarkerColor(3)

maximum=max(max(hist_unreweight.GetMaximum(),hist_reweighted.GetMaximum()),hist_SM.GetMaximum())
maximum_MHH=max(max(hist_unreweight_MHH.GetMaximum(),hist_reweighted_MHH.GetMaximum()),hist_SM_MHH.GetMaximum())
hist_unreweight.GetYaxis().SetRangeUser(0.,maximum*1.1)
hist_unreweight_MHH.GetYaxis().SetRangeUser(0.,maximum_MHH*1.1)
legend=TLegend(0.5,0.6,0.9,0.9)
legend2=TLegend(0.6,0.6,0.9,0.9)
print "Original yield:",hist_unreweight.Integral()
print "Reweighted_yield:",hist_reweighted.Integral()
print "SM_yield:",hist_SM.Integral()
print "SF:",hist_unreweight.Integral()/hist_SM.Integral()
c1 = TCanvas('c1','DiPhoton Mass',10,10,800,600)
c1.Divide(1,2)
#  ROOT.gStyle.SetOptFit(111)
hist_unreweight.SetStats(0)
c1.cd(1)
hist_unreweight.Draw()
hist_SM.Draw("same")
hist_reweighted.Draw("same")
hist_unreweight.Fit('gaus',"R","",121,128)
hist_reweighted.Fit('gaus',"R","",121,128)
hist_SM.Fit('gaus',"R","",121,128)
hist_SM.GetFunction("gaus").SetLineColor(1)
print "Resolution Difference:",(hist_reweighted.GetFunction("gaus").GetParameter(2)-hist_SM.GetFunction("gaus").GetParameter(2))/hist_reweighted.GetFunction("gaus").GetParameter(2)
hist_unreweight.GetFunction("gaus").SetLineColor(2)
hist_reweighted.GetFunction("gaus").SetLineColor(3)
legend.AddEntry(hist_unreweight,"12 nodes Fit Mean:"+str(hist_unreweight.GetFunction("gaus").GetParameter(1))+" Sigma:"+str(hist_unreweight.GetFunction("gaus").GetParameter(2)),"p")
legend.AddEntry(hist_reweighted,"12 nodes  reweight to "+ args.input+" Fit Mean:"+str(hist_reweighted.GetFunction("gaus").GetParameter(1))+" Sigma:"+str(hist_reweighted.GetFunction("gaus").GetParameter(2)),"p")
legend.AddEntry(hist_SM,"node cHHH1 Fit Mean:"+str(hist_SM.GetFunction("gaus").GetParameter(1))+" Sigma:"+str(hist_SM.GetFunction("gaus").GetParameter(2)) ,"p")
legend.Draw("same")
c1.cd(2)
legend2.AddEntry(hist_unreweight,"12 nodes ","l")
legend2.AddEntry(hist_reweighted,"12 nodes  reweight to "+ args.input,"l")
legend2.AddEntry(hist_SM,"node cHHH1","l")
hist_unreweight_MHH.SetStats(0)
hist_unreweight_MHH.Draw("E")
legend2.Draw("same")
hist_SM_MHH.Draw("E,same")
hist_reweighted_MHH.Draw("E,same")

c1.SaveAs("test.pdf","pdf")
