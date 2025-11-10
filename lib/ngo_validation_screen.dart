import 'package:flutter/material.dart';
import 'package:manosuni/screens/ngo/validations/validation_service.dart';
import 'package:manosuni/screens/ngo/validations/validation_model.dart';

class NgoValidationScreen extends StatefulWidget {
  const NgoValidationScreen({super.key});

  @override
  State<NgoValidationScreen> createState() => _NgoValidationScreenState();
}

class _NgoValidationScreenState extends State<NgoValidationScreen> {
  final ValidationService _service = ValidationService();
  late Future<List<Validation>> _validationsFuture;

  @override
  void initState() {
    super.initState();
    _validationsFuture = _service.getValidations();
  }

  Future<void> _refreshData() async {
    setState(() {
      _validationsFuture = _service.getValidations();
    });
  }

  Future<void> _updateStatus(int id, String status) async {
    await _service.updateStatus(id, status);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Estado actualizado a "$status"')),
    );
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Validación de Horas Sociales"),
        backgroundColor: const Color(0xFFF1780F),
      ),
      body: FutureBuilder<List<Validation>>(
        future: _validationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          final validations = snapshot.data ?? [];

          if (validations.isEmpty) {
            return const Center(child: Text("No hay validaciones pendientes."));
          }

          return RefreshIndicator(
            onRefresh: _refreshData,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: validations.length,
              itemBuilder: (context, index) {
                final v = validations[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(v.avatar),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(v.studentName,
                                  style: const TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(v.university,
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.grey)),
                              const SizedBox(height: 4),
                              Text(
                                  "Horas: ${v.hours} - Actividad: ${v.activity}",
                                  style: const TextStyle(fontSize: 14)),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () =>
                                        _updateStatus(v.id, "Aceptada"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                    ),
                                    child: const Text(
                                      "Aceptar",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    onPressed: () =>
                                        _updateStatus(v.id, "Rechazada"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    child: const Text(
                                      "Rechazar",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
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
        },
      ),
    );
  }
}
