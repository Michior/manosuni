import 'package:flutter/material.dart';
import 'ngo_history_screen.dart';
import 'ngo_help_screen.dart';

class NgoSettingsScreen extends StatelessWidget {
  const NgoSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> opciones = [
      {'icon': Icons.person, 'titulo': 'Actualizar Datos de la ONG'},
      {'icon': Icons.lock, 'titulo': 'Cambiar Contraseña'},
      {'icon': Icons.notifications, 'titulo': 'Notificaciones'},
      {'icon': Icons.security, 'titulo': 'Seguridad'},
      {'icon': Icons.info, 'titulo': 'Acerca de ManosUni'},
      {'icon': Icons.history, 'titulo': 'Historial de Actividades'},
      {'icon': Icons.help, 'titulo': 'Ayuda y Soporte'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuración ONG"),
        backgroundColor: const Color(0xFFF1780F),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: opciones.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final opcion = opciones[index];
          return ListTile(
            leading: Icon(opcion['icon'], color: const Color(0xFFF1780F)),
            title: Text(opcion['titulo']),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              if (opcion['titulo'] == 'Historial de Actividades') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NgoHistoryScreen()),
                );
              } else if (opcion['titulo'] == 'Ayuda y Soporte') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const NgoHelpScreen()),
                );
              }
            },
          );
        },
      ),
    );
  }
}
