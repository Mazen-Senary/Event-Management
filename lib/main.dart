import 'package:architecture_project/Presentation/Reg.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'Presentation/log.dart';
import 'Presentation/profile.dart';
import 'events_view.dart';  // Your EventsCatalogueScreen file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://sxusfniebqweccozphqr.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InN4dXNmbmllYnF3ZWNjb3pwaHFyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjYwNzYxMjgsImV4cCI6MjA4MTY1MjEyOH0.L5UI9P7-TRZ4DwwqSG8qfZlp3lQsrqG7o4HI-HjcAkI',     // Paste the public anon key
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',   // ← App starts directly on Login screen
      routes: {
        '/login': (context) =>  LoginScreen(),
        '/register': (context) =>  RegistrationScreen(),
        '/profile': (context) => ProfileScreen(),
        '/catalog': (context) => EventsCatalogueScreen(),
      },
    );
  }
}