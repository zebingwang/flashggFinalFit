import ROOT as rt
import numpy as np
plotCore = False
func_type = "exp"
order = 1

f = rt.TFile("ZGCoreShape.root")
w = f.Get("w")
w.Print()
cat = "cat3"
core_model = w.pdf("CoreShape_ZG_NAF_{}".format(cat))
x = w.var("CMS_hzg_mass")
#x.setRange(105.0, 170.0)
x.setRange("fit",105,170)

f = rt.TFile("dataTest.root")
w = f.Get("w")
w.Print()
dataset = w.data("data_{}".format(cat))

canv = rt.TCanvas("c1","c1",800,1000)
frame = x.frame()

if plotCore:
    for i in np.arange(0,0.5,0.1):
        f1 = rt.RooRealVar("f1","f1",1,-10.,10.)
        f2 = rt.RooRealVar("f2","f2",0.5,-10.,10.)
        f3 = rt.RooRealVar("f3","f3",0.1,-10.,10.)
        p1 = rt.RooRealVar("p1","p1",-0.1,-0.5,1)
        p2 = rt.RooRealVar("p2","p2",-0.1,-10.,10.)
        p3 = rt.RooRealVar("p3","p3",-0.1,-10.,10.)

        #pdf_exp = RooExponential("exp","exp",mass_,p1)
        exp_order1 = rt.RooGenericPdf("exp_order1", "exp_order1","@2*exp(@1*(@0-125))",rt.RooArgList(x,p1,f1))
        exp_order2 = rt.RooFormulaVar("exp_order2", "exp_order2","@3*exp(@1*@0)+@4*exp(@2*@0)",rt.RooArgList(x,p1,p2,f1,f2))
        exp_order3 = rt.RooFormulaVar("exp_order3", "exp_order3","@4*exp(@1*@0)+@5*exp(@2*@0)+@6*exp(@3*@0)",rt.RooArgSet(x,p1,p2,p3,f1,f2,f3))

        #model_final = rt.RooEffProd("model_final", "model_final", core_model, exp_order1)
        model_final = rt.RooProdPdf("prodPdf", "Product of Gaussian PDFs", rt.RooArgSet(core_model, exp_order1))

        #model_final.fitTo(dataset)


        model_final.plotOn(frame,rt.RooFit.LineColor(rt.kRed))
else:

    if func_type == 'exp':
        f1 = rt.RooRealVar("f1","f1",1,0.,10.)
        f2 = rt.RooRealVar("f2","f2",1,0.,10.)
        f3 = rt.RooRealVar("f3","f3",1,0.,10.)
        p1 = rt.RooRealVar("p1","p1",-0.05,-0.1,1.)
        p2 = rt.RooRealVar("p2","p2",-0.1,-10.,1.)
        p3 = rt.RooRealVar("p3","p3",-0.1,-10.,1.)

        if order ==1:
            empirical = rt.RooGenericPdf("exp_order1", "exp_order1","1e-20+@2*TMath::Exp(@1*(@0))",rt.RooArgList(x,p1,f1))
        elif order ==2:
            empirical = rt.RooFormulaVar("exp_order2", "exp_order2","1e-20+@3*TMath::Exp(@1*(@0))+@4*TMath::Exp(@2*(@0))",rt.RooArgList(x,p1,p2,f1,f2))
        else:
            empirical = rt.RooFormulaVar("exp_order3", "exp_order3","1e-20+@4*TMath::Exp(@1*(@0))+@5*exp(@2*@0)+@6*TMath::Exp(@3*(@0))",rt.RooArgSet(x,p1,p2,p3,f1,f2,f3))

    elif func_type == 'pow':
        f1 = rt.RooRealVar("f1","f1",1.,-10.,10.)
        f2 = rt.RooRealVar("f2","f2",1.,-10.,10.)
        f3 = rt.RooRealVar("f3","f3",1.,-10.,10.)
        p1 = rt.RooRealVar("p1","p1",-1.,-10.,5.)
        p2 = rt.RooRealVar("p2","p2",-1.,-10.,5.)
        p3 = rt.RooRealVar("p3","p3",-1.,-10.,5.)

        if order ==1:
            empirical = rt.RooGenericPdf("pow","pow", "@2*(@0)^(@1)", rt.RooArgList(x,p1,f1))
        elif order ==2:
            empirical = rt.RooFormulaVar("pow","pow", "@2*(@0)^(@1)+@4*(@0)^(@3)", rt.RooArgList(x,p1,f1,p2,f2))
        else:
            empirical = rt.RooGenericPdf("pow","pow", "@2*(@0)^(@1)+@4*(@0)^(@3)+@6*(@0)^(@5)", rt.RooArgList(x,p1,f1,p2,f2,p3,f3))
    
    elif func_type == 'lau':
        f1 = rt.RooRealVar("f1","f1",0.1,-100.,100.)
        f2 = rt.RooRealVar("f2","f2",0.5,-100.,100.)
        f3 = rt.RooRealVar("f3","f3",0.01,-100.,100.)
        f4 = rt.RooRealVar("f4","f4",0.5,-100.,100.)

        if order ==1:
            empirical = rt.RooGenericPdf("lau","lau", "@1*(@0)^(-4)+@2*(@0)^(-5)", rt.RooArgList(x,f1,f2))
        elif order ==2:
            empirical = rt.RooGenericPdf("lau","lau", "@1*(@0)^(-4)+@2*(@0)^(-5)+@3*(@0)^(-3)", rt.RooArgList(x,f1,f2,f3))
        else:
            empirical = rt.RooGenericPdf("lau","lau", "@1*(@0)^(-4)+@2*(@0)^(-5)+@3*(@0)^(-3)+@4*(@0)^(-6)", rt.RooArgList(x,f1,f2,f3,f4))

    model_final = rt.RooEffProd("model_final", "model_final", core_model, empirical)
    #model_final = rt.RooProdPdf("prodPdf", "Product of Gaussian PDFs", rt.RooArgSet(core_model, empirical), 1)

    model_final.fitTo(dataset, rt.RooFit.Range("fit"), rt.RooFit.Minimizer("Minuit2","migrad"),rt.RooFit.SumW2Error(rt.kTRUE))
    dataset.plotOn(frame)


model_final.plotOn(frame,rt.RooFit.LineColor(rt.kRed), rt.RooFit.Range("fit"), rt.RooFit.NormRange("fit"))

frame.Draw()
canv.Draw()

canv.SaveAs('fit_test_{}.png'.format(cat))