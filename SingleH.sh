#!/usr/bin/env bash
eval `scramv1 runtime -sh`
source ./setup.sh
############################################
SingleHiggs=("tth" "wzh" "vbf" "ggh")
Names=("SingleHiggs_ttHJetToGG_2017_CategorizedTrees" "SingleHiggs_VHToGG_2017_CategorizedTrees" "SingleHiggs_VBFHToGG_2017_CategorizedTrees" "SingleHiggs_GluGluHToGG_2017_CategorizedTrees")
years=("2017")
for year in ${years[@]}
do
  for (( i = 0 ; i < 4 ; i++ ))
  do
    Name=${Names[$i]}
    procs=${SingleHiggs[$i]}
    # year='2017'
    ext='SL'
    cat='HHWWggTag_SLDNN_0,HHWWggTag_SLDNN_1,HHWWggTag_SLDNN_2,HHWWggTag_SLDNN_3' #output cat name, it will be used in subsequence step
    InputTreeCats='HHWWggTag_SL_0,HHWWggTag_SL_1,HHWWggTag_SL_2,HHWWggTag_SL_3' #input cat name in the tree
    catNames=(${cat//,/ })
    mass='125'
    TreePath="/eos/user/c/chuw/HHWWgg_ntuple/January_2021_SLDNN/SingleH_withSystematics/"
    doSelections="0"
    Selections='dipho_pt > 54' # Seletions you want to applied.
    Replace="HHWWggTag_SLDNN_0"
    ############################################
    #  Tree selectors#
    #
    ############################################
    cp ./Signal/tools/replacementMapHHWWgg.py ./Signal/tools/replacementMap.py
    sed -i "s#REPLACEMET_CATWV#${Replace}#g" ./Signal/tools/replacementMap.py
    path=`pwd`
    cd ./Reweight/
    echo $Name $procs
    cp SingleHiggsSelections.C SingleHiggsSelections_Run.C
    sed -i "s#NEW_Cat_NAME#${cat}#g" SingleHiggsSelections_Run.C 
    sed -i "s#NAME#${Name}#g" SingleHiggsSelections_Run.C 
    sed -i "s#CAT#${InputTreeCats}#g" SingleHiggsSelections_Run.C
    sed -i "s#PROCS#${procs}#g" SingleHiggsSelections_Run.C
    sed -i "s#YEAR#${year}#g" SingleHiggsSelections_Run.C
    sed -i "s#2017#${year}#g" SingleHiggsSelections_Run.C
    sed -i "s#INPUTPATH#${TreePath}#g" SingleHiggsSelections_Run.C
  if [ "$ext" = "SL" ]
  then
    sed -i "s#tagsDumper/trees/##g" SingleHiggsSelections_Run.C
  fi
    if [ $doSelections -eq "1" ]
    then
      echo "Selection start"
      sed -i "s#SELECTIONS#${Selections}#g" SingleHiggsSelections_Run.C
    else
      echo "Do not apply any selections ,just copytree "
      sed -i "s#SELECTIONS##g" SingleHiggsSelections_Run.C # No Selection 
    fi
  if [ $year -eq "2018" ]
  then
  sed -i "s#metUncUncertainty"#metUncUncertainty","JetHEM"#g" Selections_Run.C
  fi
    root -b -q SingleHiggsSelections_Run.C
    mv ${Name}_${year}.root  ../Trees2WS/
    cd ../Trees2WS/

#########################################
# start tree to workspace
########################################

if [ ! -d "../Signal/Input/" ]; then
  mkdir ../Signal/Input/
fi
# Signal tree to data ws
if [ $year -ne "2017" ]
then
echo "not 2017"
cp HHWWgg_config_noprefire.py HHWWgg_config_run.py
else
cp HHWWgg_config.py HHWWgg_config_run.py
fi
sed -i "s#2017#${year}#g" HHWWgg_config_run.py
sed -i "s#auto#${cat}#g" HHWWgg_config_run.py
echo "python trees2ws.py --inputConfig HHWWgg_config_run.py --inputTreeFile ./${Name}_${cat}_${year}.root --inputMass ${mass} --productionMode ${procs}  --year ${year} --doSystematics"
python trees2ws.py --inputConfig HHWWgg_config_run.py --inputTreeFile ./${Name}_${year}.root --inputMass ${mass} --productionMode ${procs}  --year ${year} --doSystematics
rm HHWWgg_config_run.py
for catName in ${catNames[@]}
do
cp ws_${procs}/${Name}_${year}_${procs}.root ../Signal/Input/output_M125_${procs}_${catName}.root
done
rm ${Name}_${year}.root
#########################################
#shift dataset
#########################################
cd ../Signal/
python ./scripts/shiftHiggsDatasets_single_higgs.py --inputDir ./Input/ --procs ${procs} --cats ${cat}

#######################################
# Run ftest
######################################
echo "Run FTest"
cp HHWWgg_single_higgs.py HHWWgg_config_Run.py
sed -i "s#NODE#node_${node}#g" HHWWgg_config_Run.py
sed -i "s#YEAR#${year}#g" HHWWgg_config_Run.py
sed -i "s#PROCS#${procs}#g" HHWWgg_config_Run.py
sed -i "s#HHWWggTest#${ext}#g" HHWWgg_config_Run.py
sed -i "s#CAT#${cat}#g" HHWWgg_config_Run.py
sed -i "s#INPUTDIR#${path}/Signal/Input/#g" HHWWgg_config_Run.py
python RunSignalScripts.py --inputConfig HHWWgg_config_Run.py --mode fTest --modeOpts "doPlots"

#######################################
# Run photon sys
######################################
python RunSignalScripts.py --inputConfig HHWWgg_config_Run.py --mode calcPhotonSyst


#######################################
#Run signal Fit
#######################################
python RunSignalScripts.py --inputConfig HHWWgg_config_Run.py --mode signalFit --groupSignalFitJobsByCat




rm HHWWgg_config_Run.py


########################################
#           DATACARD                   #
#                                      #
########################################
echo "Start generate datacard(no systeamtics)"
cd ../Datacard
if [ ! -d "./SingleHiggs_${ext}_${year}" ]; then
  mkdir -p ./SingleHiggs_${ext}_${year}/
fi
rm Datacard*.txt
rm -rf yields_test/
#copy signal modl
for catName in ${catNames[@]}
do
cp ${path}/Signal/outdir_${ext}_${year}_single_Higgs/signalFit/output/CMS-HGG_sigfit_${ext}_${year}_single_Higgs_${procs}_${year}_${catName}.root ./SingleHiggs_${ext}_${year}/CMS-HGG_sigfit_packaged_${procs}_${catName}_${year}.root 
done
cd ${path}
done
done
