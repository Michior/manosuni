import 'package:flutter/material.dart';

import 'package:manosuni/screens/auth/OnBoardingPage.dart';
import 'package:manosuni/screens/auth/login.dart';
import 'package:manosuni/screens/auth/register.dart';
import 'package:manosuni/screens/students/dashboard/dashboard.dart';
import 'package:manosuni/screens/students/explorer/explorer.dart';
import 'package:manosuni/screens/students/activities/my_activities.dart';
import 'package:manosuni/screens/students/profile/profile.dart';
import 'package:manosuni/core/theme/settings.dart';
import 'package:manosuni/screens/students/notifications/notificaciones_estudiantes.dart';
import 'package:manosuni/screens/students/activities/calendario_personal.dart';
import 'package:manosuni/screens/students/profile/logros.dart';
import 'package:manosuni/screens/students/profile/certificados.dart';
import 'package:manosuni/screens/ngo/dashboard/dashboard_ong.dart';
import 'package:manosuni/screens/ngo/activities/publicar_actividad.dart';
import 'package:manosuni/screens/ngo/activities/gestion_actividades.dart';
import 'package:manosuni/screens/ngo/volunteers/gestion_voluntarios.dart';
import '../screens/ngo/qr/generate_qr_screen.dart';
import '../screens/ngo/profile/ngo_profile_screen.dart';
import '../screens/ngo/notifications/notificaciones_screen.dart';
import '../screens/ngo/reports/impact_reports_screen.dart';
import '../screens/ngo/validations/ngo_validation_screen.dart';
import '../screens/ngo/history/ngo_history_screen.dart';
import '../screens/ngo/settings/ngo_settings_screen.dart';
import '../screens/ngo/help/ngo_help_screen.dart';

class AppRouter {
  static const String initialRoute = '/';

  static final Map<String, WidgetBuilder> routes = {
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
    '/publicar-actividad': (context) => const PublicarActividadScreen(),
    '/gestion-actividades': (context) => const GestionActividadesScreen(),
    '/gestion-voluntarios': (context) => const GestionVoluntariosScreen(),
    '/profile-ong': (context) => const NgoProfileScreen(),
    '/screens-menu': (context) => const ScreensMenu(),
  };
}

class ScreensMenu extends StatelessWidget {
  const ScreensMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_ScreenItem> screens = [
      _ScreenItem("Pantalla 17: Generar QR", const GenerateQrScreen()),
      _ScreenItem("Pantalla 18: Perfil ONG", const NgoProfileScreen()),
      _ScreenItem(
        "Pantalla 19: Notificaciones ONG",
        const NotificacionesScreen(),
      ),
      _ScreenItem(
        "Pantalla 20: Reportes Impacto ONG",
        const ImpactReportsScreen(),
      ),
      _ScreenItem(
        "Pantalla 21: Validación Horas Sociales",
        const NgoValidationScreen(),
      ),
      _ScreenItem(
        "Pantalla 22: Historial Actividades ONG",
        const NgoHistoryScreen(),
      ),
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
