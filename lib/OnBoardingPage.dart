import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 150),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Imagen cuadrada
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

                      // Título
                      Text(
                        "Connect, Contribute, and Validate",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),

                      const SizedBox(height: 12),

                      // Descripción
                      Text(
                        "Find meaningful volunteer opportunities with NGOs and easily validate your social hours for university credit.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[700],
                            ),
                      ),

                      const SizedBox(height: 32),

                      // Botón Registro
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
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

                      // Botón Login
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
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

                    ],
                  ),
                ),
              ),
            ),

            // Footer (Bottom Nav)
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.withOpacity(0.2)),
                ),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: const Color(0xFFF2780D),
                unselectedItemColor: Colors.grey,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
                  BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explorar"),
                  BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "Actividades",),
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
