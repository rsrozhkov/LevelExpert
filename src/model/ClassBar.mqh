//+------------------------------------------------------------------+
//|                                                     ClassBar.mqh |
//|                                                           Roaman |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Roaman"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

class ClassBar{
   private:
      double m_highPrice;
      double m_lowPrice;
   
   public:
      ClassBar(double highPrice,
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
         return ("BAR: High="+(string)m_highPrice
                   +"  Low="+(string)m_lowPrice);
      }
};