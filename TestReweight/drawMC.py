#!/usr/bin/python
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

def drawHisto(h1,h2,name,var):

   #gStyle.SetOptStat(0000)
   name = os.path.join('inVarPlots/',name)

   h1.SetMarkerStyle(20)
   h1.SetMarkerColor(kBlue)
   h1.SetLineColor(kBlue)
   h1.SetLineWidth(2)
   h2.SetMarkerStyle(20)
   h2.SetMarkerColor(kRed)
   h2.SetLineColor(kRed)
   h2.SetLineWidth(2)

   h1.GetXaxis().SetTitle(var)
   h1.Scale(41.5)
   if h1.Integral()!=0 and h2.Integral()!=0: h2.Scale(h1.Integral()/h2.Integral())
   h2.GetXaxis().SetTitle(var)

   leg = TLegend(0.455,0.85,0.76,0.89,"","brNDC")
   leg.SetBorderSize(0)
   leg.SetTextSize(0.035)
   leg.SetFillColor(0)
   leg.SetNColumns(2)
   leg.AddEntry(h1, "w/ weights", "L")
   leg.AddEntry(h2, "w/o weights", "L")

   maximum = h1.GetMaximum()
   if h2.GetMaximum()>=maximum:
      maximum = h2.GetMaximum()

   maximum *=1.01

   h2.GetYaxis().SetRangeUser(0.,maximum)
   c = TCanvas()
   h2.Draw("HIST")
   h1.Draw("HIST,same")
   leg.Draw("same")
   c.SaveAs(name+".png","png")
   c.SaveAs(name+".pdf","pdf")

   h2.GetYaxis().SetRangeUser(0.001,maximum*5.)
   c.SetLogy()
   h2.Draw("HIST")
   h1.Draw("HIST,same")
   leg.Draw("same")
   c.SaveAs(name+"_log.png","png")
   c.SaveAs(name+"_log.pdf","pdf")

if __name__ == '__main__':

  gROOT.SetBatch(1)


  #fill trees
  print("\n--- ############################################################# ---")
  hs = THStack("hs","Leading Lepton pt");
  output = ROOT.TFile("Distribute.root","RECREATE")
  output.Close()
  keys=['HH','bckg']
  for key in keys :
      print('key: ', key)
      if 'HH' in key:
          sampleNames=key
          subdir_name = 'Signal'
          fileNames = [
          'Signal_2017'
          ]
          target=1
      else:
          sampleNames = key
          subdir_name = 'Backgrounds'
          fileNames = [
              # FH File Names
              'DiPhotonJetsBox_M40_80_2017',
              'DiPhotonJetsBox_MGG-80toInf_13TeV_2017',
              'TTGG_0Jets_TuneCP5_13TeV_2017',
              'DYJetsToLL_M-50_TuneCP5_13TeV_2017',
              'ttHJetToGG_M125_13TeV_2017',
              'VBFHToGG_M125_13TeV_2017',
              'GluGluHToGG_M125_TuneCP5_13TeV_2017',
              'VHToGG_M125_13TeV_2017',
              'DiPhotonJetsBox_M40_80_2016',
              'DiPhotonJetsBox_MGG-80toInf_13TeV_2016',
              'TTGG_0Jets_TuneCP5_13TeV_2016',
              'DYJetsToLL_M-50_TuneCP5_13TeV_2016',
              'ttHJetToGG_M125_13TeV_2016',
              'VBFHToGG_M125_13TeV_2016',
              'GluGluHToGG_M125_TuneCP5_13TeV_2016',
              'VHToGG_M125_13TeV_2016',
              'DiPhotonJetsBox_M40_80_2018',
              'DiPhotonJetsBox_MGG-80toInf_13TeV_2018',
              'TTGG_0Jets_TuneCP5_13TeV_2018',
              'DYJetsToLL_M-50_TuneCP5_13TeV_2018',
              'ttHJetToGG_M125_13TeV_2018',
              'VBFHToGG_M125_13TeV_2018',
              'GluGluHToGG_M125_TuneCP5_13TeV_2018',
              'VHToGG_M125_13TeV_2018'
          ]
          target=0

      for filen in fileNames:
          if 'Signal' in filen:
              treename=['GluGluToHHTo2G2l2nu_node_cHHH1_13TeV_HHWWggTag_2']
              process_ID = 'HH'
          elif 'GluGluToHHTo2G4Q_node_cHHH1_2018' in filen:
              treename=['GluGluToHHTo2G4Q_node_cHHH1_13TeV_HHWWggTag_1']
              process_ID = 'HH'
          elif 'GluGluHToGG' in filen:
              treename=['ggh_125_13TeV_HHWWggTag_2']
              process_ID = 'Hgg'
          elif 'VBFHToGG' in filen:
              treename=['vbf_125_13TeV_HHWWggTag_2']
              process_ID = 'Hgg'
          elif 'VHToGG' in filen:
              treename=['wzh_125_13TeV_HHWWggTag_2']
              process_ID = 'Hgg'
          elif 'ttHJetToGG' in filen:
              treename=['tth_125_13TeV_HHWWggTag_2']
              process_ID = 'Hgg'
          elif 'DiPhotonJetsBox_M40_80' in filen:
              treename=['DiPhotonJetsBox_M40_80_Sherpa_13TeV_HHWWggTag_2',
              ]
              process_ID = 'DiPhoton'
          elif 'DiPhotonJetsBox_MGG-80toInf' in filen:
              treename=['DiPhotonJetsBox_MGG_80toInf_13TeV_Sherpa_13TeV_HHWWggTag_2',
              ]
              process_ID = 'DiPhoton'
          elif 'GJet_Pt-20to40' in filen:
              treename=['GJet_Pt_20to40_DoubleEMEnriched_MGG_80toInf_TuneCP5_13TeV_Pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'GJet'
          elif 'GJet_Pt-20toInf' in filen:
              treename=['GJet_Pt_20toInf_DoubleEMEnriched_MGG_40to80_TuneCP5_13TeV_Pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'GJet'
          elif 'GJet_Pt-40toInf' in filen:
              treename=['GJet_Pt_40toInf_DoubleEMEnriched_MGG_80toInf_TuneCP5_13TeV_Pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'GJet'
          elif 'QCD_Pt-30to40' in filen:
              treename=['QCD_Pt_30to40_DoubleEMEnriched_MGG_80toInf_TuneCP5_13TeV_Pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'QCD'
          elif 'QCD_Pt-30toInf' in filen:
              treename=['QCD_Pt_30toInf_DoubleEMEnriched_MGG_40to80_TuneCP5_13TeV_Pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'QCD'
          elif 'QCD_Pt-40toInf' in filen:
              treename=['QCD_Pt_40toInf_DoubleEMEnriched_MGG_80toInf_TuneCP5_13TeV_Pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'QCD'
          elif 'DYJetsToLL_M-50_TuneCP5_13TeV_2016' in filen:
              treename=['DYJetsToLL_M_50_TuneCUETP8M1_13TeV_amcatnloFXFX_pythia8_13TeV_HHWWggTag_2',
              ]
              process_ID = 'DY'
          elif 'DYJetsToLL_M-50' in filen:
              treename=['DYJetsToLL_M_50_TuneCP5_13TeV_amcatnloFXFX_pythia8_13TeV_HHWWggTag_2',
              ]
              process_ID = 'DY'
          elif 'TTGG_0Jets_TuneCP5_13TeV_2016' in filen:
              treename=['TTGG_0Jets_TuneCUETP8M1_13TeV_amcatnlo_madspin_pythia8_13TeV_HHWWggTag_2',
              ]
              process_ID = 'TTGsJets'
          elif 'TTGG_0Jets_TuneCP5_13TeV_2018' in filen:
              treename=['TTGG_0Jets_TuneCP5_13TeV_amcatnlo_madspin_pythia8_13TeV_HHWWggTag_2',
              ]
              process_ID = 'TTGsJets'
          elif 'TTGG_0Jets' in filen:
              treename=['TGG_0Jets_TuneCP5_13TeV_amcatnlo_madspin_pythia8_13TeV_HHWWggTag_2',
              ]
              process_ID = 'TTGsJets'
          elif 'TTGJets_TuneCP5' in filen:
              treename=['TTGJets_TuneCP5_13TeV_amcatnloFXFX_madspin_pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'TTGsJets'
          elif 'TTJets_HT-600to800' in filen:
              treename=['TTJets_HT_600to800_TuneCP5_13TeV_madgraphMLM_pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'TTGsJets'
          elif 'TTJets_HT-800to1200' in filen:
              treename=['TTJets_HT_800to1200_TuneCP5_13TeV_madgraphMLM_pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'TTGsJets'
          elif 'TTJets_HT-1200to2500' in filen:
              treename=['TTJets_HT_1200to2500_TuneCP5_13TeV_madgraphMLM_pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'TTGsJets'
          elif 'TTJets_HT-2500toInf' in filen:
              treename=['TTJets_HT_2500toInf_TuneCP5_13TeV_madgraphMLM_pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'TTGsJets'
          elif 'ttWJets' in filen:
              treename=['ttWJets_TuneCP5_13TeV_madgraphMLM_pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'TTGsJets'
          elif 'TTJets_TuneCP5' in filen:
              treename=['TTJets_TuneCP5_13TeV_amcatnloFXFX_pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'TTGsJets'
          elif 'W1JetsToLNu_LHEWpT_0-50' in filen:
              treename=['W1JetsToLNu_LHEWpT_0_50_TuneCP5_13TeV_amcnloFXFX_pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'WGsJets'
          elif 'W1JetsToLNu_LHEWpT_50-150' in filen:
              treename=['W1JetsToLNu_LHEWpT_50_150_TuneCP5_13TeV_amcnloFXFX_pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'WGsJets'
          elif 'W1JetsToLNu_LHEWpT_150-250' in filen:
              treename=['W1JetsToLNu_LHEWpT_150_250_TuneCP5_13TeV_amcnloFXFX_pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'WGsJets'
          elif 'W1JetsToLNu_LHEWpT_250-400' in filen:
              treename=['W1JetsToLNu_LHEWpT_250_400_TuneCP5_13TeV_amcnloFXFX_pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'WGsJets'
          elif 'W1JetsToLNu_LHEWpT_400-inf' in filen:
              treename=['W1JetsToLNu_LHEWpT_400_inf_TuneCP5_13TeV_amcnloFXFX_pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'WGsJets'
          elif 'W2JetsToLNu_LHEWpT_0-50' in filen:
              treename=['W2JetsToLNu_LHEWpT_0_50_TuneCP5_13TeV_amcnloFXFX_pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'WGsJets'
          elif 'W2JetsToLNu_LHEWpT_50-150' in filen:
              treename=['W2JetsToLNu_LHEWpT_50_150_TuneCP5_13TeV_amcnloFXFX_pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'WGsJets'
          elif 'W2JetsToLNu_LHEWpT_150-250' in filen:
              treename=['W2JetsToLNu_LHEWpT_150_250_TuneCP5_13TeV_amcnloFXFX_pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'WGsJets'
          elif 'W2JetsToLNu_LHEWpT_250-400' in filen:
              treename=['W2JetsToLNu_LHEWpT_250_400_TuneCP5_13TeV_amcnloFXFX_pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'WGsJets'
          elif 'W2JetsToLNu_LHEWpT_400-inf' in filen:
              treename=['W2JetsToLNu_LHEWpT_400_inf_TuneCP5_13TeV_amcnloFXFX_pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'WGsJets'
          elif 'W3JetsToLNu' in filen:
              treename=['W3JetsToLNu_TuneCP5_13TeV_madgraphMLM_pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'WGsJets'
          elif 'W4JetsToLNu' in filen:
              treename=['W4JetsToLNu_TuneCP5_13TeV_madgraphMLM_pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'WGsJets'
          elif 'WGGJets' in filen:
              treename=['WGGJets_TuneCP5_13TeV_madgraphMLM_pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'WGsJets'
          elif 'WGJJToLNuGJJ_EWK' in filen:
              treename=['WGJJToLNuGJJ_EWK_aQGC_FS_FM_TuneCP5_13TeV_madgraph_pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'WGsJets'
          elif 'WGJJToLNu_EWK_QCD' in filen:
              treename=['WGJJToLNu_EWK_QCD_TuneCP5_13TeV_madgraph_pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'WGsJets'
          elif 'WWTo1L1Nu2Q' in filen:
              treename=['WWTo1L1Nu2Q_13TeV_amcatnloFXFX_madspin_pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'WW'
          elif 'WW_TuneCP5' in filen:
              treename=['WW_TuneCP5_13TeV_pythia8_13TeV_HHWWggTag_1',
              ]
              process_ID = 'WW'

          fileName = os.path.join(subdir_name,filen)
          inputPath="./InputFiles/"
          filename_fullpath = inputPath+"/"+fileName+".root"
          tfile = ROOT.TFile(filename_fullpath)
          hs_weighted = THStack("hs_weighted","");
          print "file name is :",filen
          i=0
          for tname in treename:
              i+3
              #  if( "HH" not in tname):
              if 'node' in tname:
                  print tname
              else:
                  print "tree name is :",tname
                  ch_0 = tfile.Get("tagsDumper/trees/"+tname)
                  hist= TH1F(filen+"_weighted",tname+"weighted",100,0,1000)
                  hist_unweighted= TH1F(filen+"_unweighted",tname+"weighted",100,0,1000)
                  ch_0.Project(filen+"_unweighted","Leading_lepton_pt","1*( (Leading_Photon_pt/CMS_hgg_mass) > 1/3. && (Subleading_Photon_pt/CMS_hgg_mass) > 1/4. )")
                  ch_0.Project(filen+"_weighted","Leading_lepton_pt","weight*( (Leading_Photon_pt/CMS_hgg_mass) > 1/3. && (Subleading_Photon_pt/CMS_hgg_mass) > 1/4. )")
                  #  hist.SetFillColor(50)
                  print hist.Integral()
                  print hist.GetEntries()
                  #  ch_0.Project(tname+"_unweighted","Leading_lepton_pt","1*( (Leading_Photon_pt/CMS_hgg_mass) > 1/3. && (Subleading_Photon_pt/CMS_hgg_mass) > 1/4. )")
                  hs.Add(hist)
                  c2 = TCanvas('c2','test',10,10,2400,1800)
                  #  c2.Divide(3,1)
                  #  c2.cd(1)
                  hist.Draw("hist")
                  #  c2.cd(2)
                  #  hs.Draw("hist")
                  #  c2.cd(3)
                  #  hs.Add(hist)
                  c2.SaveAs(filen+".png")
                  out=TFile.Open("Distribute.root","UPDATE")
                  hist.Write()
                  hist_unweighted.Write()
                  out.Close()

      c1 = TCanvas('c1','test',10,10,800,600)
      hs.Draw("pfc nostack hist")
      c1.SaveAs("test.png")
              #  hs_weighted.Add(tname+"_weighted")

