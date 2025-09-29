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
import 'package:manosuni/publicar_actividad.dart';
import 'package:manosuni/gestion_actividades.dart';
import 'package:manosuni/gestion_voluntarios.dart';
import 'theme/app_theme.dart';

// Importa todas tus pantallas aquí
import 'generate_qr_screen.dart';
import 'ngo_profile_screen.dart';
import 'notificaciones_screen.dart';
import 'impact_reports_screen.dart';
import 'ngo_validation_screen.dart';
import 'ngo_history_screen.dart';
import 'ngo_settings_screen.dart';
import 'ngo_help_screen.dart';

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
          debugShowCheckedModeBanner: false,
          title: 'ManosUni',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: currentMode,
          initialRoute: '/', // pantalla inicial
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

            //NGO
            '/dashboard-ong': (context) => const DashboardOngScreen(),
            '/publicar-actividad': (context) => const PublicarActividadScreen(),
            '/gestion-actividades': (context) => const GestionActividadesScreen(),
            '/gestion-voluntarios': (context) => const GestionVoluntariosScreen(),
            '/profile-ong': (context) => const NgoProfileScreen(),
            '/screens-menu': (context) => const ScreensMenu(), // 👈 agregado para pruebas
          },
        );
      },
    );
  }
}

class ScreensMenu extends StatelessWidget {
  const ScreensMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_ScreenItem> screens = [
      _ScreenItem("Pantalla 17: Generar QR", const GenerateQrScreen()),
      _ScreenItem("Pantalla 18: Perfil ONG", const NgoProfileScreen()),
      _ScreenItem("Pantalla 19: Notificaciones ONG", const NotificacionesScreen()),
      _ScreenItem("Pantalla 20: Reportes Impacto ONG", const ImpactReportsScreen()),
      _ScreenItem("Pantalla 21: Validación Horas Sociales", const NgoValidationScreen()),
      _ScreenItem("Pantalla 22: Historial Actividades ONG", const NgoHistoryScreen()),
      _ScreenItem("Pantalla 23: Configuración ONG", const NgoSettingsScreen()),
      _ScreenItem("Pantalla 24: Ayuda y Soporte ONG", const NgoHelpScreen()),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Menú de Pruebas ManosUni"),
        backgroundColor: const Color(0xFFF1780F),
      ),
      body: ListView.builder(
        itemCount: screens.length,
        itemBuilder: (context, index) {
          final screen = screens[index];
          return ListTile(
            title: Text(screen.title),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => screen.widget),
              );
            },
          );
        },
      ),
    );
  }
}

class _ScreenItem {
  final String title;
  final Widget widget;

  _ScreenItem(this.title, this.widget);
}
