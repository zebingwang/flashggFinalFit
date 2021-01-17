# Final Fits (lite)
Welcome to the new Final Fits package. Here lies a a series of scripts which are used to run the final stages of the CMS Hgg analysis: signal modelling, background modelling, datacard creation, final statistical interpretation and final result plots.

Slides from the flashgg tutorial series can be found [here](https://indico.cern.ch/event/963619/contributions/4112177/attachments/2151275/3627204/finalfits_tutorial_201126.pdf)


## Download and setup instructions

```
export SCRAM_ARCH=slc7_amd64_gcc700
cmsrel CMSSW_10_2_13
cd CMSSW_10_2_13/src
cmsenv
git cms-init

# Install the GBRLikelihood package which contains the RooDoubleCBFast implementation
git clone git@github.com:jonathon-langford/HiggsAnalysis.git

# Install Combine as per the documentation here: cms-analysis.github.io/HiggsAnalysis-CombinedLimit/
git clone git@github.com:cms-analysis/HiggsAnalysis-CombinedLimit.git HiggsAnalysis/CombinedLimit

# Install Combine Harvester for parallelizing fits
git clone https://github.com/cms-analysis/CombineHarvester.git CombineHarvester

# Compile external libraries
cmsenv
scram b -j 9

# Install Flashgg Final Fit packages
git clone -b dev_fggfinalfits_lite git@github.com:chuwang1/flashggFinalFit.git
cd flashggFinalFit/
```

In every new shell run the following to add `tools/commonTools` and `tools/commonObjects` to your `${PYTHONPATH}`:
```
cmsenv
source setup.sh
```

## simple test
There is a automactic script.Named testRun.sh
Before you run it.
You should set:
- node="cHHH1"
- procs='GluGluToHHTo2G4Q'
- year='2017'
- cat='HHWWggTag_1'
- doHHWWgg='True'
- TreePath='P/eos/user/a/atishelm/ntuples/HHWWgg_flashgg/January_2021_Production/2017/Signal/FH_NLO_2017_hadded/' #path to signal tree
- DataTreeFile='/eos/user/a/atishelm/ntuples/HHWWgg_flashgg/January_2021_Production/2017/Data_Trees/Data_2017.root' #path to data tree file
- doSelections="0" #if you want to applied selections to your tree, then set it to 1
- Selections='dipho_pt > 160' #Here you can define which selections you want to set.

After you set these options,Then you can just run:
```
sh testRun.sh
```


## Contents
The Finals Fits package contains several subfolders which are used for the following steps:

* Create the Signal Model (see `Signal` dir)
* Create the Background Model (see `Background` dir)
* Generate a Datacard (see `Datacard` dir)
* Running fits with combine (see `Combine` dir)
* Scripts to produce plots (see `Plots` dir)

The signal modelling, background modelling and datacard creation can be ran in parallel. Of course the final fits (`Combine`) requires the output of these three steps. In addition, the scripts in the `Trees2WS` dir are a series of lightweight scripts for converting standard ROOT trees into a RooWorkspace that can be read by the Final Fits package.

Finally, the objects and tools which are common to all subfolders are defined in the `tools` directory. If your input workspaces differ from the flashgg output workspace structure, then you may need to change the options here.

Each of the relevant folders are documented with specific `README.md` files. Some (temporary) instructions can be found in this [google docs](https://docs.google.com/document/d/1NwUrPvOZ2bByaHNqt_Fr6oYcP7icpbw1mPlw_3lHhEE/edit)
