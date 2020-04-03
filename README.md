HHWWgg Flashgg Final Fit
========================
Contacts:

Abraham Tishelman-Charny - abraham.tishelman.charny@cern.ch
Badder Marzocchi - badder.marzocchi@cern.ch
Toyoko Orimoto - Toyoko.Orimoto@cern.ch
Presentations:

21 October 2019 Analysis Status

11 November 2019 Analysis Update

Repositories:
------------

HHWWgg Development

HHWWgg MicroAOD Production

HHWWgg Private MC Production

This repository contains flashgg final fit scripts and instructions specific to the HHWWgg analysis.

Cloning the Repository
==========================
export SCRAM_ARCH=slc7_amd64_gcc700 cmsrel CMSSW_10_2_13 cd CMSSW_10_2_13/src cmsenv git cms-init

Install the GBRLikelihood package which contains the RooDoubleCBFast implementation

git clone git@github.com:jonathon-langford/HiggsAnalysis.git

Install Combine as per the documentation here: cms-analysis.github.io/HiggsAnalysis-CombinedLimit/

git clone git@github.com:cms-analysis/HiggsAnalysis-CombinedLimit.git HiggsAnalysis/CombinedLimit

Compile external libraries
-----------------------
cd HiggsAnalysis 

cmsenv 

scram b -j

Install Flashgg Final Fit packages
===========================
cd .. 

git clone https://github.com/chuwang1/flashggFinalFit.git

cd flashggFinalFit/

HHWWgg_v2-2
-----------
This section describes instructions specific to the HHWWgg_v2-2 tag. The HHWWgg_v2-2 tag is used to mark the point in the anlaysis where the 95% CL limit on the HH cross section was placed on the 250 GeV semileptonically decaying Radion using the HHWWgg tagger plugin with workspaceStd.py WITHOUT systematics. The purpose of the tag is to document everything used to obtain this very preliminary result.

Signal Model
=============
These are the commands to create a signal model with Signal directory using the X250, qqlnu output from the HHWWgg_v2-2 tag of HHWWgg_dev.

Note: This requires that you have the proper user defined paths in flashggFinalFit/Signal/HHWWgg_Signal_Fit_Steps.sh, specifically for the variables fggfinalfitDirec (default:"/afs/cern.ch/work/a/atishelm/8Octflashggfinalfit/CMSSW_7_4_7/src/flashggFinalFit/")

and to use combine:

combineDir (default:"/afs/cern.ch/work/a/atishelm/4NovCombineUpdated/CMSSW_10_2_13/src/HiggsAnalysis/CombinedLimit")

cd Signal

cmsenv

make clean

make

./bin/signalFTest -i Signal_X250.root  -p ggF -f HHWWggTag_0 -o fTestOutput/ --datfilename datfilename.dat --HHWWggLabel X250_WWgg_qqlnugg # ftest 

python shiftHiggsDatasets.py ./ #shift signal to 120 130

./bin/SignalFit -i ./X_signal_250_120_HHWWgg_qqlnu.root,./X_signal_250_125_HHWWgg_qqlnu.root,./X_signal_250_130_HHWWgg_qqlnu.root -p ggF -f HHWWggTag_0 -d datfilename.dat -s empty.dat --procs ggF --changeIntLumi 1 --HHWWggLabel 250  --verbose 2 --useSSF 1 # signal fit  

 ./bin/makeParametricSignalModelPlots -i CMS-HGG_sigfit.root  -o SignalModel/ -p ggF -f HHWWggTag_0     # plot signal model

 python test_makeParametricModelDatacardFLASHgg.py -i CMS-HGG_sigfit.root -o datacardName -p ggF -c HHWWggTag_0 --photonCatScales empty.dat --isMultiPdf --intLumi 41.5# produce datacard


Background Model
================
These are the commands to create a background model with Background directory using the X250, qqlnu output from the HHWWgg_v2-2 tag of HHWWgg_dev:

cd Background 

cmsenv 

make clean

make

./bin/fTest -i ../DataFile.root --saveMultiPdf HHWWgg_Background.root  -D HHWWgg_Background -f HHWWggTag_0 --isData 1

Combine
=============
Note: In order to run this you need combine built with CMSSW_10_2_13 in a separate repository, the path of which is defined by the variable combineDir in the script flashggFinalFit/Signal/HHWWgg_Signal_Fit_Steps.sh

To run combine with the previously created signal and background models:

cd Signal

cmsenv

cp CMS-HGG_sigfit.root CMS-HGG_sigfit_data_ggF_HHWWggTag_0.root

cp ../Background/HHWWgg_Background.root CMS-HGG_mva_13TeV_multipdf.root

cp datacardName CMS-HGG_mva_13TeV_datacard.txt

combine CMS-HGG_mva_13TeV_datacard.txt -m 125 -M AsymptoticLimits --run=blind -v 2

cp higgsCombineTest.AsymptoticLimits.mH125.root ../Plots/FinalResults/



Plot
============
To plot the limit, after copying the proper files to the Plots/FinalResults repository (this needs to be updated to be more flexible code, currently hardcoded):

cd flashggFinalFit/Plots/FinalResults/
cmsenv
make
python plot_limits.py -CMSC
If everything worked properly, there should be an output file called UpperLimit.pdf.
