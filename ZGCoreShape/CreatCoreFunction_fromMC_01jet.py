import ROOT as rt
import os

datafile_path = "./data_fromMC_01jet.root"
Corefile_path = "./ZGCoreShape_fromMC_01jet_v4.root"
if os.path.exists(datafile_path):
    f = rt.TFile(datafile_path)
    w = f.Get("w")
    w.Print()
    data = {}
    MC = {}
    for cat in ["data_cat0", "data_cat1", "data_cat2", "data_cat3", "data_allcat"]:
        data[cat] = w.data("{}".format(cat))
    for cat in ["MC_cat0", "MC_cat1", "MC_cat2", "MC_cat3", "MC_allcat"]:
        MC[cat] = w.data("{}".format(cat))

    H_mass = w.var("CMS_hzg_mass")
else:
    file_path = "/eos/user/z/zewang/HZGamma_data/run2UL_data_Normalizing"
    MC_filename = ["ZGToLLG_zero_to_one_jet.root", "DYJets_zero_to_one_jet_2016postVFP.root", "DYJets_zero_to_one_jet_2016preVFP.root", "DYJets_zero_to_one_jet_2017.root", "DYJets_zero_to_one_jet_2018.root"]
    #ZG_file_name = "/eos/user/z/zewang/HZGamma_data/run2UL_data_Normalizing/ZGToLLG_zero_to_one_jet_NAF.root"
    data_file_name = "data_zero_to_one_jet.root"
    tree_name = "zero_to_one_jet"
    bdt_boundaries = [[0.28379330039024353, 0.4557725191116333], [0.4557725191116333, 0.5796570777893066], [0.5796570777893066, 0.7069960236549377], [0.7069960236549377, 1.]]
    n_cat = len(bdt_boundaries)

    H_mass = rt.RooRealVar("CMS_hzg_mass", "CMS_hzg_mass", 125., 100., 180.)
    CMS_hzg_weight = rt.RooRealVar("CMS_hzg_weight","CMS_hzg_weight",-100000,1000000)

    ArgSet = rt.RooArgSet("args")
    ArgSet.add(H_mass)
    ArgSet.add(CMS_hzg_weight)

    MC = {}
    MC["MC_allcat"] = rt.RooDataSet("MC_allcat","MC_allcat", ArgSet, "CMS_hzg_weight")
    for icat in range(n_cat):
        MC["MC_cat{}".format(icat)] = rt.RooDataSet("MC_cat{}".format(icat),"MC_cat{}".format(icat), ArgSet, "CMS_hzg_weight")

    for file in MC_filename:

        MC_file = rt.TFile.Open("{}/{}".format(file_path, file))
        MC_tree = MC_file.Get(tree_name)

        for jentry in range(MC_tree.GetEntriesFast()):
            nb = MC_tree.GetEntry(jentry)

            if MC_tree.H_mass<=100. or MC_tree.H_mass>=200.: continue
            if MC_tree.regions != 0: continue
            if MC_tree.Z_mass>=100. or MC_tree.Z_mass<=80.: continue
            if (MC_tree.Z_mass + MC_tree.H_mass) <= 185: continue

            H_mass.setVal(MC_tree.H_mass)
            if "2017" in file:
                CMS_hzg_weight.setVal(MC_tree.weight/abs(MC_tree.weight)*1.916218)
            elif "2018" in file:
                CMS_hzg_weight.setVal(MC_tree.weight/abs(MC_tree.weight)*2.7634974)
            else:
                CMS_hzg_weight.setVal(MC_tree.weight)
            
            MC["MC_allcat"].add(ArgSet,CMS_hzg_weight.getVal())
            if MC_tree.BDT_score > bdt_boundaries[0][0] and MC_tree.BDT_score <= bdt_boundaries[0][1]:
                MC["MC_cat0"].add(ArgSet,CMS_hzg_weight.getVal())
            elif MC_tree.BDT_score > bdt_boundaries[1][0] and MC_tree.BDT_score <= bdt_boundaries[1][1]:
                MC["MC_cat1"].add(ArgSet,CMS_hzg_weight.getVal())
            elif MC_tree.BDT_score > bdt_boundaries[2][0] and MC_tree.BDT_score <= bdt_boundaries[2][1]:
                MC["MC_cat2"].add(ArgSet,CMS_hzg_weight.getVal())
            elif MC_tree.BDT_score > bdt_boundaries[3][0] and MC_tree.BDT_score <= bdt_boundaries[3][1]:
                MC["MC_cat3"].add(ArgSet,CMS_hzg_weight.getVal())

        MC_file.Close()
        

    data_file = rt.TFile.Open("{}/{}".format(file_path, data_file_name))
    data_tree = data_file.Get(tree_name)

    H_mass = rt.RooRealVar("CMS_hzg_mass", "CMS_hzg_mass", 125., 100., 180.)
    BDT_score = rt.RooRealVar("BDT_score", "BDT_score", 0., 1.)

    data = {}
    data["data_allcat"] = rt.RooDataSet("data_allcat","data_allcat",rt.RooArgSet(H_mass))
    for icat in range(n_cat):
        data["data_cat{}".format(icat)] = rt.RooDataSet("data_cat{}".format(icat),"data_cat{}".format(icat),rt.RooArgSet(H_mass))

    for jentry in range(data_tree.GetEntriesFast()):
        nb = data_tree.GetEntry(jentry)

        if data_tree.H_mass<=100. or data_tree.H_mass>=200.: continue
        if data_tree.regions != 0: continue
        if data_tree.Z_mass>=100. or data_tree.Z_mass<=80.: continue
        if (data_tree.Z_mass + data_tree.H_mass) <= 185: continue

        H_mass.setVal(data_tree.H_mass)
        
        data["data_allcat"].add(rt.RooArgSet(H_mass))
        if data_tree.BDT_score > bdt_boundaries[0][0] and data_tree.BDT_score <= bdt_boundaries[0][1]:
            data["data_cat0"].add(rt.RooArgSet(H_mass))
        elif data_tree.BDT_score > bdt_boundaries[1][0] and data_tree.BDT_score <= bdt_boundaries[1][1]:
            data["data_cat1"].add(rt.RooArgSet(H_mass))
        elif data_tree.BDT_score > bdt_boundaries[2][0] and data_tree.BDT_score <= bdt_boundaries[2][1]:
            data["data_cat2"].add(rt.RooArgSet(H_mass))
        elif data_tree.BDT_score > bdt_boundaries[3][0] and data_tree.BDT_score <= bdt_boundaries[3][1]:
            data["data_cat3"].add(rt.RooArgSet(H_mass))

    w = rt.RooWorkspace("w", "workspace")
    getattr(w,'import')(H_mass)
    getattr(w,'import')(CMS_hzg_weight)
    for cat in ["data_cat0", "data_cat1", "data_cat2", "data_cat3", "data_allcat"]:
        getattr(w,'import')(data[cat])
    for cat in ["MC_cat0", "MC_cat1", "MC_cat2", "MC_cat3", "MC_allcat"]:
        getattr(w,'import')(MC[cat])
    w.Print()
    w.writeToFile("data_fromMC_01jet.root")

keysPdfs = {}
keysPdfs_plots = {}
def smoothbkg(name="", x=None, mc=None, Data=None, setting=rt.RooKeysPdf.MirrorBoth, rho = 1.0):
    keysPdf = rt.RooKeysPdf("CoreShape_{}".format(name), "CoreShape_{}".format(name), x, mc, setting, rho)

    canv = rt.TCanvas(name, name,800,1000)
    pad1 = rt.TPad(name+"pad1", name+"pad1", 0, 0.5, 1, 1)
    pad1.Draw()
    pad2 = rt.TPad(name+"pad2", name+"pad2", 0, 0, 1, 0.5)
    pad2.Draw()
    pad1.cd()
    pad1.SetLeftMargin(0.13)
    
    frame = x.frame(rt.RooFit.Title("Kernel Density Estimation with RooKeysPdf"))
    legend1 = rt.TLegend(0.7, 0.7, 0.9, 0.9)

    # Draw the smooth pdf and data
    x.setRange("unblindReg_1",100,120)
    x.setRange("unblindReg_2",130,180)

    Data.plotOn(frame, rt.RooFit.CutRange("unblindReg_1"))
    Data.plotOn(frame, rt.RooFit.CutRange("unblindReg_2"))
    keysPdf.plotOn(frame)
    frame.Draw()
    legend1.AddEntry(Data, "Data", "P")
    legend1.AddEntry(keysPdf, "Core PDF", "l")
    legend1.Draw()

    pad1.Update()
    pad1.Draw()

    pad2.cd()
    pad2.SetLeftMargin(0.13)

    frame = x.frame(rt.RooFit.Title("Kernel Density Estimation with RooKeysPdf"))
    legend2 = rt.TLegend(0.7, 0.7, 0.9, 0.9)

    mc.plotOn(frame, rt.RooFit.DrawOption("P"), rt.RooFit.MarkerColor(rt.kRed), rt.RooFit.LineColor(rt.kRed))
    keysPdf.plotOn(frame)
    frame.Draw()
    legend2.AddEntry(mc, "NAF MC", "P")
    legend2.AddEntry(keysPdf, "Core PDF", "l")
    legend2.Draw()

    pad2.Update()
    pad2.Draw()
    canv.Update()
    canv.Draw()

    return keysPdf, canv


def smooth_plot(keysPdf, x, mc, Data):

    name = "c"
    canv = rt.TCanvas(name, name,800,1000)
    pad1 = rt.TPad(name+"pad1", name+"pad1", 0, 0.5, 1, 1)
    pad1.Draw()
    pad2 = rt.TPad(name+"pad2", name+"pad2", 0, 0, 1, 0.5)
    pad2.Draw()
    pad1.cd()
    pad1.SetLeftMargin(0.13)
    
    frame = x.frame(rt.RooFit.Title("Kernel Density Estimation with RooKeysPdf"))
    legend1 = rt.TLegend(0.7, 0.7, 0.9, 0.9)

    # Draw the smooth pdf and data
    x.setRange("unblindReg_1",100,120)
    x.setRange("unblindReg_2",130,180)

    Data.plotOn(frame, rt.RooFit.CutRange("unblindReg_1,unblindReg_2"))
    keysPdf.plotOn(frame)
    frame.Draw()
    legend1.AddEntry(Data, "Data", "P")
    legend1.AddEntry(keysPdf, "Core PDF", "l")
    legend1.Draw()

    pad1.Update()
    pad1.Draw()

    pad2.cd()
    pad2.SetLeftMargin(0.13)

    frame = x.frame(rt.RooFit.Title("Kernel Density Estimation with RooKeysPdf"))
    legend2 = rt.TLegend(0.7, 0.7, 0.9, 0.9)

    mc.plotOn(frame, rt.RooFit.DrawOption("P"), rt.RooFit.MarkerColor(rt.kRed), rt.RooFit.LineColor(rt.kRed))
    Data.plotOn(frame, rt.RooFit.CutRange("unblindReg_1,unblindReg_2"))
    keysPdf.plotOn(frame)
    frame.Draw()
    legend2.AddEntry(mc, "MC", "P")
    legend2.AddEntry(Data, "Data", "P")
    legend2.AddEntry(keysPdf, "Core PDF", "l")
    legend2.Draw()

    pad2.Update()
    pad2.Draw()
    canv.Update()
    canv.Draw()

    return canv

if os.path.exists(Corefile_path):
    f = rt.TFile(Corefile_path)
    w = f.Get("w")
    w.Print()
    #for cat in ["MC_cat0", "MC_cat1", "MC_cat2", "MC_cat3", "MC_allcat"]:
    for cat in ["MC_cat0", "MC_cat1", "MC_cat2", "MC_cat3"]:
    #for cat in ["MC_cat3"]:
        keysPdfs[cat] = w.pdf("CoreShape_{}".format(cat))
else:
    smooth_rhos = {"cat0": 2.5,
                    "cat1": 3,
                    "cat2": 3,
                    "cat3": 3,
                    "allcat": 2}
    #for cat in ["cat0", "cat1", "cat2", "cat3", "allcat"]:
    for cat in ["cat0", "cat1", "cat2", "cat3"]:
    #for cat in ["cat2"]:
        #keysPdfs["MC_{}".format(cat)], keysPdfs_plots["MC_{}".format(cat)] = smoothbkg("MC_{}".format(cat), H_mass, MC["MC_{}".format(cat)], data["data_{}".format(cat)], 2)
        keysPdfs["MC_{}".format(cat)] = rt.RooKeysPdf("CoreShape_{}".format("MC_{}".format(cat)), "CoreShape_{}".format("MC_{}".format(cat)), H_mass, MC["MC_{}".format(cat)], rt.RooKeysPdf.MirrorAsymBoth, smooth_rhos[cat])

        keysPdfs_plots["MC_{}".format(cat)] = smooth_plot(keysPdfs["MC_{}".format(cat)], H_mass, MC["MC_{}".format(cat)], data["data_{}".format(cat)])
        keysPdfs_plots["MC_{}".format(cat)].SaveAs('./{}_v4.png'.format(cat))
        

    w = rt.RooWorkspace("w", "workspace")
    #for cat in ["MC_cat0", "MC_cat1", "MC_cat2", "MC_cat3", "MC_allcat"]:
    for cat in ["MC_cat0", "MC_cat1", "MC_cat2", "MC_cat3"]:
    #for cat in ["MC_cat2"]:
        getattr(w,'import')(keysPdfs[cat])
    w.Print()
    w.writeToFile(Corefile_path)

#for cat in ["cat0", "cat1", "cat2", "cat3"]:
#    keysPdfs_plots["MC_{}".format(cat)] = smooth_plot(keysPdfs["MC_{}".format(cat)], H_mass, MC["MC_{}".format(cat)], data["data_{}".format(cat)])
#    keysPdfs_plots["MC_{}".format(cat)].SaveAs('./{}.png'.format(cat))
