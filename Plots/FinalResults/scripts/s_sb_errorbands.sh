#!/bin/bash

# Usage of this scipt
#./s_sb_errorbands.sh <index> <working directory> <MHhat> <Muhat>
# your input rool file must be called inputfile.root
nToys=$5
MHhat=$3
Muhat=$4
dir=$2 
((startIndex=$1*10000))
index=$startIndex

cd $dir
eval `scramv1 runtime -sh`


while (( $index < $startIndex+ $nToys)); 
do
echo "---> combine cms_hgg_datacard_FiducialRDiffXsScan_postFit.root -m $MHhat --snapshotName MultiDimFit -M GenerateOnly --saveWorkspace --toysFrequentist --bypassFrequentistFit -t 1 --expectSignal=$Muhat -n combout_step0_$index -s -1"
#combine inputfile.root  -m $MHhat --snapshotName MultiDimFit -M GenerateOnly --saveWorkspace --toysFrequentist --bypassFrequentistFit -t 1 --expectSignal=$Muhat -n combout_step0_$index -s -1 --setParameters sig_contribution=0 --freezeParameters sig_contribution
combine inputfile.root  -m $MHhat --snapshotName MultiDimFit -M GenerateOnly --saveWorkspace --toysFrequentist --bypassFrequentistFit -t 1 --expectSignal=$Muhat -n combout_step0_$index -s -1 --setParameters sig_contribution=0,MH=125 --freezeParameters sig_contribution,MH 

ls higgsCombinecombout_step0_${1}*.root
mv higgsCombinecombout_step0_${1}*.root higgsCombinecombout_step0_done_$index.root

echo "---> combine higgsCombinecombout_step0_done_$index.root -m $MHhat -M MultiDimFit --floatOtherPOIs=1 --saveWorkspace --toysFrequentist --bypassFrequentistFit -t 1 --expectSignal=$Muhat -n combout_step1_$index -s -1"
#combine higgsCombinecombout_step0_done_$index.root -m $MHhat -M MultiDimFit --floatOtherPOIs=1 --saveWorkspace --toysFrequentist --bypassFrequentistFit -t 1 --expectSignal=$Muhat -n combout_step1_$index -s -1
#combine higgsCombinecombout_step0_done_$index.root -m $MHhat -M MultiDimFit --floatOtherPOIs=1 --saveWorkspace --toysFrequentist --bypassFrequentistFit -t 1 --expectSignal=$Muhat -n combout_step1_$index -s -1 --setParameters sig_contribution=0 --freezeParameters sig_contribution --cminDefaultMinimizerType Minuit2 --cminDefaultMinimizerStrategy 1 --cminDefaultMinimizerTolerance 0.1 --cminFallbackAlgo Minuit2,0:0.1 --X-rtd REMOVE_CONSTANT_ZERO_POINT=1 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants --X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2 --robustFit 1
combine higgsCombinecombout_step0_done_$index.root -m $MHhat -M MultiDimFit --floatOtherPOIs=1 --saveWorkspace --toysFrequentist --bypassFrequentistFit -t 1 --expectSignal=$Muhat -n combout_step1_$index -s -1 --setParameters sig_contribution=0,MH=125 --freezeParameters sig_contribution,MH --cminDefaultMinimizerType Minuit2 --cminDefaultMinimizerStrategy 1 --cminDefaultMinimizerTolerance 0.1 --cminFallbackAlgo Minuit2,0:0.1 --X-rtd REMOVE_CONSTANT_ZERO_POINT=1 --X-rtd MINIMIZER_freezeDisassociatedParams --X-rtd MINIMIZER_multiMin_hideConstants --X-rtd MINIMIZER_multiMin_maskConstraints --X-rtd MINIMIZER_multiMin_maskChannels=2 --robustFit 1

ls higgsCombinecombout_step1_${1}*.root
mv higgsCombinecombout_step1_${1}*.root higgsCombinecombout_step1_done_$index.root

echo "---> combine higgsCombinecombout_step1_done_$index.root -m $MHhat --snapshotName MultiDimFit -M GenerateOnly --saveToys --toysFrequentist --bypassFrequentistFit -t -1 -n combout_step2_$index"
combine higgsCombinecombout_step1_done_$index.root -m $MHhat --snapshotName MultiDimFit -M GenerateOnly --saveToys --toysFrequentist --bypassFrequentistFit -t -1 -n combout_step2_$index --setParameters sig_contribution=0,MH=125 --freezeParameters sig_contribution,MH 

ls higgsCombinecombout_step2_${1}*.root
mv higgsCombinecombout_step2_${1}*.root higgsCombinecombout_step2_done_$index.root

(( index=$index+1))
done;

