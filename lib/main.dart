import 'package:flutter/material.dart';

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
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ScreensMenu(),
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
