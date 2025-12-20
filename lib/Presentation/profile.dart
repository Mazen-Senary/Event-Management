import 'package:flutter/material.dart';
import '../Business Layer/Authentication.dart';

class ProfileScreen extends StatelessWidget {
  final Authentication _authService = Authentication();

  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = _authService.currentUser;

    if (user == null) {
      return Scaffold(
        body: Center(
          child: Text('Not logged in'),
        ),
      );
    }

    // Use email directly — always available, no loading needed
    final email = user.email ?? 'No email';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.blue,
                child: Text(
                  email[0].toUpperCase(),
                  style: const TextStyle(fontSize: 50, color: Colors.white),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Logged in as',
                style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              ),
              const SizedBox(height: 10),
              Text(
                email,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
                  await _authService.logout();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Logout', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}