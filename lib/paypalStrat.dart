import 'package:architecture_project/paymentstrategy.dart';

class PaypalStrategy implements PaymentStrategy{
  final String email;

  PaypalStrategy(this.email);

  @override
  void pay(double amount) {
    print("EGP $amount paid  using PayPal ($email)");
  }
}