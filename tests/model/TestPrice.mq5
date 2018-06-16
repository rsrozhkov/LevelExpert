//+------------------------------------------------------------------+
//|                                                    TestPrice.mq5 |
//|                                                           Roaman |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Roaman"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include "..\..\src\model\ClassPrice.mqh"

void OnStart(){

   double bid = 1.558;
   double ask = 1.560;
   
   ClassPrice price(bid,ask);
   
   Print(price.toString());
      
}