import 'package:flutter/material.dart';
import 'package:manosuni/OnBoardingPage.dart';
import 'package:manosuni/dashboard.dart';
import 'package:manosuni/login.dart';
import 'package:manosuni/register.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ManosUni',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFF2780D)),
        useMaterial3: true,
      ),
      // Ruta inicial
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingPage(),
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/dashboard': (context) => const DashboardPage(),
        
      },
    );
  }
}
