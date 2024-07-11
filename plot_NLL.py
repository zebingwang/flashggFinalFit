import ROOT as rt
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt


filename_conv = "/afs/cern.ch/work/z/zewang/private/HZGamma/flashggfinalfit/CMSSW_10_2_13/src/flashggFinalFit/Signal/HZGamma_SigModel_UL_run2_01jet_conv/Combine_results/"
#filename_core = "/afs/cern.ch/work/z/zewang/private/HZGamma/flashggfinalfit/CMSSW_10_2_13/src/flashggFinalFit/Signal/HZGamma_SigModel_UL_run2_01jet_corefunction_v2/Combine_results/"
#filename_core_fromMC = "/afs/cern.ch/work/z/zewang/private/HZGamma/flashggfinalfit/CMSSW_10_2_13/src/flashggFinalFit/Signal/HZGamma_SigModel_UL_run2_01jet_corefunction_fromMC/Combine_results/"
filename_core = "/afs/cern.ch/work/z/zewang/private/HZGamma/flashggfinalfit/CMSSW_10_2_13/src/flashggFinalFit/Signal/HZGamma_SigModel_UL_run2_01jet_corefunction_v2_cat3Fit105/Combine_results"
filename_core_fromMC = "/afs/cern.ch/work/z/zewang/private/HZGamma/flashggfinalfit/CMSSW_10_2_13/src/flashggFinalFit/Signal/HZGamma_SigModel_UL_run2_01jet_corefunction_fromMC_cat3_105/Combine_results"
#filename_core_SB = "/afs/cern.ch/work/z/zewang/private/HZGamma/flashggfinalfit/CMSSW_10_2_13/src/flashggFinalFit/Signal/HZGamma_SigModel_UL_run2_01jet_corefunction_v2_SB/Combine_results/"

cats = ["cat0", "cat1", "cat2", "cat3", "allCats"]
#cats = [ "cat1", "cat2", "cat3"]

file_conv = {}
file_core = {}
file_core_fromMC = {}
file_core_SB = {}

NLL_conv = {}
NLL_core = {}
NLL_core_fromMC = {}
NLL_core_SB = {}
r_conv = {}
r_core = {}
r_core_fromMC = {}
for cat in cats:
    file_conv[cat] = rt.TFile("{}/higgsCombine{}.MultiDimFit.mH125.root".format(filename_conv, cat))
    file_core[cat] = rt.TFile("{}/higgsCombine{}.MultiDimFit.mH125.root".format(filename_core, cat))
    file_core_fromMC[cat] = rt.TFile("{}/higgsCombine{}.MultiDimFit.mH125.root".format(filename_core_fromMC, cat))
    #file_core_SB[cat] = rt.TFile("{}/higgsCombine{}.MultiDimFit.mH125.root".format(filename_core_SB, cat))

    mychain_conv = file_conv[cat].Get("limit")
    entries_conv = mychain_conv.GetEntries()

    mychain_core = file_core[cat].Get("limit")
    entries_core = mychain_core.GetEntries()

    mychain_core_fromMC = file_core_fromMC[cat].Get("limit")
    entries_core_fromMC = mychain_core_fromMC.GetEntries()

    #mychain_core_SB = file_core_SB[cat].Get("limit")
    #mychain_core_SB.Print()
    #entries_core_SB = mychain_core_SB.GetEntries()

    r_conv[cat] = []
    r_core[cat] = []
    r_core_fromMC[cat] = []
    NLL_conv[cat] = []
    NLL_core[cat] = []
    NLL_core_fromMC[cat] = []
    #NLL_core_SB[cat] = []
    for ientry in range(entries_conv):
        if ientry == 0: continue
        nb = mychain_conv.GetEntry(ientry)

        NLL_conv[cat].append(mychain_conv.nll+mychain_conv.nll0+mychain_conv.deltaNLL)
        r_conv[cat].append(mychain_conv.r)
        #print mychain_conv.r, mychain_conv.nll0, mychain_conv.deltaNLL

    for ientry in range(entries_core):
        if ientry == 0: continue
        nb = mychain_core.GetEntry(ientry)

        NLL_core[cat].append(mychain_core.nll+mychain_core.nll0+mychain_core.deltaNLL)
        r_core[cat].append(mychain_core.r)

    for ientry in range(entries_core_fromMC):
        if ientry == 0: continue
        nb = mychain_core_fromMC.GetEntry(ientry)

        NLL_core_fromMC[cat].append(mychain_core_fromMC.nll+mychain_core_fromMC.nll0+mychain_core_fromMC.deltaNLL)
        r_core_fromMC[cat].append(mychain_core_fromMC.r)

    #for ientry in range(entries_core_SB):
    #    if ientry == 0: continue
    #    nb = mychain_core_SB.GetEntry(ientry)

    #    NLL_core_SB[cat].append(mychain_core_SB.nll+mychain_core_SB.nll0+mychain_core_SB.deltaNLL)

    #print len(r[cat]), len(NLL_core[cat]), len(NLL_core_SB[cat]), len(NLL_conv[cat])
    #print min(NLL_core[cat]), min(NLL_conv[cat]), min(NLL_core_SB[cat]), min([min(NLL_core[cat]), min(NLL_conv[cat]), min(NLL_core_SB[cat])])
    #plt.plot(r_conv[cat], NLL_conv[cat], linestyle='-', marker='o', color='blue', label='Convolution')
    #plt.plot(r_core[cat], NLL_core_SB[cat], linestyle='-', marker='o', color='orange', label='Core function Sideband')
    plt.plot(r_core[cat], NLL_core[cat], linestyle='-', marker='o', color='red', label='Core function')
    plt.plot(r_core_fromMC[cat], NLL_core_fromMC[cat], linestyle='-', marker='o', color='green', label='Core function (fromMC)')
    plt.legend()
    plt.xlabel("r")
    plt.ylabel("NLL")
    #plt.yscale('log')
    #plt.ylim(min([min(NLL_core[cat]), min(NLL_conv[cat]), min(NLL_core_SB[cat])]))
    plt.show()
    plt.savefig("./NLL_{}.png".format(cat))
    plt.savefig("./NLL_{}.pdf".format(cat))
    plt.clf()
#print NLL_conv["cat0"]
#file_conv["cat0"].limit.Print()