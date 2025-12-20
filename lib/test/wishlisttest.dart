// // import 'package:architecture_project/observer.dart';
// // import 'package:flutter/material.dart';
// //
// // import 'events_model.dart';
// // import 'wishlist subject.dart';
// //
// // class Wishlistscreen extends StatefulWidget {
// //   final List<Events> allEvents;
// //   const Wishlistscreen({super.key, required this.allEvents});
// //
// //   @override
// //   State<Wishlistscreen> createState() => _WishlistscreenState();
// // }
// //
// // class _WishlistscreenState extends State<Wishlistscreen> implements Observer {
// //   final WishlistSubject subject = WishlistSubject();
// //   @override
// //   void initState() {
// //     super.initState();
// //     subject.addObservers(this);  // Subscribe \
// //   }
// //   @override
// //   void dispose() {
// //     subject.removeObserver(this);  // Unsubscribe
// //     super.dispose();
// //   }
// //   @override
// //   void update() {
// //     setState(() {});
// //   }
// //   @override
// //   Widget build(BuildContext context) {
// //     final wishlist = subject.wishlistEvents;
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('My Wishlist (${wishlist.length})'),
// //         backgroundColor: Colors.blue,
// //         foregroundColor: Colors.white,
// //       ),
// //       body: wishlist.isEmpty
// //           ? Center(
// //         child: Text(
// //           'Your wishlist is empty',
// //           style: TextStyle(fontSize: 18, color: Colors.grey),
// //         ),
// //       )
// //           : ListView.builder(
// //         itemCount: wishlist.length,
// //         itemBuilder: (context, index) {
// //           final event = wishlist[index];
// //           return Card(
// //             margin: EdgeInsets.all(10),
// //             child: ListTile(
// //               title: Text(event.eventTitle, style: TextStyle(fontWeight: FontWeight.bold)),
// //               subtitle: Text('EGP ${event.price} • ${event.location}'),
// //               trailing: IconButton(
// //                 icon: Icon(Icons.delete, color: Colors.red),
// //                 onPressed: () {
// //                   subject.removeEvent(event);  // Remove and notify
// //                 },
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //
// //   }
// //
// //
// //
// // }
//
//
//
// import 'package:flutter/material.dart';
// import '../events_model.dart';
// import '../observer.dart';
// import 'wishlist subject.dart';
//
// class Wishlistscreen extends StatefulWidget {
//   final List<Events> allEvents;
//
//   const Wishlistscreen({super.key, required this.allEvents});
//
//   @override
//   State<Wishlistscreen> createState() => _WishlistscreenState();
// }
//
// class _WishlistscreenState extends State<Wishlistscreen> implements Observer {
//   final WishlistSubject subject = WishlistSubject();  // ← Singleton, same instance
//
//   @override
//   void initState() {
//     super.initState();
//     subject.addObservers(this);
//   }
//
//   @override
//   void dispose() {
//     subject.removeObserver(this);
//     super.dispose();
//   }
//
//   @override
//   void update() {
//     setState(() {});  // Refresh when notified
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final wishlist = subject.wishlistEvents;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My Wishlist (${wishlist.length})'),
//         backgroundColor: Colors.blue,
//         foregroundColor: Colors.white,
//       ),
//       body: wishlist.isEmpty
//           ? Center(
//         child: Text(
//           'Your wishlist is empty',
//           style: TextStyle(fontSize: 18, color: Colors.grey),
//         ),
//       )
//           : ListView.builder(
//         itemCount: wishlist.length,
//         itemBuilder: (context, index) {
//           final event = wishlist[index];
//           return Card(
//             margin: EdgeInsets.all(10),
//             child: ListTile(
//               title: Text(event.eventTitle, style: TextStyle(fontWeight: FontWeight.bold)),
//               subtitle: Text('EGP ${event.price} • ${event.location}'),
//               trailing: IconButton(
//                 icon: Icon(Icons.delete, color: Colors.red),
//                 onPressed: () {
//                   subject.removeEvent(event);
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

