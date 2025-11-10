import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/validation_provider.dart';
import '../services/validation_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ValidationsPage extends ConsumerWidget {
  const ValidationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValidations = ref.watch(validationsProvider);
    final service = ref.read(validationServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Validaciones de Horas Sociales')),
      body: asyncValidations.when(
        data: (validations) => ListView.builder(
          itemCount: validations.length,
          itemBuilder: (context, index) {
            final v = validations[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(v.avatar),
                ),
                title: Text(v.studentName),
                subtitle: Text('${v.university} • ${v.activity} • ${v.hours} hrs'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(v.status, style: TextStyle(
                      color: v.status == 'Aceptada'
                          ? Colors.green
                          : v.status == 'Rechazada'
                              ? Colors.red
                              : Colors.orange,
                      fontWeight: FontWeight.bold,
                    )),
                    const SizedBox(width: 10),
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      onPressed: () async {
                        await service.updateStatus(v.id, 'Aceptada');
                        ref.invalidate(validationsProvider);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      onPressed: () async {
                        await service.updateStatus(v.id, 'Rechazada');
                        ref.invalidate(validationsProvider);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
