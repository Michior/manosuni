import 'package:flutter/material.dart';
import 'package:manosuni/OnBoardingPage.dart';
import 'package:manosuni/dashboard.dart';
import 'package:manosuni/explorer.dart';
import 'package:manosuni/login.dart';
import 'package:manosuni/my_activities.dart';
import 'package:manosuni/profile.dart';
import 'package:manosuni/register.dart';
import 'package:manosuni/theme/settings.dart';
import 'package:manosuni/notificaciones_estudiantes.dart';
import 'package:manosuni/calendario_personal.dart';
import 'package:manosuni/logros.dart';
import 'package:manosuni/certificados.dart';
import 'package:manosuni/dashboard_ong.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

// Controlador global del tema
ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, currentMode, __) {
        return MaterialApp(
          title: 'ManosUni',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: currentMode,
          initialRoute: '/dashboard-ong', // pantalla inicial
          routes: {
            '/': (context) => const OnboardingPage(),
            '/login': (context) => const Login(),
            '/register': (context) => const Register(),
            '/dashboard': (context) => const DashboardPage(),
            '/explorer': (context) => const Explorer(),
            '/activities': (context) => const MisActividades(),
            '/profile': (context) => const PerfilPage(),
            '/settings': (context) => const SettingsPage(),
            '/notificaciones': (context) => const NotificationsStudentScreen(), 
            '/calendario': (context) => const CalendarPersonalScreen(),
            '/logros': (context) => const LogrosScreen(),
            '/certificados': (context) => const CertificadosScreen(),
            '/dashboard-ong': (context) => const DashboardOngScreen(),
          },
        );
      },
    );
  }
}
