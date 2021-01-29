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

void Selections_Run(){
  TString Process = "PROCS";
  TString year = "YEAR";
  // TString NewCatName = "NEW_Cat_NAME";
  TString input_node = "NODE";
  TString InputFile = "INPUTFILE";
  TFile *output;
  TString outputFile = "./" + Process + "_node_" + input_node  + "_" + year + ".root";
  TFile MC_file(InputFile);
  output = new TFile(outputFile, "RECREATE");
  output->mkdir("tagsDumper/trees");
  output->cd("tagsDumper/trees");
  TTree* fChain;
  string cats_string="CAT";
  vector<string> cats;
  splitStringToVect(cats_string, cats, ",");
  vector<string>NewCatName; 
  string NewCatString="NEW_Cat_NAME";
  splitStringToVect(NewCatString, NewCatName, ",");
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
  TString newTreeName;
  // for (auto i = cats.begin(); i != cats.end(); i++){//cats loop
  for (int i = 0; i < cats.size(); i++){//cats loop
    // TString cat=(*i).c_str();
    TString cat=cats[i];
    TString catName="tagsDumper/trees/" + Process + "_node_" + input_node + "_13TeV_" + cat;
    TString newCatName=Process + "_node_" + input_node + "_13TeV_" + NewCatName[i];
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
        cout<<"old name:"<<TreeName<<" ,new name:"<<newTreeName<<endl;
        MC_file.GetObject(TreeName,fChain);
        TTree *newtree = fChain->CopyTree("SELECTIONS");
        // int nevents=fChain->GetEntries();
        // for (int i = 0; i< nevents; i=i+1){
          // fChain->GetEntry(i);
          // if ( SELECTIONS ){
            // newtree->Fill();
          // }
        // }
        newtree->SetName(newTreeName);
        newtree->Write("",TObject::kOverwrite);
        cout<<"write over"<<endl;
        if( sys == ""){
          break;
        }
      }// up and down shift 
      // if( cat == "HHWWggTag_3"){
        // break;
      // }
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
