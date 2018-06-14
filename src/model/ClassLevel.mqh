//+------------------------------------------------------------------+
//|                                                   ClassLevel.mqh |
//|                                                    Roman Rozhkov |
//|                                                https://localhost |
//+------------------------------------------------------------------+
#property copyright "Roman Rozhkov"
#property link      "https://localhost"
#property version   "1.00"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

#include "ENUMS.mqh"

class ClassLevel {
   private:
      EnumLevelType m_levelType;
      EnumTradeType m_tradeType;
      double m_highPrice;
      double m_lowPrice;
      double m_size;
      bool m_tradable;
   
   public:
      ClassLevel(EnumLevelType levelType,
                        EnumTradeType tradeType,
                        double highPrice,
                        double lowPrice,
                        bool tradable):
                           m_levelType(levelType),
                           m_tradeType(tradeType),
                           m_highPrice(highPrice),
                           m_lowPrice(lowPrice),
                           m_tradable(tradable){
                           
         m_size = MathAbs(m_highPrice-m_lowPrice);
      }
      
      void setTradeState(bool tradable){
         m_tradable=tradable;
      }
      
      EnumLevelType getLevelType(){
         return m_levelType;
      }
      
      EnumTradeType getTradeType(){
         return m_tradeType;
      }
      
      double getHighPrice(){
         return m_highPrice;
      }
      
      double getLowPrice(){
         return m_lowPrice;
      }
      
      double getSize(){
         return m_size;
      }
      
      bool getTradeState(){
         return m_tradable;
      }
      
      string toString() {
         return ("ClassLevel:   levelType:"+EnumToString(m_levelType)
                                 +";   tradeType:"+EnumToString(m_tradeType)
                                 +";   highPrice:"+(string)m_highPrice
                                 +";   lowPrice:"+(string)m_lowPrice
                                 +";   size:"+(string)m_size
                                 +";   tradable:"+(string)m_tradable);
      }
};