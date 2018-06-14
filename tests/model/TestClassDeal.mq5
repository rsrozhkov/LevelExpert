//+------------------------------------------------------------------+
//|                                                     TestDeal.mq5 |
//|                                                           Roaman |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Roaman"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include "..\..\src\model\ClassDeal.mqh"
#include "..\..\src\InputParams.mqh"

void OnStart(){

   ulong ticket = 7788784;
   double volume = 1;
   double openPrice = 0.5;
   double stopLoss = 0.4444;
   double takeProfit = 1.4;

   ClassDeal deal(BUY,ticket,volume,openPrice,stopLoss,takeProfit);
   
   deal.setStopLoss(-3);
   deal.setTakeProfit(takeProfit);
   printf(deal.toString());
   Print("DONE!\n\n");
   
}