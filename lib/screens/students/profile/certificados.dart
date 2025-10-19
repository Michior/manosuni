import 'package:flutter/material.dart';

class CertificadosScreen extends StatelessWidget {
  const CertificadosScreen({super.key});

  static const Color accent = Color(0xFFF39A4B);
  static const Color accentSoft = Color(0xFFFFF1E6);
  static const Color bg = Color(0xFFF6F5F2);

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
    final text = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        centerTitle: true,
        title: Text(
          'Certificates',
          style: text.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E1E1E),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        children: const [
          _CertificateTile(
            iconBg: accentSoft,
            iconColor: accent,
            title: 'Community Service Award',
            subtitle: 'Certificate of Participation',
          ),
          SizedBox(height: 12),
          _CertificateTile(
            iconBg: accentSoft,
            iconColor: accent,
            title: 'Environmental Cleanup',
            subtitle: 'Certificate of Completion',
          ),
          SizedBox(height: 12),
          _CertificateTile(
            iconBg: accentSoft,
            iconColor: accent,
            title: 'Youth Leadership Program',
            subtitle: 'Certificate of Appreciation',
          ),
          SizedBox(height: 12),
          _CertificateTile(
            iconBg: accentSoft,
            iconColor: accent,
            title: 'Volunteer of the Month',
            subtitle: 'Certificate of Recognition',
          ),
        ],
      ),
      
      // --- Bottom Navigation Bar ---
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 4, // Mis Actividades
        //selectedItemColor: theme.colorScheme.primary,
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

class _CertificateTile extends StatelessWidget {
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _CertificateTile({
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.picture_as_pdf_rounded,
                color: iconColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: text.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF2A2A2A),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: text.bodyMedium?.copyWith(
                      color: const Color(0xFF7A7A7A),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.download_rounded,
                color: Color(0xFF7A7A7A),
              ),
              tooltip: 'Download',
            ),
          ],
        ),
      ),
    );
  }
}
