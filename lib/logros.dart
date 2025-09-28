import 'package:flutter/material.dart';

class LogrosScreen extends StatelessWidget {
  const LogrosScreen({super.key});

  static const Color accent = Color(0xFFF39A4B);
  static const Color accentSoft = Color(0xFFFFF1E6);
  static const Color bg = Color(0xFFF6F5F2);

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/dashboard'); 
        break;
      case 1:
        Navigator.pushNamed(context, '/explorer');
        break;
      case 2:
        Navigator.pushNamed(context, '/activities'); 
        break;
      case 3:
        Navigator.pushNamed(context, '/profile'); 
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
          'Logros',
          style: text.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E1E1E),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        children: [
          Card(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Insignias desbloqueadas',
                    style: text.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1E1E1E),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Wrap(
                    spacing: 24,
                    runSpacing: 20,
                    children: const [
                      _BadgeItem(
                        title: 'Voluntario de Bronce',
                        bgColor: Color(0xFFEDEDED),
                        iconColor: Color(0xFF9C6B53),
                        icon: Icons.military_tech_rounded,
                      ),
                      _BadgeItem(
                        title: 'Voluntario de Plata',
                        bgColor: Color(0xFFEDEDED),
                        iconColor: Color(0xFF9E9E9E),
                        icon: Icons.workspace_premium_rounded,
                      ),
                      _BadgeItem(
                        title: 'Voluntario de Oro',
                        bgColor: Color(0xFFEDEDED),
                        iconColor: Color(0xFFC9A227),
                        icon: Icons.emoji_events_rounded,
                      ),
                      _BadgeItem(
                        title: 'Embajador de Impacto',
                        bgColor: Color(0xFF2BA3A0),
                        iconColor: Colors.white,
                        icon: Icons.badge_rounded,
                      ),
                      _BadgeItem(
                        title: 'Héroe de la Comunidad',
                        bgColor: Color(0xFFFFE5C7),
                        iconColor: Color(0xFF8A5A16),
                        icon: Icons.volunteer_activism_rounded,
                      ),
                      _BadgeItem(
                        title: 'Campeón del Cambio',
                        bgColor: Color(0xFF4DB38F),
                        iconColor: Colors.white,
                        icon: Icons.eco_rounded,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Estadísticas',
                    style: text.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1E1E1E),
                    ),
                  ),
                  const SizedBox(height: 12),

                  const _StatCard(label: 'Horas de voluntariado', value: '150'),
                  const SizedBox(height: 12),

                  const _StatCard(
                    label: 'Actividades completadas',
                    value: '25',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: 3, 
        onDestinationSelected: (i) => _onItemTapped(context, i),
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
            label: 'Mis Actividades',
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

class _BadgeItem extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color iconColor;
  final IconData icon;

  const _BadgeItem({
    required this.title,
    required this.bgColor,
    required this.iconColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return SizedBox(
      width: 150, 
      child: Column(
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Icon(icon, color: iconColor, size: 36),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: text.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF2A2A2A),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 18),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: LogrosScreen.accentSoft,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.insights_rounded,
                color: LogrosScreen.accent,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: text.bodyMedium?.copyWith(
                      color: const Color(0xFF7A7A7A),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: text.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF2A2A2A),
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
