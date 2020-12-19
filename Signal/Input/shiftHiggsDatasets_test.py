import ROOT
from ROOT import *

import sys
import os

inDir = sys.argv[1]
outDir = inDir 

mass = ["node_SM"] # radion mass 
for m in mass:
    print "Looking at Radion mass = ", m
    values = [-5,0,5]
    higgs_mass = 125

    ws_name = 'tagsDumper/cms_hgg_13TeV'
    dataset_name = 'ggF_node_cHHH1_WWgg_lnulnugg_13TeV_HHWWggTag_3'
    #  dataset_name1 = 'ggF_node4_WWgg_lnulnugg_13TeV_HHWWggTag_1'
    #temp_ws = TFile(inDir+'testWS.root').Get(ws_name)
    #temp_ws = TFile(inDir+'/Signal_X'+str(m)+'_2_3_new.root').Get(ws_name)
    temp_ws = TFile(inDir+'output_M125_ggF.root').Get(ws_name)
    #temp_ws = TFile('./Signal_Full.root').Get(ws_name)
    # temp_ws.Print()
    for value in values:
        shift = value + higgs_mass
        # dataset = (temp_ws.data(dataset_name)).Clone('h4g_'+str(shift)+'_13TeV_4photons')
        # dataset = (temp_ws.data(dataset_name)).Clone('HHWWgg_'+str(shift)+'_13TeV_')
        dataset1 = (temp_ws.data(dataset_name)).Clone('ggF_'+str(shift)+'_node_cHHH1_WWgg_lnulnugg_13TeV_HHWWggTag_3') # includes process and category 
        dataset1.Print()
        # dataset.changeObservableName('dZ_bdtVtx','dZ')
        # dataset.changeObservableName('dZ_zeroVtx','dZ')
        dataset1.changeObservableName('CMS_hgg_mass','CMS_hgg_mass_old')
        higgs_old = dataset1.get()['CMS_hgg_mass_old']
        higgs_new = RooFormulaVar( 'CMS_hgg_mass', 'CMS_hgg_mass', "(@0+%.1f)"%value,RooArgList(higgs_old) );
        dataset1.addColumn(higgs_new).setRange(105,145)
        dataset1.Print()
        #  dataset2 = (temp_ws.data(dataset_name1)).Clone('ggF_'+str(m)+'_13TeV_HHWWggTag_1_'+str(shift)) # includes process and category
        #  dataset2.Print()
        # dataset.changeObservableName('dZ_bdtVtx','dZ')
        # dataset.changeObservableName('dZ_zeroVtx','dZ')
        #  dataset2.changeObservableName('CMS_hgg_mass','CMS_hgg_mass_old')
        #  higgs_old_2 = dataset2.get()['CMS_hgg_mass_old']
        #  higgs_new_2 = RooFormulaVar( 'CMS_hgg_mass', 'CMS_hgg_mass', "(@0+%.1f)"%value,RooArgList(higgs_old) );
        #  dataset2.addColumn(higgs_new_2).setRange(105,145)
        #  dataset2.Print()
        #output = TFile('/afs/cern.ch/work/t/twamorka/ThesisAnalysis/CMSSW_10_5_0/src/flashgg/testshift.root','RECREATE')
        # output = TFile(inDir+'VtxZero/w_signal_'+str(m)+'_'+str(shift)+'.root','RECREATE')
        # output = TFile('/eos/user/t/twamorka/newCatalog_fixVtx_3Oct2019/hadd_WS/reducedWS/w_signal_'+str(m)+'_'+str(shift)+'.root','RECREATE')
        # output = TFile('/afs/cern.ch/work/a/atishelm/21JuneFlashgg/CMSSW_10_5_0/src/flashgg/fggfinalfit_files/X_signal_'+str(m)+'_'+str(shift)+'_HHWWgg_qqlnu.root','RECREATE')
        output = TFile(outDir + 'Shifted_M'+str(shift)+'_ggF.root','RECREATE')
        output.mkdir("tagsDumper")
        output.cd("tagsDumper")
        # ws_new = ROOT.RooWorkspace("cms_h4g_13TeV_4photons")
        ws_new = ROOT.RooWorkspace("cms_hgg_13TeV")
        getattr(ws_new,'import')(dataset1,RooCmdArg())
        #  print("__________")
        #  getattr(ws_new,'import')(dataset2,RooCmdArg())
	ws_new.Write()
        print("__________")
        output.Close()
        print("__________")
