//+------------------------------------------------------------------+
//|                                               LevelIndicator.mq5 |
//|                                                    Roman Rozhkov |
//|                                                https://localhost |
//+------------------------------------------------------------------+
#property copyright "Roman Rozhkov"
#property link      "https://localhost"
#property version   "1.00"

//--- chart window properties
#property indicator_chart_window
#property indicator_buffers 9
#property indicator_plots   8

//--- indicator lines properties
#property indicator_type1   DRAW_LINE
#property indicator_color1  Red
#property indicator_label1  "Strong Sell High"
#property indicator_type2   DRAW_LINE
#property indicator_color2  Red
#property indicator_label2  "Strong Sell Low"
#property indicator_type3   DRAW_LINE
#property indicator_color3  Red
#property indicator_label3  "Medium Sell High"
#property indicator_type4   DRAW_LINE
#property indicator_color4  Red
#property indicator_label4  "Medium Sell Low"
#property indicator_type5   DRAW_LINE
#property indicator_color5  Green
#property indicator_label5  "Medium Buy High"
#property indicator_type6   DRAW_LINE
#property indicator_color6  Green
#property indicator_label6  "Medium Buy Low"
#property indicator_type7   DRAW_LINE
#property indicator_color7  Green
#property indicator_label7  "Strong Buy High"
#property indicator_type8   DRAW_LINE
#property indicator_color8  Green
#property indicator_label8  "Strong Buy Low"

//--- input parameters
input int   totalParsingBars     =150; //Баров для обработки
input int   levelParsingBars     =5;   //Баров для определения уровня
input int   parsingZonesQuantity =10;  //На сколько зон делить тренд

//--- indicator buffers
double   trendBuffer[];
double   strongSellHighBuffer[];
double   strongSellLowBuffer[];
double   mediumSellHighBuffer[];
double   mediumSellLowBuffer[];
double   mediumBuyHighBuffer[];
double   mediumBuyLowBuffer[];
double   strongBuyHighBuffer[];
double   strongBuyLowBuffer[];


//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit(){

//--- indicator buffers mapping
   if (!SetIndexBuffer(0,strongSellHighBuffer,INDICATOR_DATA)) return(INIT_FAILED);
   if (!SetIndexBuffer(1,strongSellLowBuffer,INDICATOR_DATA)) return(INIT_FAILED);
   if (!SetIndexBuffer(2,mediumSellHighBuffer,INDICATOR_DATA)) return(INIT_FAILED);
   if (!SetIndexBuffer(3,mediumSellLowBuffer,INDICATOR_DATA)) return(INIT_FAILED);
   if (!SetIndexBuffer(4,mediumBuyHighBuffer,INDICATOR_DATA)) return(INIT_FAILED);
   if (!SetIndexBuffer(5,mediumBuyLowBuffer,INDICATOR_DATA)) return(INIT_FAILED);
   if (!SetIndexBuffer(6,strongBuyHighBuffer,INDICATOR_DATA)) return(INIT_FAILED);
   if (!SetIndexBuffer(7,strongBuyLowBuffer,INDICATOR_DATA)) return(INIT_FAILED);
   if (!SetIndexBuffer(8,trendBuffer,INDICATOR_CALCULATIONS)) return(INIT_FAILED);
   
//--- set accuracy
   //IndicatorSetInteger(INDICATOR_DIGITS,_Digits+1);

//--- name for DataWindow
   IndicatorSetString(INDICATOR_SHORTNAME,"LevelIndicator");

//---- sets drawing line empty value--
   PlotIndexSetDouble(0,PLOT_EMPTY_VALUE,0.0);
   PlotIndexSetDouble(1,PLOT_EMPTY_VALUE,0.0);
   PlotIndexSetDouble(2,PLOT_EMPTY_VALUE,0.0);
   PlotIndexSetDouble(3,PLOT_EMPTY_VALUE,0.0);
   PlotIndexSetDouble(4,PLOT_EMPTY_VALUE,0.0);
   PlotIndexSetDouble(5,PLOT_EMPTY_VALUE,0.0);
   PlotIndexSetDouble(6,PLOT_EMPTY_VALUE,0.0);
   PlotIndexSetDouble(7,PLOT_EMPTY_VALUE,0.0);

//---- initialization done
   return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[]){

//--- check for bars count
   if(rates_total<totalParsingBars)
      return(0);// not enough bars for calculation
      
//--- first calculation or number of bars was changed
   if(prev_calculated==0) {
      ArrayInitialize(strongSellHighBuffer,0);
      ArrayInitialize(strongSellLowBuffer,0);
      ArrayInitialize(mediumSellHighBuffer,0);
      ArrayInitialize(mediumSellLowBuffer,0);
      ArrayInitialize(mediumBuyHighBuffer,0);
      ArrayInitialize(mediumBuyLowBuffer,0);
      ArrayInitialize(strongBuyHighBuffer,0);
      ArrayInitialize(strongBuyLowBuffer,0);
      ArrayInitialize(trendBuffer,0);
      }
    
    double max=0;
    double min=low[rates_total-1];
    for (int i=(rates_total-totalParsingBars); i<rates_total; i++){
      if(high[i]>max) max = high[i];
      if(low[i]<min) min = low[i];
      }
    
    for(int i=(rates_total-totalParsingBars);i<rates_total && !IsStopped();i++){
      strongSellHighBuffer[i]=max;
      strongSellLowBuffer[i]=min;
      
      }
   
//--- return value of prev_calculated for next call
   return(rates_total);
}
