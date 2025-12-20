import 'package:architecture_project/paymentstrategy.dart';
class CreditCardStrategy implements PaymentStrategy {
  final String cardNumber;
  CreditCardStrategy(this.cardNumber);
  @override
  void pay(double amount) {
    print("Paid EGP $amount using Credit Card ($cardNumber)");
  }
}