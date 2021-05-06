import ROOT
from ROOT import TFile, TTree, TCanvas, TGraph, TMultiGraph, TGraphErrors, TLegend, kBlack, TLatex, gPad
import CMS_lumi, tdrstyle
import subprocess # to execute shell command

import argparse

import numpy as np
from scipy.integrate import quad
import matplotlib.pyplot as plt


# ol = '/afs/cern.ch/work/a/atishelm/private/ecall1algooptimization/PileupMC_v2/Plot/ntuples/'
#ol = '/eos/user/a/atishelm/www/EcalL1Optimization/BX-1/'
ol = '/afs/cern.ch/work/z/zewang/private/flashggfit/CMSSW_10_2_13/src/flashggFinalFit/Signal/ALP_SigModel/fit_results_17/'
parser = argparse.ArgumentParser()
parser.add_argument("-SM","--SM_Radion",action="store_true", default=False, help="Display SM limits", required=False)
parser.add_argument("-pb","--pb", action="store_true", default=False, help="Display limits in pb unit", required=False)
parser.add_argument("-fb","--fb", action="store_true", default=False, help="Display limits in fb unit", required=False)
args = parser.parse_args()

ROOT.gROOT.SetBatch(ROOT.kTRUE)

# CMS style
CMS_lumi.cmsText = "CMS"
#CMS_lumi.extraText = "Preliminary"
CMS_lumi.extraText = "Private"
CMS_lumi.cmsTextSize = 0.65
CMS_lumi.outOfFrame = True
tdrstyle.setTDRStyle()


# GET limits from root file
def getLimits(file_name):
    file = TFile(file_name)

    if file: print 'file opened'
    tree = file.Get("limit")
    if tree: print 'tree opened'

    limits = [ ]
    print'tree = ',tree
    for quantile in tree:
	print'quantile = ',quantile
        if(args.pb):
            limits.append(tree.limit)
        elif(args.fb):
            limits.append(tree.limit*1000.)# fb
    print limits[:5]

    return limits[:5]


# PLOT upper limits
def plotUpperLimits(masses, limit, ALP_xs, name):
    N=len(masses)
    print str(N) + ' mass points'

    yellow = TGraph(2*N)    # yellow band
    green = TGraph(2*N)     # green band
    median = TGraph(N)      # median line


    print'limit = ',limit

    for i in range(N):
        print 'ALP mass: ' + str(masses[i]) +' GeV'
        x_mass =  masses[i]
        yellow.SetPoint(    i,    x_mass, limit[x_mass][4]*ALP_xs ) # + 2 sigma
        green.SetPoint(     i,    x_mass, limit[x_mass][3]*ALP_xs ) # + 1 sigma
        median.SetPoint(    i,    x_mass, limit[x_mass][2]*ALP_xs ) # median
        green.SetPoint(  2*N-1-i, x_mass, limit[x_mass][1]*ALP_xs ) # - 1 sigma
        yellow.SetPoint( 2*N-1-i, x_mass, limit[x_mass][0]*ALP_xs ) # - 2 sigma

    W = 800
    H  = 600
    T = 0.08*H
    B = 0.12*H
    L = 0.12*W
    R = 0.04*W
    c = TCanvas("c","c",100,100,W,H)
    c.SetFillColor(0)
    c.SetBorderMode(0)
    c.SetFrameFillStyle(0)
    c.SetFrameBorderMode(0)
    c.SetLeftMargin( L/W )
    c.SetRightMargin( R/W )
    c.SetTopMargin( T/H )
    c.SetBottomMargin( B/H )
    c.SetTickx(0)
    c.SetTicky(0)
    c.SetGrid()
    c.cd()

    frame = c.DrawFrame(1.4,0.001, 4.1, 10)
    frame.GetYaxis().CenterTitle()
    frame.GetYaxis().SetTitleSize(0.04)
    frame.GetXaxis().SetTitleSize(0.05)
    frame.GetXaxis().SetLabelSize(0.04)
    frame.GetYaxis().SetLabelSize(0.04)
    frame.GetYaxis().SetTitleOffset(1.3)
    frame.GetXaxis().SetNdivisions(508)
    frame.GetYaxis().CenterTitle(True)
    frame.GetXaxis().SetTitle("m_{a} [GeV]")

    if(args.pb):
        frame.GetYaxis().SetTitle("95% CL limits on #sigma(gg#rightarrow H)#times B(X#rightarrow HH) [pb]")
    elif(args.fb):
        if name == 'coeff':
            frame.GetYaxis().SetTitle("95% CL limits on |C_{Zh}^{eff}| [#frac{#Lambda}{1 TeV}]")
            frame.SetMinimum(0.01) # need Minimum > 0 for log scale
            frame.SetMaximum(1.) # CMS HH
        elif name == 'Br':
            #frame.GetYaxis().SetTitle("95% CL limits on #sigma(gg#rightarrow H#rightarrow Za#rightarrow 2l + 2#gamma)(fb)")
            frame.GetYaxis().SetTitle("95% CL limits on Br(pp#rightarrow H#rightarrow Za#rightarrow 2l + 2#gamma)")
            frame.SetMinimum(0.000001) # need Minimum > 0 for log scale
            frame.SetMaximum(1.) # CMS HH
        else:
            frame.GetYaxis().SetTitle("95% CL limits on #sigma(pp#rightarrow H#rightarrow Za#rightarrow 2l + 2#gamma)(fb)")
            frame.SetMinimum(0.1) # need Minimum > 0 for log scale
            frame.SetMaximum(8*1e4) # CMS HH


    frame.GetXaxis().SetLimits(0, 32)

    yellow.SetFillColor(ROOT.kOrange)
    yellow.SetLineColor(ROOT.kOrange)
    yellow.SetFillStyle(1001)
    yellow.Draw('F')

    green.SetFillColor(ROOT.kGreen+1)
    green.SetLineColor(ROOT.kGreen+1)
    green.SetFillStyle(1001)
    green.Draw('Fsame')

    median.SetLineColor(1)
    median.SetLineWidth(2)
    median.SetLineStyle(2)
    median.Draw('Lsame')

    CMS_lumi.CMS_lumi(c,4,11)
    ROOT.gPad.SetTicks(1,1)
    frame.Draw('sameaxis')

    # yboost = 0.075
    yboost = -0.2

    x1 = 0.15
    x2 = x1 + 0.24
    y2 = 0.88 + yboost
    y1 = 0.80 + yboost
    legend = TLegend(x1,y1,x2,y2)
    legend.SetFillStyle(0)
    legend.SetBorderSize(0)
    legend.SetTextSize(0.035)
    legend.SetTextFont(42)
    legend.AddEntry(median, "AsymptoticLimits CL_{s} expected",'L')
    legend.AddEntry(green, "#pm 1 std. deviation",'f')
#    legend.AddEntry(green, "AsymptoticLimits CL_{s} #pm 1 std. deviation",'f')
    legend.AddEntry(yellow,"#pm 2 std. deviation",'f')
    # legend.AddEntry("","STAT Only","")
#    legend.AddEntry(green, "AsymptoticLimits CL_{s} #pm 2 std. deviation",'f')
    legend.Draw()

    label = TLatex()
    label.SetNDC()
    label.SetTextAngle(0)
    label.SetTextColor(kBlack)
    label.SetTextFont(42)
    label.SetTextSize(0.045)
    label.SetLineWidth(2)
    label.DrawLatex(0.7,0.7 + yboost,"STAT only");
    print " "
    # c.SaveAs("UpperLimit.png")

    outFile = "ALP_"


    if args.SM_Radion: outFile += "SM_"

    c.SaveAs(outFile + name+"_UpperLimit.pdf")
    c.SaveAs(outFile + name+"_UpperLimit.C")
    c.Close()

def getlambda(x,y):
    return (1-x-y)*(1-x-y)-4*x*y


def width_hToza(m_h, m_z, m_a, C_zh):
    L = getlambda((m_z*m_z)/(m_h*m_h), (m_a*m_a)/(m_h*m_h))
    #print L
    #print L**(3./2.)
    return m_h*m_h*m_h*(L**(3./2.))*(C_zh*0.001)**(2.)/(16.*np.pi)

def width_aToGG(m_h, m_z, m_a, C_GG):
    return 4*np.pi*(1./137.)*(1./137.)*(m_a**(3))*((C_GG*0.001)**(2))

def getL_a(m_h, m_z, m_a, Br_aToGG, C_GG):
    L_det = 1.5
    #C_GG = 1 # GeV^{-1}
    gamma_a = (m_h*m_h-m_z*m_z+m_a*m_a)/(2*m_a*m_h)
    L_a = np.sqrt(gamma_a*gamma_a-1)*Br_aToGG/width_aToGG(m_h, m_z, m_a, C_GG)
    #print "L_a = " + str(L_a)
    return L_a

def getf_dec_za(m_h, m_z, m_a, Br_aToGG, C_GG):
    L_det = 1.5
    #C_GG = 1 # GeV^{-1}
    gamma_a = (m_h*m_h-m_z*m_z+m_a*m_a)/(2*m_a*m_h)
    L_a = np.sqrt(gamma_a*gamma_a-1)*Br_aToGG/width_aToGG(m_h, m_z, m_a, C_GG)
    #print "L_a = " + str(L_a)
    val1,err1=quad(lambda x:np.sin(x)*(1-np.exp(-L_det/L_a*np.sin(x))), 0., np.pi/2.)
    return val1

def getCoefficient(masses, cross_section, C_GG, isPrompt):
    Br_ZToll = 0.06729
    Br_aToGG = 1.
    xs_H = 48.61
    width_H = 0.0061
    #width_H = 0.013
    m_h = 125.
    m_z = 91.
    m_a = masses
    width_HToza = width_hToza(m_h, m_z, m_a, 1.0)
    Br_hToza = width_HToza/(width_H+width_HToza)
    if isPrompt:
        f_dec_za = 1.
        #print "f_dec_za: " + str(f_dec_za)
    else:
        f_dec_za = getf_dec_za(m_h, m_z, m_a, Br_aToGG, C_GG)
        print "f_dec_za: " + str(f_dec_za)
    #print "Br_hToza: " + str(Br_hToza)
    sigma = xs_H * Br_hToza * Br_ZToll * Br_aToGG * f_dec_za

    #return np.sqrt(cross_section/sigma)
    return np.sqrt(width_H*cross_section/(xs_H * Br_ZToll * Br_aToGG * f_dec_za * width_HToza - width_HToza * cross_section))


def plot_L_a(masses):

    for m in masses:
        C_GG = np.arange(1., 1000000, 20)
        L_a = []
        for x in C_GG:
            L_a.append(getL_a(125., 91., m, 1., x))

        #plt.axes(xscale = "log", yscale = "log")
        plt.rcParams['figure.figsize'] = (12.0, 8.0)
        plt.loglog(C_GG, L_a, label=r"$f^{Za}_{dec}$ at " + str(m) + "GeV mass point")
        plt.xlabel(r"$C^{eff}_{\gamma\gamma}\ ([\frac{\Lambda}{1 TeV}])$", size = 20)
        plt.ylabel(r'$L_{a}\ (m)$', size = 20)

    #plt.ylim(0., 1.2)
    plt.loglog(C_GG, 1.5*np.ones(len(C_GG)), label="distance of detector: 1.5m")
    plt.grid()
    plt.legend(loc='upper right',fontsize=10)
    plt.savefig('./plots/L_a.pdf')
    #plt.show()

def plot_f_dec_za(masses):

    for m in masses:
        C_GG = np.arange(1., 1000000, 20)
        f_dec_za = []
        for x in C_GG:
            f_dec_za.append(getf_dec_za(125., 91., m, 1., x))

        #plt.axes(xscale = "log")
        plt.rcParams['figure.figsize'] = (12.0, 8.0)
        plt.loglog(C_GG, f_dec_za, label=r"$f^{Za}_{dec}$ at " + str(m) + "GeV mass point")
        plt.xlabel(r"$C^{eff}_{\gamma\gamma}\ ([\frac{\Lambda}{1 TeV}])$", size = 20)
        plt.ylabel(r'$f^{Za}_{dec}$', size = 20)

    #plt.ylim(0., 1.2)
    plt.grid()
    plt.legend(loc='upper left',fontsize=10)
    #plt.savefig('./plots/f_dec_Za.pdf')
    plt.show()


def plot_Cza_vs_Cgg(masses, limits_xs):

    for m in masses:
        C_GG = np.arange(1., 1000000, 20)
        C_zh = []
        for x in C_GG:
            C_zh.append(getCoefficient(m, limits_xs[m][2]/10000., x, 0))

        #plt.axes(xscale = "log")
        plt.rcParams['figure.figsize'] = (12.0, 8.0)
        plt.loglog(C_zh, C_GG, label=r"$C_{zh}^{eff}\ vs\ C_{\gamma\gamma}^{eff}$ at " + str(m) + "GeV mass point")
        plt.xlabel(r"$C^{eff}_{zh}\ ([\frac{\Lambda}{1 TeV}])$", size = 20)
        plt.ylabel(r"$C^{eff}_{\gamma\gamma}\ ([\frac{\Lambda}{1 TeV}])$", size = 20)

    #plt.ylim(0., 1.2)
    plt.grid()
    plt.legend(loc='upper right',fontsize=10)
    plt.savefig('./plots/Cza_vs_Cgg.pdf')
    #plt.show()



# main
def main():

    f = TFile()

    values = [ ]
    limit = {}
    coeff_limit = {}

    masses = [ 5, 15, 30]
    for m in masses:
        values.append(m)
        file_name = ol + "M"+str(m)+"/higgsCombineTest.AsymptoticLimits.mH"+str(m)+".root"
        #print file_name
        limit[m] = getLimits(file_name)

        isPrompt = 1
        coeff_limit[m]={}
        #print "###########"
        #print "At " + str(m) + " GeV mass point"
        #coeff = getCoefficient(m, limit[m][2]/10000., 1.0, isPrompt)
        #print "C_Zh/Lam at " + str(m) + " GeV: " + str(coeff)
        #print "###########"
        #for i in range(len(limit[m])):
        #    coeff_limit[m][i] = getCoefficient(m, limit[m][i]/10000., 1.0, isPrompt)





    #print str(getCoefficient(1, 0.2))
    #plot_f_dec_za(masses)
    #plot_L_a(masses)
    #plot_Cza_vs_Cgg(masses, limit)
    ALP_xs = 0.1
    #plotUpperLimits(masses, coeff_limit, 1.0, "coeff")
    plotUpperLimits(masses, limit, 0.0001/54.35, "Br")
    plotUpperLimits(masses, limit, ALP_xs, "xs")





if __name__ == '__main__':
    main()
