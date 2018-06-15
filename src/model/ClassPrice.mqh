//+------------------------------------------------------------------+
//|                                                   ClassPrice.mqh |
//|                                                           Roaman |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Roaman"
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class ClassPrice{
   private:
      double m_ask;
      double m_bid;
   
   public:
      ClassPrice(double ask, double bid):
                  m_ask(ask), m_bid(bid){}
      
      double getAsk(){
         return m_ask;
      }
      
      double getBid(){
         return m_bid;
      }
      
      string toString(){
         return ("PRICE: Ask="+(string)m_ask
                      +" Bid="+(string)m_bid);
      }
};