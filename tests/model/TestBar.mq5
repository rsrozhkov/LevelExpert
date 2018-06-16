//+------------------------------------------------------------------+
//|                                                      TestBar.mq5 |
//|                                                           Roaman |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Roaman"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include "..\..\src\model\ClassPrice.mqh"
#include "..\..\src\model\ClassBar.mqh"

void OnStart(){

   ClassPrice high(1.88,1.91);
   ClassPrice low(1.75,1.78);
   
   ClassBar bar(high.getAsk(),low.getBid());
   
   Print(bar.toString());
      
}