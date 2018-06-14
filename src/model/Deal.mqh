//+------------------------------------------------------------------+
//|                                                         Deal.mqh |
//|                                                    Roman Rozhkov |
//|                                                https://localhost |
//+------------------------------------------------------------------+
#property copyright "Roman Rozhkov"
#property link      "https://localhost"
#property version   "1.00"
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Deal {
   private:
      ulong self_ticket;
      double self_volume;
      double self_openPrice;
      double self_stopLoss;
      double self_takeProfit;
   
   public:
      Deal(ulong ticket,
         double volume,
         double openPrice,
         double stopLoss,
         double takeProfit):
            self_ticket(ticket),
            self_volume(volume),
            self_openPrice(openPrice),
            self_stopLoss(stopLoss),
            self_takeProfit(takeProfit){}

      Deal(ulong ticket,
         double volume,
         double openPrice):
            self_ticket(ticket),
            self_volume(volume),
            self_openPrice(openPrice),
            self_stopLoss(0),
            self_takeProfit(0){}

  
      ulong getTicket(){
         return self_ticket;
      }
      
      double getVolume(){
         return self_volume;
      }
      
      double getOpenPrice(){
         return self_openPrice;
      }
      
      double getStopLoss(){
         return self_stopLoss;
      }
      
      double getTakeProfit(){
         return self_takeProfit;
      }
      
      void toString() {
         
         printf("ORDER:\n   ticket: %d\n   volume: %f\n   openPrice: %f\n   stopLoss: %f\n   takeProfit: %f\n",
                                    self_ticket,   self_volume,   self_openPrice,   self_stopLoss, self_takeProfit);
      }
};