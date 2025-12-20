// import 'package:flutter/material.dart';
//
// import 'events_controller.dart';
//
// class EventsCatalogueScreen extends StatefulWidget {
//   const EventsCatalogueScreen({super.key});
//
//   @override
//   State<EventsCatalogueScreen> createState() => _EventsCatalogueScreenState();
// }
//
// class _EventsCatalogueScreenState extends State<EventsCatalogueScreen> {
//   late EventController controller;
//   @override
//   void initState() {
//     super.initState();
//     controller = EventController();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Event Catalog & Search'),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(12),
//             child: TextField(
//               onChanged: (text) {
//                 setState(() {
//                   controller.searchingEvent(text);  // Send text to controller
//                 });
//               },
//               decoration: InputDecoration(
//                 labelText: 'Search by title or location...',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//                 filled: true,
//                 fillColor: Colors.grey[100],
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 12),
//             child: DropdownButtonFormField<String>(
//               value: controller.chosenCategory,
//               decoration: InputDecoration(
//                 labelText: 'Filter by Category',
//                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//               ),
//               items: controller.allCategories.map((String category) {
//                 return DropdownMenuItem<String>(value: category, child: Text(category));
//               }).toList(),
//               onChanged: (String? newValue) {
//                 setState(() {
//                   controller.changeCategory(newValue!);
//                 });
//               },
//             ),
//           ),
//           SizedBox(height: 12),
//           // EVENT LIST
//           Expanded(
//             child: controller.filteredEvents.isEmpty
//                 ? Center(child: Text('No events found', style: TextStyle(fontSize: 18, color: Colors.grey)))
//                 : ListView.builder(
//               itemCount: controller.filteredEvents.length,
//               itemBuilder: (context, index) {
//                 final event = controller.filteredEvents[index];
//                 return Card(
//                   margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                   child: ListTile(
//                     contentPadding: EdgeInsets.all(16),
//                     title: Text(event.eventTitle, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(height: 8),
//                         Text('Category: ${event.category}'),
//                         Text('Location: ${event.location}'),
//                         Text('Date: ${event.date.day}/${event.date.month}/${event.date.year}'),
//                         Text('Price: EGP ${event.price}', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
//                       ],
//                     ),
//                     trailing: Icon(Icons.arrow_forward_ios),
//                     onTap: () {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(content: Text('Selected: ${event.eventTitle}')),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'eventdetails.dart';
import 'events_controller.dart';
import '../Business Layer/Authentication.dart'; // <-- ADD THIS IMPORT

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
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventDetailScreen(event: event),
                        ),
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