#!/bin/bash

year=( 16 16APV 17 18 )
nYear=${#year[@]}
massList=( 11 12 13 14 16 17 18 19 21 22 23 24 26 27 28 29 )
#massList=( 11 )
massList_sig=( 10 10 15 15 15 15 20 20 20 20 25 25 25 25 30 30 )
#massList=( 4 )
nMass=${#massList[@]}

cd ./Signal
mkdir ./ALP_SigModel_param_UL/fit_results_runII

for ((iBin=0; iBin<$nMass; iBin++))
    do
    mkdir ./ALP_SigModel_param_UL/fit_results_runII/M${massList[$iBin]}

    
    cp ./ALP_SigModel_param_UL/fit_results_run2_mu/M${massList_sig[$iBin]}/16/CMS-HGG_sigfit_data_ggh_cat0.root ./ALP_SigModel_param_UL/fit_results_runII/M${massList[$iBin]}/CMS-HGG_sigfit_data_ggh_cat0_16_mu.root
    cp ./ALP_SigModel_param_UL/fit_results_run2_mu/M${massList_sig[$iBin]}/16APV/CMS-HGG_sigfit_data_ggh_cat0.root ./ALP_SigModel_param_UL/fit_results_runII/M${massList[$iBin]}/CMS-HGG_sigfit_data_ggh_cat0_16APV_mu.root
    cp ./ALP_SigModel_param_UL/fit_results_run2_mu/M${massList_sig[$iBin]}/17/CMS-HGG_sigfit_data_ggh_cat0.root ./ALP_SigModel_param_UL/fit_results_runII/M${massList[$iBin]}/CMS-HGG_sigfit_data_ggh_cat0_17_mu.root
    cp ./ALP_SigModel_param_UL/fit_results_run2_mu/M${massList_sig[$iBin]}/18/CMS-HGG_sigfit_data_ggh_cat0.root ./ALP_SigModel_param_UL/fit_results_runII/M${massList[$iBin]}/CMS-HGG_sigfit_data_ggh_cat0_18_mu.root
    
    
    cp ./ALP_SigModel_param_UL/fit_results_run2_ele/M${massList_sig[$iBin]}/16/CMS-HGG_sigfit_data_ggh_cat0.root ./ALP_SigModel_param_UL/fit_results_runII/M${massList[$iBin]}/CMS-HGG_sigfit_data_ggh_cat0_16_ele.root
    cp ./ALP_SigModel_param_UL/fit_results_run2_ele/M${massList_sig[$iBin]}/16APV/CMS-HGG_sigfit_data_ggh_cat0.root ./ALP_SigModel_param_UL/fit_results_runII/M${massList[$iBin]}/CMS-HGG_sigfit_data_ggh_cat0_16APV_ele.root
    cp ./ALP_SigModel_param_UL/fit_results_run2_ele/M${massList_sig[$iBin]}/17/CMS-HGG_sigfit_data_ggh_cat0.root ./ALP_SigModel_param_UL/fit_results_runII/M${massList[$iBin]}/CMS-HGG_sigfit_data_ggh_cat0_17_ele.root
    cp ./ALP_SigModel_param_UL/fit_results_run2_ele/M${massList_sig[$iBin]}/18/CMS-HGG_sigfit_data_ggh_cat0.root ./ALP_SigModel_param_UL/fit_results_runII/M${massList[$iBin]}/CMS-HGG_sigfit_data_ggh_cat0_18_ele.root
    
    cp ../Background/ALP_BkgModel_param_UL/fit_results_run2/${massList[$iBin]}/CMS-HGG_mva_13TeV_multipdf.root ./ALP_SigModel_param_UL/fit_results_runII/M${massList[$iBin]}
    
    
    python makeParametricModelDatacard_ALP_UL.py -i ./ALP_SigModel_param_UL/fit_results_runII/M${massList[$iBin]}/CMS-HGG_sigfit_data_ggh_cat0_16_ele.root,./ALP_SigModel_param_UL/fit_results_runII/M${massList[$iBin]}/CMS-HGG_sigfit_data_ggh_cat0_16APV_ele.root,./ALP_SigModel_param_UL/fit_results_runII/M${massList[$iBin]}/CMS-HGG_sigfit_data_ggh_cat0_17_ele.root,./ALP_SigModel_param_UL/fit_results_runII/M${massList[$iBin]}/CMS-HGG_sigfit_data_ggh_cat0_18_ele.root,./ALP_SigModel_param_UL/fit_results_runII/M${massList[$iBin]}/CMS-HGG_sigfit_data_ggh_cat0_16_mu.root,./ALP_SigModel_param_UL/fit_results_runII/M${massList[$iBin]}/CMS-HGG_sigfit_data_ggh_cat0_16APV_mu.root,./ALP_SigModel_param_UL/fit_results_runII/M${massList[$iBin]}/CMS-HGG_sigfit_data_ggh_cat0_17_mu.root,./ALP_SigModel_param_UL/fit_results_runII/M${massList[$iBin]}/CMS-HGG_sigfit_data_ggh_cat0_18_mu.root -s ./ALP_sys_UL/shapeSys/fit_run2_UL_ScaleSmear_ele/ScaleSmear_plot/ScaleSmear_m${massList_sig[$iBin]}_16.dat,./ALP_sys_UL/shapeSys/fit_run2_UL_ScaleSmear_ele/ScaleSmear_plot/ScaleSmear_m${massList_sig[$iBin]}_16APV.dat,./ALP_sys_UL/shapeSys/fit_run2_UL_ScaleSmear_ele/ScaleSmear_plot/ScaleSmear_m${massList_sig[$iBin]}_17.dat,./ALP_sys_UL/shapeSys/fit_run2_UL_ScaleSmear_ele/ScaleSmear_plot/ScaleSmear_m${massList_sig[$iBin]}_18.dat,./ALP_sys_UL/shapeSys/fit_run2_UL_ScaleSmear_mu/ScaleSmear_plot/ScaleSmear_m${massList_sig[$iBin]}_16.dat,./ALP_sys_UL/shapeSys/fit_run2_UL_ScaleSmear_mu/ScaleSmear_plot/ScaleSmear_m${massList_sig[$iBin]}_16APV.dat,./ALP_sys_UL/shapeSys/fit_run2_UL_ScaleSmear_mu/ScaleSmear_plot/ScaleSmear_m${massList_sig[$iBin]}_17.dat,./ALP_sys_UL/shapeSys/fit_run2_UL_ScaleSmear_mu/ScaleSmear_plot/ScaleSmear_m${massList_sig[$iBin]}_18.dat -o ./ALP_SigModel_param_UL/fit_results_runII/M${massList[$iBin]}/datacard_ALPmass${massList[$iBin]}.txt --NormSys ./ALP_sys_UL/NormSys/NormalizationSys_16_ele.txt,./ALP_sys_UL/NormSys/NormalizationSys_16APV_ele.txt,./ALP_sys_UL/NormSys/NormalizationSys_17_ele.txt,./ALP_sys_UL/NormSys/NormalizationSys_18_ele.txt,./ALP_sys_UL/NormSys/NormalizationSys_16_mu.txt,./ALP_sys_UL/NormSys/NormalizationSys_16APV_mu.txt,./ALP_sys_UL/NormSys/NormalizationSys_17_mu.txt,./ALP_sys_UL/NormSys/NormalizationSys_18_mu.txt --BDTSys ./ALP_sys_UL/BDTSys/BDTSys_16_ele.txt,./ALP_sys_UL/BDTSys/BDTSys_16APV_ele.txt,./ALP_sys_UL/BDTSys/BDTSys_17_ele.txt,./ALP_sys_UL/BDTSys/BDTSys_18_ele.txt,./ALP_sys_UL/BDTSys/BDTSys_16_mu.txt,./ALP_sys_UL/BDTSys/BDTSys_16APV_mu.txt,./ALP_sys_UL/BDTSys/BDTSys_17_mu.txt,./ALP_sys_UL/BDTSys/BDTSys_18_mu.txt -p ggH_16_ele,ggH_16APV_ele,ggH_17_ele,ggH_18_ele,ggH_16_mu,ggH_16APV_mu,ggH_17_mu,ggH_18_mu -c cat0 --isMultiPdf -m 125 --mA ${massList[$iBin]} --interp ./ALP_sys_UL/eff.txt

    cd ./ALP_SigModel_param_UL/fit_results_runII/M${massList[$iBin]}
    pwd
    combine datacard_ALPmass${massList[$iBin]}.txt -M AsymptoticLimits --run=blind -m 125 --rAbsAcc 0.00000001 --rMin -200 --rMax 200
    
    #text2workspace.py datacard_ALPmass${massList[$iBin]}.txt -m 125 -o datacard_ALPmass${massList[$iBin]}.root

    #combineTool.py -M Impacts -d datacard_ALPmass${massList[$iBin]}.root -m 125 --rMin -1 --rMax 10 --robustFit 1 --doInitialFit -t -1 --expectSignal 1 --cminDefaultMinimizerStrategy 0 --setParameters MH=125 --freezeParameters MH
    #combineTool.py -M Impacts -d datacard_ALPmass${massList[$iBin]}.root -m 125 --rMin -1 --rMax 10 --robustFit 1 --doFits -t -1 --expectSignal 1 --cminDefaultMinimizerStrategy 0 --setParameters MH=125 --freezeParameters MH
    #combineTool.py -M Impacts -d datacard_ALPmass${massList[$iBin]}.root -m 125 -o M${massList[$iBin]}_Expected.json
    #plotImpacts.py -i M${massList[$iBin]}_Expected.json -o M${massList[$iBin]}_Expected_Impact
    cd ../../../
    
    
done

cd ./ALP_SigModel_param_UL/fit_results_runII
mkdir plot
cd plot
cp ../../../ALP_plot_param_UL_ele/*.py ./
sed -i "33s/fit_results_run2_/fit_results_/" com_plot.py
python com_plot.py -fb -y run2 -c runII --interp
