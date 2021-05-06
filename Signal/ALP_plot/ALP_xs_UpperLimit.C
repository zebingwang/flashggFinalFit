void ALP_xs_UpperLimit()
{
//=========Macro generated from canvas: c/c
//=========  (Thu May  6 13:48:35 2021) by ROOT version 6.12/07
   TCanvas *c = new TCanvas("c", "c",0,0,800,600);
   gStyle->SetOptFit(1);
   gStyle->SetOptStat(0);
   gStyle->SetOptTitle(0);
   c->SetHighLightColor(2);
   c->Range(-4.571429,-1.885463,33.52381,5.493399);
   c->SetFillColor(0);
   c->SetBorderMode(0);
   c->SetBorderSize(2);
   c->SetLogy();
   c->SetGridx();
   c->SetGridy();
   c->SetTickx(1);
   c->SetTicky(1);
   c->SetLeftMargin(0.12);
   c->SetRightMargin(0.04);
   c->SetTopMargin(0.08);
   c->SetBottomMargin(0.12);
   c->SetFrameFillStyle(0);
   c->SetFrameBorderMode(0);
   c->SetFrameFillStyle(0);
   c->SetFrameBorderMode(0);
   
   TH1F *hframe__3 = new TH1F("hframe__3","",1000,0,32);
   hframe__3->SetMinimum(0.1);
   hframe__3->SetMaximum(80000);
   hframe__3->SetDirectory(0);
   hframe__3->SetStats(0);
   hframe__3->SetLineStyle(0);
   hframe__3->SetMarkerStyle(20);
   hframe__3->GetXaxis()->SetTitle("m_{a} [GeV]");
   hframe__3->GetXaxis()->SetNdivisions(508);
   hframe__3->GetXaxis()->SetLabelFont(42);
   hframe__3->GetXaxis()->SetLabelOffset(0.007);
   hframe__3->GetXaxis()->SetTitleSize(0.05);
   hframe__3->GetXaxis()->SetTitleOffset(0.9);
   hframe__3->GetXaxis()->SetTitleFont(42);
   hframe__3->GetYaxis()->SetTitle("95% CL limits on #sigma(pp#rightarrow H#rightarrow Za#rightarrow 2l + 2#gamma)(fb)");
   hframe__3->GetYaxis()->CenterTitle(true);
   hframe__3->GetYaxis()->SetNdivisions(10);
   hframe__3->GetYaxis()->SetLabelFont(42);
   hframe__3->GetYaxis()->SetLabelOffset(0.007);
   hframe__3->GetYaxis()->SetTitleOffset(1.3);
   hframe__3->GetYaxis()->SetTitleFont(42);
   hframe__3->GetZaxis()->SetLabelFont(42);
   hframe__3->GetZaxis()->SetLabelOffset(0.007);
   hframe__3->GetZaxis()->SetLabelSize(0.05);
   hframe__3->GetZaxis()->SetTitleSize(0.06);
   hframe__3->GetZaxis()->SetTitleFont(42);
   hframe__3->Draw(" ");
   
   Double_t Graph0_fx4[6] = {
   5,
   15,
   30,
   30,
   15,
   5};
   Double_t Graph0_fy4[6] = {
   13.71441,
   17.05051,
   14.76052,
   3.578186,
   3.479004,
   2.849579};
   TGraph *graph = new TGraph(6,Graph0_fx4,Graph0_fy4);
   graph->SetName("Graph0");
   graph->SetTitle("Graph");

   Int_t ci;      // for color index setting
   TColor *color; // for color definition with alpha
   ci = TColor::GetColor("#ffcc00");
   graph->SetFillColor(ci);

   ci = TColor::GetColor("#ffcc00");
   graph->SetLineColor(ci);
   graph->SetMarkerStyle(20);
   
   TH1F *Graph_Graph4 = new TH1F("Graph_Graph4","Graph",100,2.5,32.5);
   Graph_Graph4->SetMinimum(1.429485);
   Graph_Graph4->SetMaximum(18.47061);
   Graph_Graph4->SetDirectory(0);
   Graph_Graph4->SetStats(0);
   Graph_Graph4->SetLineStyle(0);
   Graph_Graph4->SetMarkerStyle(20);
   Graph_Graph4->GetXaxis()->SetLabelFont(42);
   Graph_Graph4->GetXaxis()->SetLabelOffset(0.007);
   Graph_Graph4->GetXaxis()->SetLabelSize(0.05);
   Graph_Graph4->GetXaxis()->SetTitleSize(0.06);
   Graph_Graph4->GetXaxis()->SetTitleOffset(0.9);
   Graph_Graph4->GetXaxis()->SetTitleFont(42);
   Graph_Graph4->GetYaxis()->SetNdivisions(10);
   Graph_Graph4->GetYaxis()->SetLabelFont(42);
   Graph_Graph4->GetYaxis()->SetLabelOffset(0.007);
   Graph_Graph4->GetYaxis()->SetLabelSize(0.05);
   Graph_Graph4->GetYaxis()->SetTitleSize(0.06);
   Graph_Graph4->GetYaxis()->SetTitleOffset(1.25);
   Graph_Graph4->GetYaxis()->SetTitleFont(42);
   Graph_Graph4->GetZaxis()->SetLabelFont(42);
   Graph_Graph4->GetZaxis()->SetLabelOffset(0.007);
   Graph_Graph4->GetZaxis()->SetLabelSize(0.05);
   Graph_Graph4->GetZaxis()->SetTitleSize(0.06);
   Graph_Graph4->GetZaxis()->SetTitleFont(42);
   graph->SetHistogram(Graph_Graph4);
   
   graph->Draw("f");
   
   Double_t Graph1_fx5[6] = {
   5,
   15,
   30,
   30,
   15,
   5};
   Double_t Graph1_fy5[6] = {
   9.301899,
   11.44529,
   10.43272,
   4.799843,
   4.926777,
   4.035419};
   graph = new TGraph(6,Graph1_fx5,Graph1_fy5);
   graph->SetName("Graph1");
   graph->SetTitle("Graph");

   ci = TColor::GetColor("#00cc00");
   graph->SetFillColor(ci);

   ci = TColor::GetColor("#00cc00");
   graph->SetLineColor(ci);
   graph->SetMarkerStyle(20);
   
   TH1F *Graph_Graph5 = new TH1F("Graph_Graph5","Graph",100,2.5,32.5);
   Graph_Graph5->SetMinimum(3.294432);
   Graph_Graph5->SetMaximum(12.18627);
   Graph_Graph5->SetDirectory(0);
   Graph_Graph5->SetStats(0);
   Graph_Graph5->SetLineStyle(0);
   Graph_Graph5->SetMarkerStyle(20);
   Graph_Graph5->GetXaxis()->SetLabelFont(42);
   Graph_Graph5->GetXaxis()->SetLabelOffset(0.007);
   Graph_Graph5->GetXaxis()->SetLabelSize(0.05);
   Graph_Graph5->GetXaxis()->SetTitleSize(0.06);
   Graph_Graph5->GetXaxis()->SetTitleOffset(0.9);
   Graph_Graph5->GetXaxis()->SetTitleFont(42);
   Graph_Graph5->GetYaxis()->SetNdivisions(10);
   Graph_Graph5->GetYaxis()->SetLabelFont(42);
   Graph_Graph5->GetYaxis()->SetLabelOffset(0.007);
   Graph_Graph5->GetYaxis()->SetLabelSize(0.05);
   Graph_Graph5->GetYaxis()->SetTitleSize(0.06);
   Graph_Graph5->GetYaxis()->SetTitleOffset(1.25);
   Graph_Graph5->GetYaxis()->SetTitleFont(42);
   Graph_Graph5->GetZaxis()->SetLabelFont(42);
   Graph_Graph5->GetZaxis()->SetLabelOffset(0.007);
   Graph_Graph5->GetZaxis()->SetLabelSize(0.05);
   Graph_Graph5->GetZaxis()->SetTitleSize(0.06);
   Graph_Graph5->GetZaxis()->SetTitleFont(42);
   graph->SetHistogram(Graph_Graph5);
   
   graph->Draw("f");
   
   Double_t Graph2_fx6[3] = {
   5,
   15,
   30};
   Double_t Graph2_fy6[3] = {
   6.079102,
   7.421875,
   6.835938};
   graph = new TGraph(3,Graph2_fx6,Graph2_fy6);
   graph->SetName("Graph2");
   graph->SetTitle("Graph");
   graph->SetFillStyle(1000);
   graph->SetLineStyle(2);
   graph->SetLineWidth(2);
   graph->SetMarkerStyle(20);
   
   TH1F *Graph_Graph6 = new TH1F("Graph_Graph6","Graph",100,2.5,32.5);
   Graph_Graph6->SetMinimum(5.944824);
   Graph_Graph6->SetMaximum(7.556152);
   Graph_Graph6->SetDirectory(0);
   Graph_Graph6->SetStats(0);
   Graph_Graph6->SetLineStyle(0);
   Graph_Graph6->SetMarkerStyle(20);
   Graph_Graph6->GetXaxis()->SetLabelFont(42);
   Graph_Graph6->GetXaxis()->SetLabelOffset(0.007);
   Graph_Graph6->GetXaxis()->SetLabelSize(0.05);
   Graph_Graph6->GetXaxis()->SetTitleSize(0.06);
   Graph_Graph6->GetXaxis()->SetTitleOffset(0.9);
   Graph_Graph6->GetXaxis()->SetTitleFont(42);
   Graph_Graph6->GetYaxis()->SetNdivisions(10);
   Graph_Graph6->GetYaxis()->SetLabelFont(42);
   Graph_Graph6->GetYaxis()->SetLabelOffset(0.007);
   Graph_Graph6->GetYaxis()->SetLabelSize(0.05);
   Graph_Graph6->GetYaxis()->SetTitleSize(0.06);
   Graph_Graph6->GetYaxis()->SetTitleOffset(1.25);
   Graph_Graph6->GetYaxis()->SetTitleFont(42);
   Graph_Graph6->GetZaxis()->SetLabelFont(42);
   Graph_Graph6->GetZaxis()->SetLabelOffset(0.007);
   Graph_Graph6->GetZaxis()->SetLabelSize(0.05);
   Graph_Graph6->GetZaxis()->SetTitleSize(0.06);
   Graph_Graph6->GetZaxis()->SetTitleFont(42);
   graph->SetHistogram(Graph_Graph6);
   
   graph->Draw("l");
   TLatex *   tex = new TLatex(0.96,0.936,"41.5 fb^{-1} (13 TeV)");
tex->SetNDC();
   tex->SetTextAlign(31);
   tex->SetTextFont(42);
   tex->SetTextSize(0.048);
   tex->SetLineWidth(2);
   tex->Draw();
      tex = new TLatex(0.12,0.936,"CMS");
tex->SetNDC();
   tex->SetTextFont(61);
   tex->SetTextSize(0.052);
   tex->SetLineWidth(2);
   tex->Draw();
      tex = new TLatex(0.1578,0.892,"Private");
tex->SetNDC();
   tex->SetTextAlign(13);
   tex->SetTextFont(52);
   tex->SetTextSize(0.03952);
   tex->SetLineWidth(2);
   tex->Draw();
   
   TH1F *hframe__4 = new TH1F("hframe__4","",1000,0,32);
   hframe__4->SetMinimum(0.1);
   hframe__4->SetMaximum(80000);
   hframe__4->SetDirectory(0);
   hframe__4->SetStats(0);
   hframe__4->SetLineStyle(0);
   hframe__4->SetMarkerStyle(20);
   hframe__4->GetXaxis()->SetTitle("m_{a} [GeV]");
   hframe__4->GetXaxis()->SetNdivisions(508);
   hframe__4->GetXaxis()->SetLabelFont(42);
   hframe__4->GetXaxis()->SetLabelOffset(0.007);
   hframe__4->GetXaxis()->SetTitleSize(0.05);
   hframe__4->GetXaxis()->SetTitleOffset(0.9);
   hframe__4->GetXaxis()->SetTitleFont(42);
   hframe__4->GetYaxis()->SetTitle("95% CL limits on #sigma(pp#rightarrow H#rightarrow Za#rightarrow 2l + 2#gamma)(fb)");
   hframe__4->GetYaxis()->CenterTitle(true);
   hframe__4->GetYaxis()->SetNdivisions(10);
   hframe__4->GetYaxis()->SetLabelFont(42);
   hframe__4->GetYaxis()->SetLabelOffset(0.007);
   hframe__4->GetYaxis()->SetTitleOffset(1.3);
   hframe__4->GetYaxis()->SetTitleFont(42);
   hframe__4->GetZaxis()->SetLabelFont(42);
   hframe__4->GetZaxis()->SetLabelOffset(0.007);
   hframe__4->GetZaxis()->SetLabelSize(0.05);
   hframe__4->GetZaxis()->SetTitleSize(0.06);
   hframe__4->GetZaxis()->SetTitleFont(42);
   hframe__4->Draw("sameaxis");
   
   TLegend *leg = new TLegend(0.15,0.6,0.39,0.68,NULL,"brNDC");
   leg->SetBorderSize(0);
   leg->SetTextSize(0.035);
   leg->SetLineColor(1);
   leg->SetLineStyle(1);
   leg->SetLineWidth(1);
   leg->SetFillColor(0);
   leg->SetFillStyle(0);
   TLegendEntry *entry=leg->AddEntry("Graph2","AsymptoticLimits CL_{s} expected","L");
   entry->SetLineColor(1);
   entry->SetLineStyle(2);
   entry->SetLineWidth(2);
   entry->SetMarkerColor(1);
   entry->SetMarkerStyle(21);
   entry->SetMarkerSize(1);
   entry->SetTextFont(42);
   entry=leg->AddEntry("Graph1","#pm 1 std. deviation","f");

   ci = TColor::GetColor("#00cc00");
   entry->SetFillColor(ci);
   entry->SetFillStyle(1001);

   ci = TColor::GetColor("#00cc00");
   entry->SetLineColor(ci);
   entry->SetLineStyle(1);
   entry->SetLineWidth(1);
   entry->SetMarkerColor(1);
   entry->SetMarkerStyle(21);
   entry->SetMarkerSize(1);
   entry->SetTextFont(42);
   entry=leg->AddEntry("Graph0","#pm 2 std. deviation","f");

   ci = TColor::GetColor("#ffcc00");
   entry->SetFillColor(ci);
   entry->SetFillStyle(1001);

   ci = TColor::GetColor("#ffcc00");
   entry->SetLineColor(ci);
   entry->SetLineStyle(1);
   entry->SetLineWidth(1);
   entry->SetMarkerColor(1);
   entry->SetMarkerStyle(21);
   entry->SetMarkerSize(1);
   entry->SetTextFont(42);
   leg->Draw();
      tex = new TLatex(0.7,0.5,"STAT only");
tex->SetNDC();
   tex->SetTextFont(42);
   tex->SetTextSize(0.045);
   tex->SetLineWidth(2);
   tex->Draw();
   c->Modified();
   c->cd();
   c->SetSelected(c);
}
