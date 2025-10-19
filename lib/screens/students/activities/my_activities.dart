import 'package:flutter/material.dart';

// Widget principal
class MisActividades extends StatelessWidget {
  const MisActividades({super.key});

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/'); // Inicio
        break;
      case 1:
        Navigator.pushNamed(context, '/explorer'); // Explorar
        break;
      case 2:
        Navigator.pushNamed(context, '/activities'); // Actividades
        break;
      case 3:
        Navigator.pushNamed(context, '/dashboard'); // Dashboard
        break;
      case 4:
        Navigator.pushNamed(context, '/profile'); // Perfil
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Mis Actividades",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Próximas Actividades ---
            const SectionTitle(title: "Próximas Actividades"),
            const SizedBox(height: 12),
            ActivityCard(
              title: "Limpieza de la Playa",
              category: "Voluntariado",
              organization: "EcoMar",
              imageUrl:
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuBYljBbgYwJF9F7N7RMxlfWPo6QnbAKuPh5gaZMOmm1KZ8CfDXYQ8EONjBD-KGX2Rx_eh1YrDjg0sDkYjKvWX1pvRUMTRigJ9zCnCHdeXdGeZRGAvw5n99fffIVEOKbbl_9yFNF0JEQU40Y5YkkJJwup0WvCIj1MFvbONKbSNlmkbtd1Faqu9ijvKS1P--uzou5Evrnc6W7JukUTZFhYxue6AGQvSw6152LMGeFv9-YIY3-vjcY2qMRvLyllum25clEgUQVPQKYlyc",
              onTapDetails: () => Navigator.pushNamed(context, '/detalles'),
            ),

            const SizedBox(height: 24),

            // --- Historial de Voluntariado ---
            const SectionTitle(title: "Historial de Voluntariado"),
            const SizedBox(height: 12),
            HistoryCard(
              title: "Ayuda en el Comedor Social",
              subtitle: "2 horas",
              imageUrl:
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuCfTs-0tfzt1p-UeyHolj8rQWAU5r_6lwcMJv0c7SSreBvDfqnvCVs2_MTYotXPtICmPM0yielFucv88hzycByeb5Xs6m4GB0FtcE9KxLFVzy1A3BwBVAzMwomI3LW1vFNAYEMDUmq93JPhMDWEyWIwvMW0dftJrFcwjZwZO_TX5iDbzISpJbgmNkjsK1XFOqjiEErfaCwZfyFn2GxMwcnSulJAww6Rj57Kn_nC10U3dRr5cAwXYnUuQ7vqlO55P1WlRZz8YbEG1Lg",
            ),
            HistoryCard(
              title: "Taller de Reciclaje",
              subtitle: "3 horas",
              imageUrl:
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuAf4apWDjh59fk8UsmhaZWF4NhD78RFLmsHEUu_FAj7dLHJIi2PvF8lp-2wQoBZcGNGKmdCs8Y7yiw7F9y8_jWlzJs25a4wh-IoFIj7B28_zpdHeoCiwnqA9XdOOHC6_vG0WLpbZrCooml7KmtNyGRH_H6pgBhNvOX8HK9n4WzCjyNFYY4LjuuzwO-2xqfQHmMbcgf9FZzXZJXkzdlZGRegBWVhtXuZnwfARRqZ-Za30WeNyoWN8-jmn5HGv51HLtCKPJtIFTfW1RE",
            ),

            const SizedBox(height: 24),

            // --- Horas Validadas ---
            const SectionTitle(title: "Horas Validadas"),
            const SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Horas de Servicio Social",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Text("15/20 horas",
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: 0.75,
                        color: theme.colorScheme.primary,
                        backgroundColor: theme.colorScheme.onSurface.withOpacity(0.1),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // --- Bottom Navigation Bar ---
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2, // Mis Actividades
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explorar"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "Actividades"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
        onTap: (index) => _onItemTapped(context, index),
      ),
    );
  }
}

// --- Widgets Reutilizables ---

class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final String title;
  final String category;
  final String organization;
  final String imageUrl;
  final VoidCallback onTapDetails;

  const ActivityCard({
    super.key,
    required this.title,
    required this.category,
    required this.organization,
    required this.imageUrl,
    required this.onTapDetails,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category,
                    style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
                const SizedBox(height: 4),
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Text("Organizado por $organization",
                    style: const TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: onTapDetails,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
                    foregroundColor: theme.colorScheme.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                  ),
                  child: const Text(
                    "Ver detalles",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const HistoryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(imageUrl, width: 56, height: 56, fit: BoxFit.cover),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
