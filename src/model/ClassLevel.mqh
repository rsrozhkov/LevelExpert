//+------------------------------------------------------------------+
//|                                                   ClassLevel.mqh |
//|                                                           Roaman |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Roaman"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

class ClassLevel{
   private:
      double m_highPrice;
      double m_lowPrice;
   
   public:
      ClassLevel(double highPrice,
               double lowPrice):
               m_highPrice(highPrice),
               m_lowPrice(lowPrice){}
      
      double getHigh(){
         return m_highPrice;
      }
      
      double getLow(){
         return m_lowPrice;
      }
      
      string toString(){
         return ("LEVEL: High="+(string)m_highPrice
                     +"  Low="+(string)m_lowPrice);
      }
};