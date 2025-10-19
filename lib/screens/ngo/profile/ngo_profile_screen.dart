import 'package:flutter/material.dart';
import '../notifications/notificaciones_screen.dart';
import '../settings/ngo_settings_screen.dart';
import '../validations/ngo_validation_screen.dart';
import '../reports/impact_reports_screen.dart';
import '../qr/generate_qr_screen.dart';

class NgoProfileScreen extends StatelessWidget {
  const NgoProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil ONG"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificacionesScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NgoSettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo circular desde internet
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage("https://picsum.photos/seed/logo/200"),
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

            // Botón de Validación de Horas Sociales
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NgoValidationScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF1780F),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Validación de Horas Sociales",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white,),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Botón de Reportes de Impacto
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ImpactReportsScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF1780F),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Reportes de Impacto",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white,),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Botón de Generar QR de Actividad
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const GenerateQrScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF1780F),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Generar QR de Actividad",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white,),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Proyectos Activos
            _buildSectionTitle("Proyectos Activos"),
            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _projectCard("https://picsum.photos/seed/tree/200", "Siembra de Árboles"),
                  _projectCard("https://picsum.photos/seed/beach/200", "Limpieza de Playa"),
                  _projectCard("https://picsum.photos/seed/education/200", "Taller Educativo"),
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
                  _projectCard("https://picsum.photos/seed/river/200", "Reforestación Río"),
                  _projectCard("https://picsum.photos/seed/school/200", "Pintura Escuela"),
                  _projectCard("https://picsum.photos/seed/community/200", "Apoyo Comunidad"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Impact Hours
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF1780F), // Fondo naranja fuerte
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFF1780F)),
              ),
              child: const Text(
                "Total Impact Hours: +500",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Texto en blanco
                ),
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

  // Card de proyecto con imágenes de internet
  Widget _projectCard(String imageUrl, String title) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
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
