import 'package:flutter/material.dart';
import '../events_model.dart';
import '../observer.dart';
import 'wishlist subject.dart';

class WishlistScreen extends StatefulWidget {
  final List<Events> allEvents;

  const WishlistScreen({super.key, required this.allEvents});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> implements Observer {
  final WishlistSubject subject = WishlistSubject();

  @override
  void initState() {
    super.initState();
    subject.addObservers(this);  // Subscribe
  }

  @override
  void dispose() {
    subject.removeObserver(this);  // Unsubscribe
    super.dispose();
  }

  @override
  void update() {
    setState(() {});  // Refresh when wishlist changes
  }

  @override
  Widget build(BuildContext context) {
    final wishlist = subject.wishlistEvents;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Wishlist (${wishlist.length})'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: wishlist.isEmpty
          ? Center(
        child: Text(
          'Your wishlist is empty',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: wishlist.length,
        itemBuilder: (context, index) {
          final event = wishlist[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(event.eventTitle, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('EGP ${event.price} • ${event.location}'),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  subject.removeEvent(event);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}