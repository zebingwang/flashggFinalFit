import ROOT as rt
import os

datafile_path = "./data_01jet_NAFCorr.root"
Corefile_path = "./ZGCoreShape_01jet_NAFCorr.root"

parameters = {"cat0": [7.18518661e-10,-1.89360669e-07,1.95804114e-05,-1.00734838e-03,2.69278493e-02,-3.50220233e-01,2.64463188e+00],
                "cat1": [6.06029211e-10,-1.56365842e-07,1.56729660e-05,-7.69660169e-04,1.91921667e-02,-2.20950541e-01,1.80025645e+00],
                "cat2": [6.92599431e-10,-1.64409718e-07,1.48158554e-05,-6.36249274e-04,1.33743507e-02,-1.14766705e-01,1.17612513e+00],
                "cat3": [1.06245302e-09,-2.59086724e-07,2.43081362e-05,-1.10673281e-03,2.52168255e-02,-2.46973757e-01,1.57323858e+00]
                }

def linear_corr(x, a, b, c, d, e, f, g):
        return a*x**6 + b*x**5 + c*x**4 + d*x**3 + e*x**2 +f*x + g

if os.path.exists(datafile_path):
    f = rt.TFile(datafile_path)
    w = f.Get("w")
    w.Print()
    data = {}
    data_ANF = {}
    for cat in ["data_cat0", "data_cat1", "data_cat2", "data_cat3", "data_allcat"]:
        data[cat] = w.data("{}".format(cat))
    for cat in ["ZG_NAF_cat0", "ZG_NAF_cat1", "ZG_NAF_cat2", "ZG_NAF_cat3", "ZG_NAF_allcat"]:
        data_ANF[cat] = w.data("{}".format(cat))

    H_mass_ANF = w.var("CMS_hzg_mass")
else:
    ANF_file_name = "/eos/user/z/zewang/HZGamma_data/run2UL_data_Normalizing/ZGToLLG_zero_to_one_jet_NAF.root"
    data_file_name = "/eos/user/z/zewang/HZGamma_data/run2UL_data_Normalizing/data_zero_to_one_jet.root"
    tree_name = "zero_to_one_jet"
    bdt_boundaries = [[0.28379330039024353, 0.4557725191116333], [0.4557725191116333, 0.5796570777893066], [0.5796570777893066, 0.7069960236549377], [0.7069960236549377, 1.]]
    n_cat = len(bdt_boundaries)

    ANF_file = rt.TFile.Open(ANF_file_name)
    ANF_tree = ANF_file.Get(tree_name)

    H_mass_ANF = rt.RooRealVar("CMS_hzg_mass", "CMS_hzg_mass", 125., 100., 180.)
    CMS_hzg_weight = rt.RooRealVar("CMS_hzg_weight","CMS_hzg_weight",-100000,1000000)
    BDT_score_ANF = rt.RooRealVar("BDT_score", "BDT_score", 0., 1.)
    ArgSet = rt.RooArgSet("args")
    ArgSet.add(H_mass_ANF)
    ArgSet.add(CMS_hzg_weight)

    data_ANF = {}
    data_ANF["ZG_NAF_allcat"] = rt.RooDataSet("ZG_NAF_allcat","ZG_NAF_allcat",rt.RooArgSet(H_mass_ANF))
    for icat in range(n_cat):
        data_ANF["ZG_NAF_cat{}".format(icat)] = rt.RooDataSet("ZG_NAF_cat{}".format(icat),"ZG_NAF_cat{}".format(icat),ArgSet, "CMS_hzg_weight")

    for jentry in range(ANF_tree.GetEntriesFast()):
        nb = ANF_tree.GetEntry(jentry)

        if ANF_tree.H_mass<=100. or ANF_tree.H_mass>=200.: continue
        if ANF_tree.regions != 0: continue
        if ANF_tree.Z_mass>=100. or ANF_tree.Z_mass<=80.: continue
        if (ANF_tree.Z_mass + ANF_tree.H_mass) <= 185: continue
        if ANF_tree.H_mass_transfered<=100. or ANF_tree.H_mass_transfered>=180.: continue

        H_mass_ANF.setVal(ANF_tree.H_mass_transfered)
        
        data_ANF["ZG_NAF_allcat"].add(rt.RooArgSet(H_mass_ANF))
        if ANF_tree.BDT_score_transfered > bdt_boundaries[0][0] and ANF_tree.BDT_score_transfered <= bdt_boundaries[0][1]:
            CMS_hzg_weight.setVal(0.153451*linear_corr(ANF_tree.H_mass_transfered-100., parameters["cat0"][0], parameters["cat0"][1], parameters["cat0"][2], parameters["cat0"][3], parameters["cat0"][4], parameters["cat0"][5], parameters["cat0"][6]))
            data_ANF["ZG_NAF_cat0"].add(ArgSet, CMS_hzg_weight.getVal())
        elif ANF_tree.BDT_score_transfered > bdt_boundaries[1][0] and ANF_tree.BDT_score_transfered <= bdt_boundaries[1][1]:
            CMS_hzg_weight.setVal(0.157035*linear_corr(ANF_tree.H_mass_transfered-100., parameters["cat1"][0], parameters["cat1"][1], parameters["cat1"][2], parameters["cat1"][3], parameters["cat1"][4], parameters["cat1"][5], parameters["cat1"][6]))
            data_ANF["ZG_NAF_cat1"].add(ArgSet, CMS_hzg_weight.getVal())
        elif ANF_tree.BDT_score_transfered > bdt_boundaries[2][0] and ANF_tree.BDT_score_transfered <= bdt_boundaries[2][1]:
            CMS_hzg_weight.setVal(0.143059*linear_corr(ANF_tree.H_mass_transfered-100., parameters["cat2"][0], parameters["cat2"][1], parameters["cat2"][2], parameters["cat2"][3], parameters["cat2"][4], parameters["cat2"][5], parameters["cat2"][6]))
            data_ANF["ZG_NAF_cat2"].add(ArgSet, CMS_hzg_weight.getVal())
        elif ANF_tree.BDT_score_transfered > bdt_boundaries[3][0] and ANF_tree.BDT_score_transfered <= bdt_boundaries[3][1]:
            CMS_hzg_weight.setVal(0.137244*linear_corr(ANF_tree.H_mass_transfered-100., parameters["cat3"][0], parameters["cat3"][1], parameters["cat3"][2], parameters["cat3"][3], parameters["cat3"][4], parameters["cat3"][5], parameters["cat3"][6]))
            data_ANF["ZG_NAF_cat3"].add(ArgSet, CMS_hzg_weight.getVal())
        
    ANF_file.Close()

    data_file = rt.TFile.Open(data_file_name)
    data_tree = data_file.Get(tree_name)

    H_mass_ANF = rt.RooRealVar("CMS_hzg_mass", "CMS_hzg_mass", 125., 100., 180.)
    BDT_score = rt.RooRealVar("BDT_score", "BDT_score", 0., 1.)

    data = {}
    data["data_allcat"] = rt.RooDataSet("data_allcat","data_allcat",rt.RooArgSet(H_mass_ANF))
    for icat in range(n_cat):
        data["data_cat{}".format(icat)] = rt.RooDataSet("data_cat{}".format(icat),"data_cat{}".format(icat),rt.RooArgSet(H_mass_ANF))

    for jentry in range(data_tree.GetEntriesFast()):
        nb = data_tree.GetEntry(jentry)

        if data_tree.H_mass<=100. or data_tree.H_mass>=200.: continue
        if data_tree.regions != 0: continue
        if data_tree.Z_mass>=100. or data_tree.Z_mass<=80.: continue
        if (data_tree.Z_mass + data_tree.H_mass) <= 185: continue

        H_mass_ANF.setVal(data_tree.H_mass)
        
        data["data_allcat"].add(rt.RooArgSet(H_mass_ANF))
        if data_tree.BDT_score > bdt_boundaries[0][0] and data_tree.BDT_score <= bdt_boundaries[0][1]:
            data["data_cat0"].add(rt.RooArgSet(H_mass_ANF))
        elif data_tree.BDT_score > bdt_boundaries[1][0] and data_tree.BDT_score <= bdt_boundaries[1][1]:
            data["data_cat1"].add(rt.RooArgSet(H_mass_ANF))
        elif data_tree.BDT_score > bdt_boundaries[2][0] and data_tree.BDT_score <= bdt_boundaries[2][1]:
            data["data_cat2"].add(rt.RooArgSet(H_mass_ANF))
        elif data_tree.BDT_score > bdt_boundaries[3][0] and data_tree.BDT_score <= bdt_boundaries[3][1]:
            data["data_cat3"].add(rt.RooArgSet(H_mass_ANF))

    w = rt.RooWorkspace("w", "workspace")
    getattr(w,'import')(H_mass_ANF)
    getattr(w,'import')(CMS_hzg_weight)
    for cat in ["data_cat0", "data_cat1", "data_cat2", "data_cat3", "data_allcat"]:
        getattr(w,'import')(data[cat])
    for cat in ["ZG_NAF_cat0", "ZG_NAF_cat1", "ZG_NAF_cat2", "ZG_NAF_cat3", "ZG_NAF_allcat"]:
        getattr(w,'import')(data_ANF[cat])
    w.Print()
    w.writeToFile(datafile_path)

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
    legend2.AddEntry(mc, "NAF MC", "P")
    legend2.AddEntry(keysPdf, "Core PDF", "l")
    legend2.Draw()

    pad2.Update()
    pad2.Draw()
    canv.Update()
    canv.Draw()

    return keysPdf, canv

def smooth_plot(name="", x=None, mc=None, Data=None, keysPdf=None):

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
    legend2.AddEntry(mc, "NAF MC", "P")
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
    #print("[DEBUG]:", data)
    #for cat in ["ZG_NAF_cat0", "ZG_NAF_cat1", "ZG_NAF_cat2", "ZG_NAF_cat3", "ZG_NAF_allcat"]:
    for cat in ["ZG_NAF_cat0", "ZG_NAF_cat1", "ZG_NAF_cat2", "ZG_NAF_cat3"]:
    #for cat in ["cat0", "cat1", "cat2", "cat3"]:
    #for cat in ["ZG_NAF_allcat"]:
        keysPdfs["ZG_NAF_{}".format(cat)] = w.pdf("{}".format("CoreShape_ZG_NAF_{}".format(cat)))
        #print("[DEBUG]:", cat, keysPdfs["ZG_NAF_{}".format(cat)])
        keysPdfs_plots["ZG_NAF_{}".format(cat)] = smooth_plot("ZG_NAF_{}".format(cat), H_mass_ANF, data_ANF["ZG_NAF_{}".format(cat)], data["data_{}".format(cat)], keysPdfs["ZG_NAF_{}".format(cat)])
else:
    #for cat in ["cat0", "cat1", "cat2", "cat3", "allcat"]:
    for cat in ["cat0", "cat1", "cat2", "cat3"]:
    #for cat in ["cat3"]:
        if cat == "cat3":
            # v2[1.5,1.5,1.5,3] v3:noMirror v4:[2,2,2,3.5] v5:[2.5]
            #keysPdfs["ZG_NAF_{}".format(cat)], keysPdfs_plots["ZG_NAF_{}".format(cat)] = smoothbkg("ZG_NAF_{}".format(cat), H_mass_ANF, data_ANF["ZG_NAF_{}".format(cat)], data["data_{}".format(cat)], rt.RooKeysPdf.MirrorBoth, 2.5)
            keysPdfs["ZG_NAF_{}".format(cat)], keysPdfs_plots["ZG_NAF_{}".format(cat)] = smoothbkg("ZG_NAF_{}".format(cat), H_mass_ANF, data_ANF["ZG_NAF_{}".format(cat)], data["data_{}".format(cat)], rt.RooKeysPdf.MirrorBoth, 2.5)
        else:
            #keysPdfs["ZG_NAF_{}".format(cat)], keysPdfs_plots["ZG_NAF_{}".format(cat)] = smoothbkg("ZG_NAF_{}".format(cat), H_mass_ANF, data_ANF["ZG_NAF_{}".format(cat)], data["data_{}".format(cat)], rt.RooKeysPdf.MirrorBoth, 1.5)
            keysPdfs["ZG_NAF_{}".format(cat)], keysPdfs_plots["ZG_NAF_{}".format(cat)] = smoothbkg("ZG_NAF_{}".format(cat), H_mass_ANF, data_ANF["ZG_NAF_{}".format(cat)], data["data_{}".format(cat)], rt.RooKeysPdf.MirrorBoth, 3)

    w = rt.RooWorkspace("w", "workspace")
    #for cat in ["ZG_NAF_cat0", "ZG_NAF_cat1", "ZG_NAF_cat2", "ZG_NAF_cat3", "ZG_NAF_allcat"]:
    for cat in ["ZG_NAF_cat0", "ZG_NAF_cat1", "ZG_NAF_cat2", "ZG_NAF_cat3"]:
    #for cat in ["ZG_NAF_cat3"]:
        getattr(w,'import')(keysPdfs[cat])
    w.Print()
    w.writeToFile(Corefile_path)

#print("[DEBUG]:", keysPdfs_plots)

if keysPdfs_plots:
    for cat in ["ZG_NAF_cat0", "ZG_NAF_cat1", "ZG_NAF_cat2", "ZG_NAF_cat3"]:
    #for cat in ["ZG_NAF_cat3"]:
        #print("[DEBUG]:", keysPdfs_plots[cat])
        keysPdfs_plots[cat].SaveAs('./{}_NAFCorr.png'.format(cat))
