
import 'package:flutter/material.dart';
import 'eventdetails.dart';
import 'events_controller.dart';
import '../Business Layer/Authentication.dart';
import 'wishlist subject.dart';
import 'wishlistScreen.dart'; // Correct import (capital S)

class EventsCatalogueScreen extends StatefulWidget {
  const EventsCatalogueScreen({super.key});

  @override
  State<EventsCatalogueScreen> createState() => _EventsCatalogueScreenState();
}

class _EventsCatalogueScreenState extends State<EventsCatalogueScreen> {
  late EventController controller;

  @override
  void initState() {
    super.initState();
    controller = EventController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Catalog & Search'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          // Wishlist icon with badge
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.favorite_border),
                if (WishlistSubject().wishlistEvents.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${WishlistSubject().wishlistEvents.length}',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WishlistScreen(allEvents: controller.events),
                ),
              );
            },
          ),
          // Profile icon
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              final user = Authentication().currentUser;
              if (user == null) {
                Navigator.pushNamed(context, '/login');
              } else {
                Navigator.pushNamed(context, '/profile');
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search field
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (text) {
                setState(() {
                  controller.searchingEvent(text);
                });
              },
              decoration: InputDecoration(
                labelText: 'Search by title or location...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          // Category filter
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonFormField<String>(
              value: controller.chosenCategory,
              decoration: InputDecoration(
                labelText: 'Filter by Category',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              items: controller.allCategories.map((String category) {
                return DropdownMenuItem<String>(value: category, child: Text(category));
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  controller.changeCategory(newValue!);
                });
              },
            ),
          ),
          const SizedBox(height: 12),
          // Event list
          Expanded(
            child: controller.filteredEvents.isEmpty
                ? const Center(child: Text('No events found', style: TextStyle(fontSize: 18, color: Colors.grey)))
                : ListView.builder(
              itemCount: controller.filteredEvents.length,
              itemBuilder: (context, index) {
                final event = controller.filteredEvents[index];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(event.eventTitle, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text('Category: ${event.category}'),
                        Text('Location: ${event.location}'),
                        Text('Date: ${event.date.day}/${event.date.month}/${event.date.year}'),
                        Text('Price: EGP ${event.price}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    // Wishlist heart button
                    trailing: IconButton(
                      icon: Icon(
                        WishlistSubject().isInWishlist(event) ? Icons.favorite : Icons.favorite_border,
                        color: WishlistSubject().isInWishlist(event) ? Colors.red : null,
                      ),
                      onPressed: () {
                        final subject = WishlistSubject();
                        if (subject.isInWishlist(event)) {
                          subject.removeEvent(event);
                        } else {
                          subject.addEvent(event);
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              subject.isInWishlist(event) ? 'Added to wishlist ❤️' : 'Removed from wishlist',
                            ),
                          ),
                        );
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EventDetailScreen(event: event)),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}