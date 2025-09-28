import 'package:flutter/material.dart';

class OpportunityDetails extends StatelessWidget {
  final String title;
  final String description;
  final String requirements;
  final String duration;
  final String organizationName;
  final String organizationSubtitle;
  final String imageUrl;
  final String orgLogoUrl;

  const OpportunityDetails({
    super.key,
    required this.title,
    required this.description,
    required this.requirements,
    required this.duration,
    required this.organizationName,
    required this.organizationSubtitle,
    required this.imageUrl,
    required this.orgLogoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F5F5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Detalles de la Actividad",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // --- Imagen principal ---
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),

          // --- Contenido desplazable ---
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título de la oportunidad
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Descripción
                  Text(
                    description,
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                  const SizedBox(height: 16),

                  // Requisitos
                  const Text(
                    "Requisitos",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    requirements,
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                  const SizedBox(height: 16),

                  // Duración
                  const Text(
                    "Duración",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    duration,
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                  const SizedBox(height: 16),

                  // Organización
                  const Text(
                    "Organiza",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(orgLogoUrl),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            organizationName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            organizationSubtitle,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // --- Botón de inscripción ---
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Acción de inscripción
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Te has inscrito a la actividad")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF2780D),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Inscribirse",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
