import 'package:architecture_project/paymentstrategy.dart';
import 'package:architecture_project/paypalStrat.dart';
import 'package:flutter/material.dart';

import 'creditCardStratetgy.dart';
import 'eventbooking.dart';
import 'events_model.dart';

class TicketBookingScreen extends StatefulWidget {
  final Events event;
  const TicketBookingScreen({super.key, required this.event});

  @override
  State<TicketBookingScreen> createState() => _TicketBookingScreenState();
}

class _TicketBookingScreenState extends State<TicketBookingScreen> {
  int tickets = 1;
  EventBooking booking = EventBooking(); // Context
  PaymentStrategy? selectedStrategy;
  String selectedMethodName = '';
  String message = '';

  @override
  Widget build(BuildContext context) {
    double total = tickets * widget.event.price;

    return Scaffold(
      appBar: AppBar(title: Text('Book ${widget.event.eventTitle}')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Available Seats: ${widget.event.numberofSeats}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Tickets: '),
                IconButton(onPressed: tickets > 1 ? () => setState(() => tickets--) : null, icon: Icon(Icons.remove)),
                Text('$tickets', style: TextStyle(fontSize: 30)),
                IconButton(onPressed: tickets < widget.event.numberofSeats ? () => setState(() => tickets++) : null, icon: Icon(Icons.add)),
              ],
            ),
            SizedBox(height: 20),
            Text('Total: EGP ${total.toStringAsFixed(2)}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 40),

            // 2 Buttons for payment methods
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedStrategy = CreditCardStrategy("1234-5678-9101");
                      selectedMethodName = 'Credit Card';
                      booking.setPaymentMethod(selectedStrategy!);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedMethodName == 'Credit Card' ? Colors.blue : Colors.grey,
                  ),
                  child: Text('Credit Card'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedStrategy = PaypalStrategy('mazen@gmail.com');
                      selectedMethodName = 'PayPal';
                      booking.setPaymentMethod(selectedStrategy!);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedMethodName == 'PayPal' ? Colors.blue : Colors.grey,
                  ),
                  child: Text('PayPal'),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (selectedMethodName.isNotEmpty)
              Text('Selected: $selectedMethodName', style: TextStyle(fontSize: 16, color: Colors.blue)),

            SizedBox(height: 40),
            ElevatedButton(
              onPressed: selectedStrategy == null ? null : confirm,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: Size(double.infinity, 50)),
              child: Text('Confirm Payment', style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 20),
            Text(message, style: TextStyle(fontSize: 18, color: message.contains('success') ? Colors.green : Colors.red)),
          ],
        ),
      ),
    );
  }

  void confirm() {
    if (tickets > widget.event.numberofSeats) {
      setState(() => message = 'Not enough seats');
      return;
    }

    final success = booking.checkout(tickets * widget.event.price);

    if (success) {
      widget.event.numberofSeats -= tickets;
      setState(() => message = 'Payment successful! $tickets tickets booked using $selectedMethodName');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking confirmed!')),
      );
    } else {
      setState(() => message = 'Please select a payment method');
    }
  }
}