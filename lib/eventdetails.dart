import 'package:flutter/material.dart';
import '../Business Layer/Authentication.dart';
import '../events_model.dart'; // Your Events class

class EventDetailScreen extends StatelessWidget {
  final Events event;

  const EventDetailScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final user = Authentication().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(event.eventTitle),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Image Placeholder (you can add real images later)
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.event, size: 80, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(event.eventTitle, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Category: ${event.category}', style: const TextStyle(fontSize: 18)),
            Text('Location: ${event.location}', style: const TextStyle(fontSize: 18)),
            Text('Date: ${event.date.day}/${event.date.month}/${event.date.year}', style: const TextStyle(fontSize: 18)),
            Text('Price: EGP ${event.price}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green)),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  if (user == null) {
                    Navigator.pushNamed(context, '/login');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please login to register for this event')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Successfully registered for ${event.eventTitle}!')),
                    );
                    // Future: Save to Supabase here
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text('Register for Event', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}