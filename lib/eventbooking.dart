import 'package:architecture_project/paymentstrategy.dart';

class EventBooking{
  PaymentStrategy? paymentStrategy; //object mn paymentstratetgy ? mean null safety
  void setPaymentMethod(PaymentStrategy payment){
    paymentStrategy = payment;
  }
  EventBooking();
  bool checkout(double totalAmount) {
    if (paymentStrategy == null) {
      print("Please select a payment method first");
      return false;
    }
    paymentStrategy!.pay(totalAmount);
    return true;
  }



}