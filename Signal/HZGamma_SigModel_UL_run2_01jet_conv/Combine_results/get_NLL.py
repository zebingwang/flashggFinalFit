from ROOT import *

file_bkg = TFile("CMS-HGG_mva_13TeV_multipdf_cat3.root")

file_bkg.multipdf.Print()

mass = file_bkg.multipdf.var("CMS_hzg_mass")
data_fit = file_bkg.multipdf.data("roohist_data_mass_cat0")
bkg_fit = file_bkg.multipdf.pdf("CMS_hgg_untag_cat3_bkgshape")
bkg_fit_norm = file_bkg.multipdf.var("CMS_hgg_untag_cat3_bkgshape_norm")
bkg_fit_id = file_bkg.multipdf.var("pdfindex_untag_cat3")

print(bkg_fit_norm.getVal(), bkg_fit_id)

obs_data = data_fit.get()
xdata = obs_data.find(mass.GetName())

print(bkg_fit.getVal())

for i in range(data_fit.numEntries()):
    data_fit.get(i)
    x_value = xdata.getVal()
    mass.setVal(x_value)

    print(x_value, data_fit.weight(), bkg_fit.getVal())

