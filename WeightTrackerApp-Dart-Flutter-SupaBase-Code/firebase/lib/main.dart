import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase/pages/account_page.dart';
import 'package:firebase/pages/login_page.dart';
import 'package:firebase/pages/splash_page.dart';
import 'package:firebase/pages/home.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://cwjimeenrjsouqhgkgny.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN3amltZWVucmpzb3VxaGdrZ255Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDA5ODAxODksImV4cCI6MjAxNjU1NjE4OX0.2Z_heAUG1ZemLn4fimQFBIdgZ9xHcj8SPm6oS_8SIig',
    authFlowType: AuthFlowType.pkce,
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFfe5d26)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/account': (context) => AccountPage(
              onUpdateProfile: (String fullName, double weight, double height,
                  String date) {},
            ),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
