import 'package:flutter/material.dart';

class ActivityDetail extends StatefulWidget {
  const ActivityDetail({super.key});

  @override
  State<ActivityDetail> createState() => _ActivityDetailsPageState();
}

class _ActivityDetailsPageState extends State<ActivityDetail> {
  int _selectedIndex = 2; // Mis Actividades por defecto

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/explorer');
        break;
      case 2:
        Navigator.pushNamed(context, '/activities');
        break;
      case 3:
        Navigator.pushNamed(context, '/dashboard');
        break;
      case 4:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onBackground),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Detalles de la Actividad",
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onBackground,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 224,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://lh3.googleusercontent.com/aida-public/AB6AXuBW2ETlDseVjSA3pA1rMt3SXfs7taza3sfrXFUJ0gWpyksi6VP5W0Ao5IIofUw61djufNU0IIj_lODT5R8ryHwFXcj0S6r0URfMRjIml58GKvqKmk1dfZcbCIhcWwZ4ExtTqWg3MIJpxXWKDdEYiMd_CKdHkuj_Js7ZVkz3hvRTKWhvDp6via97p12vOIawponb8TEdzPF-SEvu2xBpc2oTREOVxdCZIf_8TagMR4tj3KpGMETJNH3l0j1sBwDsRIzTo8GJza6h7YI",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Jornada de Voluntariado en Huerto Comunitario",
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Participa en una jornada de voluntariado en nuestro huerto comunitario. Ayuda a plantar, regar y mantener los cultivos, contribuyendo a un espacio verde sostenible y educativo para la comunidad.",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onBackground,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildInfoSection(
                    "Requisitos",
                    "No se requieren habilidades especiales, solo entusiasmo y ganas de colaborar. Se recomienda llevar ropa cómoda y adecuada para trabajar al aire libre.",
                    theme,
                  ),
                  const SizedBox(height: 12),
                  _buildInfoSection("Duración", "4 horas", theme),
                  const SizedBox(height: 12),
                  _buildOrganizerSection(
                    "Organiza",
                    "Voluntarios en Acción",
                    "ONG Sembrando Futuro",
                    "https://lh3.googleusercontent.com/aida-public/AB6AXuBTp9FC-i9v5qkSw3c4biPP4THNYpsdigNy4QWHjsYUu9nFEeFKhiLx6EobxrFYj2vmiejpHPOl3dy7x6z2nMWYStf6AJtd3p0LqrvFQRQ8JlnY4uXbT7WKVchZ2L6I79hK3jpjQj4SO_qdEjSyBxmtDaTQ1GwxDq3p3gOtyewdpHrRDNf5m8-8TQXB9dbd_z8uOvktTnO3rDBk5Jw2tox8DpBv7vZSciKwJ6LMmbpTK_xd-QxomdE_eKaFEGP1joVhp2UPij_-ioc",
                    theme,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {},
              child: Text(
                "Inscribirse",
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
            ),
          ),
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: theme.colorScheme.primary,
            unselectedItemColor: theme.colorScheme.onBackground.withOpacity(0.6),
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explorar"),
              BottomNavigationBarItem(icon: Icon(Icons.event), label: "Mis Actividades"),
              BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Dashboard"),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, String content, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          content,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onBackground,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildOrganizerSection(
    String title,
    String name,
    String org,
    String imageUrl,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onBackground,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            CircleAvatar(radius: 28, backgroundImage: NetworkImage(imageUrl)),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onBackground,
                  ),
                ),
                Text(
                  org,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onBackground.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
