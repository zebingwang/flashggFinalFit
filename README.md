ALP Flashgg Final Fit
========================
Contacts:

Repositories:
------------

Cloning the Repository
---------------
```
export SCRAM_ARCH=slc7_amd64_gcc700

cmsrel CMSSW_10_2_13

cd CMSSW_10_2_13/src

cmsenv

git cms-init
```

Install the GBRLikelihood package which contains the RooDoubleCBFast implementation
```
git clone git@github.com:jonathon-langford/HiggsAnalysis.git
```
Install Combine as per the documentation here: cms-analysis.github.io/HiggsAnalysis-CombinedLimit/
```
git clone git@github.com:cms-analysis/HiggsAnalysis-CombinedLimit.git HiggsAnalysis/CombinedLimit
```
Compile external libraries
-----------------------
```
cd HiggsAnalysis

cmsenv

scram b -j
```
Install Flashgg Final Fit packages
-----------------------
```
cd ..

git clone https://github.com/zebingwang/flashggFinalFit.git

cd flashggFinalFit/
```



```
cd Signal

cmsenv

make clean

make

```

Background Model
--------------

```
cd Background

cmsenv

make clean

make

```
Run
-----

```
./fit_ALP.sh
```
