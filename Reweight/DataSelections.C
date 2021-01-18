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
TString outputFile = "Data_13TeV_CAT_YEAR.root";
TFile MC_file(InputFile);
output = new TFile(outputFile, "RECREATE");
output->mkdir("tagsDumper/trees");
TTree* fChain;
TString TreeName;
TString catName="tagsDumper/trees/Data_13TeV_CAT";
TreeName=catName;
cout<<TreeName<<endl;
MC_file.GetObject(TreeName,fChain);
   output->cd("tagsDumper/trees");
   TTree *newtree = fChain->CopyTree("SELECTIONS");
   // int nevents=fChain->GetEntries();
  // for (int i = 0; i< nevents; i=i+1){
      // fChain->GetEntry(i);
      // if ( SELECTIONS ){
      // newtree->Fill();
      // }
  // }
  newtree->Write("",TObject::kOverwrite);
output->Close();
}

