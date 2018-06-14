//+------------------------------------------------------------------+
//|                                             TestClassLevel.mq5 |
//|                                                           Roaman |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Roaman"
#property link      "https://www.mql5.com"
#property version   "1.00"

#include "..\..\src\model\ClassLevel.mqh"
#include "..\..\src\model\ENUMS.mqh"

void OnStart(){

   EnumLevelType levelType = FLAT;
   EnumTradeType tradeType = BUY;
   double highPrice = 1.0000;
   double lowPrice = 0.55490;

   ClassLevel level(levelType,tradeType,highPrice,lowPrice,true);
   
   printf(level.toString());
   Print("DONE!\n\n");
}