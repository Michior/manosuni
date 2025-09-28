import 'package:flutter/material.dart';

class NotificationsStudentScreen extends StatefulWidget {
  const NotificationsStudentScreen({super.key});

  @override
  State<NotificationsStudentScreen> createState() =>
      _NotificationsStudentScreenState();
}

class _NotificationsStudentScreenState
    extends State<NotificationsStudentScreen> {
  int _navIndex = 0;

  
  static const Color accent = Color(0xFFF39A4B); 
  static const Color accentSoft = Color(0xFFFFF1E6); 
  static const Color cardBg = Colors.white;
  static const Color bg = Color(0xFFF6F5F2); 
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
          'Notificaciones',
          style: text.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E1E1E),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        children: const [
          _NotificationTile(
            icon: Icons.event,
            iconBg: accentSoft,
            iconColor: accent,
            cardBg: cardBg,
            title: 'Recordatorio: Taller de Voluntariado',
            subtitle: 'Mañana, 10:00 AM',
          ),
          SizedBox(height: 12),
          _NotificationTile(
            icon: Icons.check_circle_outline_rounded,
            iconBg: accentSoft,
            iconColor: accent,
            cardBg: cardBg,
            title: 'Registro para "Limpieza de Playas"',
            subtitle: 'Confirmado',
          ),
          SizedBox(height: 12),
          _NotificationTile(
            icon: Icons.hourglass_bottom_rounded,
            iconBg: accentSoft,
            iconColor: accent,
            cardBg: cardBg,
            title: 'Voluntariado en "Refugio de Animales"',
            subtitle: '2 horas validadas',
          ),
          SizedBox(height: 12),
          _NotificationTile(
            icon: Icons.event,
            iconBg: accentSoft,
            iconColor: accent,
            cardBg: cardBg,
            title: 'Recordatorio: Charla sobre Sostenibilidad',
            subtitle: 'Mañana, 2:00 PM',
          ),
          SizedBox(height: 12),
          _NotificationTile(
            icon: Icons.check_circle_outline_rounded,
            iconBg: accentSoft,
            iconColor: accent,
            cardBg: cardBg,
            title: 'Registro para "Apoyo Escolar"',
            subtitle: 'Confirmado',
          ),
          SizedBox(height: 12),
          _NotificationTile(
            icon: Icons.hourglass_bottom_rounded,
            iconBg: accentSoft,
            iconColor: accent,
            cardBg: cardBg,
            title: 'Voluntariado en "Comedor Social"',
            subtitle: '3 horas validadas',
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _navIndex,
        onDestinationSelected: (i) {
          setState(() => _navIndex = i);
          // conexion
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.search_rounded),
            selectedIcon: Icon(Icons.search_rounded),
            label: 'Explorar',
          ),
          NavigationDestination(
            icon: Icon(Icons.event_note_outlined),
            selectedIcon: Icon(Icons.event_note_rounded),
            label: 'Actividades',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final Color cardBg; 
  final String title;
  final String subtitle;

  const _NotificationTile({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.cardBg,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Card(
      color: cardBg,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Icon(icon, color: iconColor, size: 24),
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
          ],
        ),
      ),
    );
  }
}
