import ROOT as rt

f = rt.TFile("ZGCoreShape.root")
w = f.Get("w")
w.Print()
cat = "cat3"
core_model = w.pdf("CoreShape_{}".format(cat))
x = w.var("CMS_hzg_mass")
#x.setRange(105, 170)
#x.setRange("Rall",100,180) 

f_data = rt.TFile("dataTest.root")
w_data = f_data.Get("w")
w_data.Print()
dataset = w_data.data("{}".format(cat))
dataset.Print()


f1 = rt.RooRealVar("f1","f1",1,0.,10.)
f2 = rt.RooRealVar("f2","f2",1,0.,10.)
f3 = rt.RooRealVar("f3","f3",1,0.,10.)
p1 = rt.RooRealVar("p1","p1",-0.5,-10.,1.)
p2 = rt.RooRealVar("p2","p2",-0.1,-10.,1.)
p3 = rt.RooRealVar("p3","p3",-0.1,-10.,1.)

#pdf_exp = RooExponential("exp","exp",mass_,p1)
exp_order1 = rt.RooGenericPdf("exp_order1", "exp_order1","@2*exp(@1*@0)",rt.RooArgList(x,p1,f1))
exp_order2 = rt.RooFormulaVar("exp_order2", "exp_order2","@3*exp(@1*@0)+@4*exp(@2*@0)",rt.RooArgList(x,p1,p2,f1,f2))
exp_order3 = rt.RooFormulaVar("exp_order3", "exp_order3","@4*exp(@1*@0)+@5*exp(@2*@0)+@6*exp(@3*@0)",rt.RooArgSet(x,p1,p2,p3,f1,f2,f3))

model_final = rt.RooEffProd("model_final", "model_final", core_model, exp_order1)

model_final.fitTo(dataset)

canv = rt.TCanvas("c1","c1",800,1000)
frame = x.frame()

dataset.plotOn(frame)
model_final.plotOn(frame,rt.RooFit.LineColor(rt.kRed))

frame.Draw()
canv.Draw()

canv.SaveAs('fit_test_{}.png'.format(cat))