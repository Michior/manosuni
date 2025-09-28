import 'package:flutter/material.dart';

class NgoValidationScreen extends StatelessWidget {
  const NgoValidationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de ejemplo de estudiantes que presentan horas
    final List<Map<String, String>> students = [
      {
        "name": "Juan Pérez",
        "university": "UCA - Ingeniería",
        "hours": "5",
        "activity": "Siembra de Árboles",
        "avatar": "https://i.pravatar.cc/150?img=1"
      },
      {
        "name": "María López",
        "university": "UES - Psicología",
        "hours": "3",
        "activity": "Campaña de Limpieza",
        "avatar": "https://i.pravatar.cc/150?img=2"
      },
      {
        "name": "Carlos Gómez",
        "university": "UFG - Administración",
        "hours": "4",
        "activity": "Taller Educativo",
        "avatar": "https://i.pravatar.cc/150?img=3"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Validación de Horas Sociales"),
        backgroundColor: const Color(0xFFF1780F),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(student["avatar"]!),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(student["name"]!,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(student["university"]!,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey)),
                        const SizedBox(height: 4),
                        Text(
                            "Horas presentadas: ${student["hours"]} - Actividad: ${student["activity"]}",
                            style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green),
                              child: const Text("Aceptar"),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              child: const Text("Rechazar"),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
