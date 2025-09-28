import 'package:flutter/material.dart';

class NgoProfileScreen extends StatelessWidget {
  const NgoProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil ONG"),
        backgroundColor: const Color(0xFFF1780F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo circular
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/ngo_logo.png"), 
            ),
            const SizedBox(height: 12),

            // Nombre y fecha
            const Text(
              "Fundación Manos Solidarias",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Text(
              "Since 1990",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Descripción ONG
            const Text(
              "Somos una ONG dedicada a promover el bienestar social y ambiental, "
              "trabajando en proyectos de voluntariado que impactan directamente en comunidades vulnerables.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Proyectos Activos
            _buildSectionTitle("Proyectos Activos"),
            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _projectCard("assets/images/tree.png", "Siembra de Árboles"),
                  _projectCard("assets/images/beach.png", "Limpieza de Playa"),
                  _projectCard("assets/images/education.png", "Taller Educativo"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Past Projects
            _buildSectionTitle("Past Projects"),
            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _projectCard("assets/images/river.png", "Reforestación Río"),
                  _projectCard("assets/images/school.png", "Pintura Escuela"),
                  _projectCard("assets/images/community.png", "Apoyo Comunidad"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Impact Hours
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFF1780F)),
              ),
              child: const Text(
                "Total Impact Hours: +500",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),

            // Datos de contacto
            _buildSectionTitle("Contacto"),
            const ListTile(
              leading: Icon(Icons.email, color: Color(0xFFF1780F)),
              title: Text("info@manossolidarias.org"),
            ),
            const ListTile(
              leading: Icon(Icons.phone, color: Color(0xFFF1780F)),
              title: Text("+503 2222-3333"),
            ),
            const ListTile(
              leading: Icon(Icons.location_on, color: Color(0xFFF1780F)),
              title: Text("San Salvador, El Salvador"),
            ),
          ],
        ),
      ),
    );
  }

  // Sección de título
  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Card de proyecto
  Widget _projectCard(String imagePath, String title) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
