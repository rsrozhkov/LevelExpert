//+------------------------------------------------------------------+
//|                                                  LevelExpert.mq5 |
//|                                                    Roman Rozhkov |
//|                                                https://localhost |
//+------------------------------------------------------------------+
<<<<<<< HEAD

#include "InputParams.mqh"
#include "model\\Deal.mqh"

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   Deal deal_1(77777,0.01,1.223);
   Deal deal_2(8888,0.02,1.335,1.2,1.5);
   deal_1.toString();
   deal_2.toString();
   Print("INIT DONE!");
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
   Print("DEINIT DONE!");
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+
=======
#property copyright "Roman Rozhkov"
#property link      "https://localhost"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Include                                                          |
//+------------------------------------------------------------------+
#include "UserInputParams.mqh"
#include "classes\ClassExpert.mqh"

//+------------------------------------------------------------------+
//| Inputs                                                           |
//+------------------------------------------------------------------+

//--- inputs for expert
string                   expertTitle            ="LevelExpert";// Name of expert
ulong                    expertMagicNumber      =1986;         // Magic number of expert
bool                     expertEveryTick        =true;        // Expert data processing "every tick"(true) or "every bar"(false)

//+------------------------------------------------------------------+
//| Global expert object                                             |
//+------------------------------------------------------------------+
ClassExpert levelExpert;

//+------------------------------------------------------------------+
//| Initialization function of the expert                            |
//+------------------------------------------------------------------+
int OnInit(){
   
   //--- Initializing expert
   if(!levelExpert.Init(Symbol(),Period(),expertEveryTick,expertMagicNumber))
     {
      //--- failed
      printf(__FUNCTION__+": error initializing expert");
      levelExpert.Deinit();
      return(INIT_FAILED);
     }
   
   return(INIT_SUCCEEDED);
   
}

//+------------------------------------------------------------------+
//| Deinitialization function of the expert                          |
//+------------------------------------------------------------------+
void OnDeinit(const int reason){
   levelExpert.Deinit();
}

//+------------------------------------------------------------------+
//| "Tick" event handler function                                    |
//+------------------------------------------------------------------+
void OnTick(){
   levelExpert.OnTick();
}

//+------------------------------------------------------------------+
//| "Trade" event handler function                                   |
//+------------------------------------------------------------------+
void OnTrade(){
   levelExpert.OnTrade();
}

//+------------------------------------------------------------------+
//| "Timer" event handler function                                   |
//+------------------------------------------------------------------+
void OnTimer(){
   levelExpert.OnTimer();
}
>>>>>>> 533542e9dc44db28c84ccc45e85f74bc53d98a44
