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


void DataSelections_Run(){
TString InputFile = "INPUTFILE";
TFile *output;
TString outputFile = "Data_13TeV_YEAR.root";
TFile MC_file(InputFile);
output = new TFile(outputFile, "RECREATE");
output->mkdir("tagsDumper/trees");
output->cd("tagsDumper/trees");
vector<string> cats{CAT};
for (auto i = cats.begin(); i != cats.end(); i++){
TString cat=(*i).c_str();
TTree* fChain;
TString TreeName;
TString catName="tagsDumper/trees/Data_13TeV_" + cat;
TString NewCatName = "NEW_Cat_NAME";
TString newTreeName="Data_13TeV_" + NewCatName;
TreeName=catName;
cout<<TreeName<<endl;
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
}
output->Close();
}
