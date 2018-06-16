//+------------------------------------------------------------------+
//|                                                    ClassDeal.mqh |
//|                                                    Roman Rozhkov |
//|                                                https://localhost |
//+------------------------------------------------------------------+
#property copyright "Roman Rozhkov"
#property link      "https://localhost"
#property version   "1.00"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

#include "Enums.mqh"

class ClassDeal {
   private:
      ulong m_ticket;
      EnumTradeType m_tradeType;
      double m_volume;
      double m_openPrice;
      double m_stopLoss;
      double m_takeProfit;
   
   public:
      ClassDeal(ulong ticket,
         EnumTradeType tradeType,
         double volume,
         double openPrice,
         double stopLoss,
         double takeProfit):
            m_tradeType(tradeType),
            m_ticket(ticket),
            m_volume(volume),
            m_openPrice(openPrice),
            m_stopLoss(stopLoss),
            m_takeProfit(takeProfit){}

      ClassDeal(ulong ticket,
         EnumTradeType tradeType,
         double volume,
         double openPrice):
            m_tradeType(tradeType),
            m_ticket(ticket),
            m_volume(volume),
            m_openPrice(openPrice),
            m_stopLoss(0),
            m_takeProfit(0){}
      
      void setStopLoss(double stopLoss){
         m_stopLoss = stopLoss;
      }
      
      void setTakeProfit(double takeProfit){
         m_takeProfit = takeProfit;
      }
      
      EnumTradeType getTradeType(){
         return m_tradeType;
      }
      
      ulong getTicket(){
         return m_ticket;
      }
      
      double getVolume(){
         return m_volume;
      }
      
      double getOpenPrice(){
         return m_openPrice;
      }
      
      double getStopLoss(){
         return m_stopLoss;
      }
      
      double getTakeProfit(){
         return m_takeProfit;
      }
      
      string toString() {
         return ("DEAL:   tradeType:"+EnumToString(m_tradeType)
                         +";   ticket:"+(string)m_ticket
                         +";   volume:"+(string)m_volume
                         +";   openPrice:"+(string)m_openPrice
                         +";   stopLoss:"+(string)m_stopLoss
                         +";   takeProfit:"+(string)m_takeProfit);
      }
};