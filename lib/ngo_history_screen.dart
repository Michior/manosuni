import 'package:flutter/material.dart';

class NgoHistoryScreen extends StatelessWidget {
  const NgoHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Ejemplo de datos de historial
    final List<Map<String, String>> historial = [
      {
        'actividad': 'Siembra de Árboles',
        'fecha': '12/03/2025',
        'voluntarios': '25',
        'horas': '75',
      },
      {
        'actividad': 'Campaña de Reciclaje',
        'fecha': '05/02/2025',
        'voluntarios': '30',
        'horas': '90',
      },
      {
        'actividad': 'Donación de Alimentos',
        'fecha': '20/01/2025',
        'voluntarios': '15',
        'horas': '45',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Historial de Actividades ONG"),
        backgroundColor: const Color(0xFFF1780F),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: historial.length,
        itemBuilder: (context, index) {
          final actividad = historial[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    actividad['actividad']!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text("Fecha: ${actividad['fecha']}"),
                  Text("Voluntarios: ${actividad['voluntarios']}"),
                  Text("Horas aportadas: ${actividad['horas']}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
