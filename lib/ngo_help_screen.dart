import 'package:flutter/material.dart';

class NgoHelpScreen extends StatelessWidget {
  const NgoHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> secciones = [
      {'icon': Icons.help_outline, 'titulo': 'Preguntas Frecuentes'},
      {'icon': Icons.video_library, 'titulo': 'Tutoriales'},
      {'icon': Icons.contact_mail, 'titulo': 'Contacto'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ayuda y Soporte"),
        backgroundColor: const Color(0xFFF1780F),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: secciones.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final seccion = secciones[index];
          return ListTile(
            leading: Icon(seccion['icon'], color: const Color(0xFFF1780F)),
            title: Text(seccion['titulo']),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Por ahora solo visual
            },
          );
        },
      ),
    );
  }
}
