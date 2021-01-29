#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <map>
#include "math.h"

#include "TFile.h"
#include "TMath.h"
#include "TLegend.h"
#include "TCanvas.h"
#include "RooPlot.h"
#include "RooWorkspace.h"
#include "RooDataSet.h"
#include "RooHist.h"
#include "RooAbsData.h"
#include "RooAbsPdf.h"
#include "RooArgSet.h"
#include "RooFitResult.h"
#include "RooMinuit.h"
#include "RooMinimizer.h"
#include "RooMsgService.h"
#include "RooDataHist.h"
#include "RooExtendPdf.h"
#include "TRandom3.h"
#include "TLatex.h"
#include "TMacro.h"
#include "TH1F.h"
#include "TH1I.h"
#include "TArrow.h"
#include "TKey.h"
#include "RooCategory.h"

int splitStringToVect(const string & srcStr, vector<string> & destVect, const string & strFlag);
void SingleHiggsSelections_Run(){
TString Name = "NAME";
TString year = "YEAR";
TString Procs = "PROCS";
TString InputFile = "INPUTPATH" + Name + ".root";
TFile *output;
TString outputFile = "./" + Name +"_"+ year +".root";
TFile MC_file(InputFile);
output = new TFile(outputFile, "RECREATE");
output->mkdir("tagsDumper/trees");
TTree* fChain;
// vector<string> cats{"HHWWggTag_0","HHWWggTag_1","HHWWggTag_2","HHWWggTag_3"};
// vector<string> cats{"HHWWggTag_3","HHWWggTag_2"};
vector<string> cats;
string cats_string="CAT";
splitStringToVect(cats_string, cats, ",");
// vector<string> systematics{""};
vector<string> systematics{"","FNUFEB","FNUFEE","JECAbsolute2017","JECAbsolute","JECBBEC12017",
"JECBBEC1","JECEC22017","JECEC2","JECFlavorQCD","JECHF2017","JECHF","JECRelativeBal",
"JECRelativeSample2017","JEC","JER","MCScaleGain1EB","MCScaleGain6EB","MCScaleHighR9EB",
"MCScaleHighR9EE","MCScaleLowR9EB","MCScaleLowR9EE","MCSmearHighR9EBPhi","MCSmearHighR9EBRho",
"MCSmearHighR9EEPhi","MCSmearHighR9EERho","MCSmearLowR9EBPhi","MCSmearLowR9EBRho",
"MCSmearLowR9EEPhi","MCSmearLowR9EERho","MaterialCentralBarrel","MaterialForward",
"MaterialOuterBarrel","MvaShift","PUJIDShift","ShowerShapeHighR9EB","ShowerShapeHighR9EE",
"ShowerShapeLowR9EB","ShowerShapeLowR9EE","SigmaEOverEShift",
"metJecUncertainty","metJerUncertainty","metPhoUncertainty","metUncUncertainty"};
vector<string> shifts{"Up","Down"};
TString TreeName;
vector<string>NewCatName;
string NewCatString="NEW_Cat_NAME";
splitStringToVect(NewCatString, NewCatName, ",");

for (int i = 0; i < cats.size(); i++){//cats loop
TString cat=cats[i];
TString catName="tagsDumper/trees/"+ Procs + "_125_13TeV_" + cat;
TString newCatName=Procs + "_125_13TeV_" + NewCatName[i];
TString newTreeName;
for (auto j = systematics.begin(); j != systematics.end(); j++){//sys loop`

TString sys=(*j).c_str();
for (auto k = shifts.begin(); k != shifts.end(); k++){//up and down shift 
TString shift=(*k).c_str();
if ( sys == "" )
{
  TreeName=catName;
  newTreeName=newCatName;
}
else
{ 
  TreeName=catName + "_" + sys + shift + "01sigma";
  newTreeName=newCatName + "_" + sys + shift + "01sigma";
}
cout<<TreeName<<endl;
MC_file.GetObject(TreeName,fChain);
   output->cd("tagsDumper/trees");
   TTree *newtree = fChain->CopyTree("SELECTIONS");
   int Nevents=newtree->GetEntries();
   int nevents=fChain->GetEntries();
   cout<<"Original number of events:"<<nevents<<" selected number of events:"<<Nevents<<endl;
   newtree->SetName(newTreeName);
  newtree->Write("",TObject::kOverwrite);
  if( sys == ""){
  break;
  }
}// up and down shift 
  if( cat == "HHWWggTag_3"){
  break;
  }
}//sys loop
}//cats loop
output->Close();
}

int splitStringToVect(const string & srcStr, vector<string> & destVect, const string & strFlag)
{
    int pos = srcStr.find(strFlag, 0);
    int startPos = 0;
    int splitN = pos;
    string lineText(strFlag);

    while (pos > -1)
    {
        lineText = srcStr.substr(startPos, splitN);
        startPos = pos + 1;
        pos = srcStr.find(strFlag, pos + 1);
        splitN = pos - startPos;
        destVect.push_back(lineText);
    }

    lineText = srcStr.substr(startPos, srcStr.length() - startPos);
    destVect.push_back(lineText);

    return destVect.size();
}

