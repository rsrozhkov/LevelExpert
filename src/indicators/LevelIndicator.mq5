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
#property indicator_plots   9

//--- indicator lines properties
#property indicator_type1   DRAW_LINE
#property indicator_color1  Yellow
#property indicator_label1  "Trend"
#property indicator_type2   DRAW_LINE
#property indicator_color2  Red
#property indicator_label2  "Strong Sell High"
#property indicator_type3   DRAW_LINE
#property indicator_color3  Red
#property indicator_label3  "Strong Sell Low"
#property indicator_type4   DRAW_LINE
#property indicator_color4  Red
#property indicator_label4  "Medium Sell High"
#property indicator_type5   DRAW_LINE
#property indicator_color5  Red
#property indicator_label5  "Medium Sell Low"
#property indicator_type6   DRAW_LINE
#property indicator_color6  Green
#property indicator_label6  "Medium Buy High"
#property indicator_type7   DRAW_LINE
#property indicator_color7  Green
#property indicator_label7  "Medium Buy Low"
#property indicator_type8   DRAW_LINE
#property indicator_color8  Green
#property indicator_label8  "Strong Buy High"
#property indicator_type9   DRAW_LINE
#property indicator_color9  Green
#property indicator_label9  "Strong Buy Low"

//--- includes


//--- input parameters
input int   totalParsingBars     =150; //Баров для обработки
input int   levelParsingBars     =5;   //Баров для определения уровня
input int   parsingZonesQuantity =10;  //На сколько зон делить тренд

//--- indicator buffers
double   trendBuffer[],                //0
         strongSellHighBuffer[],       //1
         strongSellLowBuffer[],        //2
         mediumSellHighBuffer[],       //3
         mediumSellLowBuffer[],        //4
         mediumBuyHighBuffer[],        //5
         mediumBuyLowBuffer[],         //6
         strongBuyHighBuffer[],        //7
         strongBuyLowBuffer[];         //8
         
//--- struct level
struct range {
   double high;
   double low;
};

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit(){

//--- indicator buffers mapping
   if (!SetIndexBuffer(0,trendBuffer,INDICATOR_DATA)) return(INIT_FAILED);
   if (!SetIndexBuffer(1,strongSellHighBuffer,INDICATOR_DATA)) return(INIT_FAILED);
   if (!SetIndexBuffer(2,strongSellLowBuffer,INDICATOR_DATA)) return(INIT_FAILED);
   if (!SetIndexBuffer(3,mediumSellHighBuffer,INDICATOR_DATA)) return(INIT_FAILED);
   if (!SetIndexBuffer(4,mediumSellLowBuffer,INDICATOR_DATA)) return(INIT_FAILED);
   if (!SetIndexBuffer(5,mediumBuyHighBuffer,INDICATOR_DATA)) return(INIT_FAILED);
   if (!SetIndexBuffer(6,mediumBuyLowBuffer,INDICATOR_DATA)) return(INIT_FAILED);
   if (!SetIndexBuffer(7,strongBuyHighBuffer,INDICATOR_DATA)) return(INIT_FAILED);
   if (!SetIndexBuffer(8,strongBuyLowBuffer,INDICATOR_DATA)) return(INIT_FAILED);
   
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
   PlotIndexSetDouble(8,PLOT_EMPTY_VALUE,0.0);

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
   if(rates_total<(totalParsingBars+levelParsingBars))
      return(0);// not enough bars for calculation
      
//--- first calculation or number of bars was changed
   if(prev_calculated==0) {
      ArrayInitialize(trendBuffer,0);
      ArrayInitialize(strongSellHighBuffer,0);
      ArrayInitialize(strongSellLowBuffer,0);
      ArrayInitialize(mediumSellHighBuffer,0);
      ArrayInitialize(mediumSellLowBuffer,0);
      ArrayInitialize(mediumBuyHighBuffer,0);
      ArrayInitialize(mediumBuyLowBuffer,0);
      ArrayInitialize(strongBuyHighBuffer,0);
      ArrayInitialize(strongBuyLowBuffer,0);      
      }
    
   int startIndex = rates_total-totalParsingBars;
   range bars[];
   ArrayResize(bars,totalParsingBars);
   for (int i = startIndex, j = 0; i< rates_total; i++ , j++) {
      bars[j].high=high[i];
      bars[j].low=low[i];
   }

   int maxBarIndex = findMaxBarIndex(bars);
   int minBarIndex = findMinBarIndex(bars);
   
//--- Main loop
   for(int i = startIndex; i < rates_total && !IsStopped();i++){
      trendBuffer[i] = getTrendValue(bars, maxBarIndex, minBarIndex, i-startIndex);
      
      strongSellHighBuffer[i] = findSSL(bars,maxBarIndex).high;
      strongSellLowBuffer[i] = findSSL(bars,maxBarIndex).low;
      
      strongBuyHighBuffer[i] = findSBL(bars,minBarIndex).high; 
      strongBuyLowBuffer[i] = findSBL(bars,minBarIndex).low;
   }
   
//--- return value of prev_calculated for next call
   return(rates_total);
}




int findMaxBarIndex(range &bars[]) {
   int barIndex = 0;
   double max = 0.0;
   for (int i = levelParsingBars; i< ArraySize(bars); i++){
      if (bars[i].high>max) {
      max = bars[i].high;
      barIndex = i;
      }
   }
   return barIndex;
}

int findMinBarIndex(range &bars[]) {
   int barIndex = 0;
   double min = bars[0].low;
   for (int i = levelParsingBars; i< ArraySize(bars); i++){
      if (bars[i].low<min) {
      min = bars[i].low;
      barIndex = i;
      }
   }
   return barIndex;
}

double getTrendValue(range &bars[], int highIndex, int lowIndex, int currentIndex) {
  
   if ((highIndex<lowIndex) && (currentIndex<lowIndex) && (currentIndex>highIndex)) {
      double l = (lowIndex-highIndex)*1.0;
      double h = bars[highIndex].high-bars[lowIndex].low;
      double lx = (lowIndex-currentIndex)*1.0;
      double bx = (lx*h)/l+bars[lowIndex].low;
      return bx;
   }
   
   if ((highIndex>lowIndex) && (currentIndex<lowIndex) && (currentIndex>highIndex)) {
      double l = (highIndex-lowIndex)*1.0;
      double h = bars[highIndex].high-bars[lowIndex].low;
      double lx = (currentIndex-lowIndex)*1.0;
      double bx = (lx*h)/l+bars[lowIndex].low;
      return bx;
   }
   return 0.0;
}

range findSSL(range &bars[], int highIndex){
   range bar;
   int leverage;
   double max = bars[highIndex].high;
   double min = bars[highIndex].low;
   
   if (levelParsingBars%2==0) leverage = levelParsingBars/2;
   else leverage = (levelParsingBars-1)/2;
   for (int i = 0; i< levelParsingBars; i++) {
      if (bars[highIndex-leverage+i].high>max) max = bars[highIndex-leverage+i].high;
      if (bars[highIndex-leverage+i].low>min) min = bars[highIndex-leverage+i].low;
   }
   bar.high = max;
   bar.low = min;
   return bar;
}

range findSBL(range &bars[], int lowIndex){
   range bar;
   int leverage;
   double max = bars[lowIndex].high;
   double min = bars[lowIndex].low;
   
   if (levelParsingBars%2==0) leverage = levelParsingBars/2;
   else leverage = (levelParsingBars-1)/2;
   for (int i = 0; i< levelParsingBars; i++) {
      if (bars[lowIndex-leverage+i].high<max) max = bars[lowIndex-leverage+i].high;
      if (bars[lowIndex-leverage+i].low<min) min = bars[lowIndex-leverage+i].low;
   }
   bar.high = max;
   bar.low = min;
   return bar;
}