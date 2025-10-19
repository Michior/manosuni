import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _selectedIndex = 0;

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
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 150),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // --- Imagen ---
                      Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "https://lh3.googleusercontent.com/aida-public/AB6AXuBWdpmKYBWrOeve9F4sF_zNhCkOcHTa464M3PWFttfJGqgQjDo4-wOXiKP4stDootF8qKj2Rd-m2OunLf49_75N3ckRh0Lipt3Kcwh3XeFS9mevIdX3WtBplmC_28FnTpnxMCIId714quQzpqy-E8N9diwygTc34DbcqnGXDnS65s946jPrMflRAivYfocv2iN1ZFu-5OPMB-LVDu0VfhzPFNOuurwu2Y3gbAtGEYNkfR3NYSdDmR6nH6mn1BQRvhd4AFOla-ZwhuQ",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // --- Título ---
                      Text(
                        "Connect, Contribute, and Validate",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // --- Descripción ---
                      Text(
                        "Find meaningful volunteer opportunities with NGOs and easily validate your social hours for university credit.",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // --- Botón Registro ---
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/register'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF2780D),
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Registro",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // --- Botón Login ---
                      OutlinedButton(
                        onPressed: () => Navigator.pushNamed(context, '/login'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          side: BorderSide(color: const Color(0xFFF2780D).withOpacity(0.5)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Iniciar sesión",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFF2780D)),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // --- Botón Login ---
                      OutlinedButton(
                        onPressed: () => Navigator.pushNamed(context, '/gestion-actividades'),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          side: BorderSide(color: const Color(0xFFF2780D).withOpacity(0.5)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Iniciar sesión como ONG",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFF2780D)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // --- Bottom Navigation ---
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.withOpacity(0.2)),
                ),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: _selectedIndex,
                selectedItemColor: const Color(0xFFF2780D),
                unselectedItemColor: const Color.fromARGB(255, 183, 181, 181),
                onTap: _onItemTapped,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
                  BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explorar"),
                  BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "Actividades"),
                  BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Dashboard"),
                  BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
