import 'package:flutter/material.dart';

class NotificacionesScreen extends StatelessWidget {
  const NotificacionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notificaciones = [
      {
        "nombre": "Carlos Méndez",
        "descripcion": "Ha confirmado su asistencia a tu actividad.",
        "hora": "10:45 AM",
        "imagen": "https://i.pravatar.cc/150?img=3"
      },
      {
        "nombre": "Fundación Verde",
        "descripcion": "Tu solicitud de voluntariado fue aceptada.",
        "hora": "9:20 AM",
        "imagen": "https://i.pravatar.cc/150?img=4"
      },
      {
        "nombre": "Ana López",
        "descripcion": "Se inscribió a la actividad de limpieza de playas.",
        "hora": "Ayer",
        "imagen": "https://i.pravatar.cc/150?img=5"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notificaciones"),
        backgroundColor: const Color(0xFFF1780F),
      ),
      body: ListView.builder(
        itemCount: notificaciones.length,
        itemBuilder: (context, index) {
          final noti = notificaciones[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(noti["imagen"]!),
            ),
            title: Text(
              noti["nombre"]!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(noti["descripcion"]!),
            trailing: Text(
              noti["hora"]!,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            onTap: () {
              // Aquí podrías abrir detalles de la notificación
            },
          );
        },
      ),
    );
  }
}