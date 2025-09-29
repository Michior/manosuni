import 'package:flutter/material.dart';

class GestionActividadesScreen extends StatefulWidget {
  const GestionActividadesScreen({super.key});

  @override
  State<GestionActividadesScreen> createState() =>
      _GestionActividadesScreenState();
}

class _GestionActividadesScreenState extends State<GestionActividadesScreen>
    with SingleTickerProviderStateMixin {
  static const Color bg = Color(0xFFF6F5F2);
  static const Color panel = Colors.white;
  static const Color accent = Color(0xFFF39A4B);
  static const Color accentSoft = Color(0xFFFFF1E6);

  late final TabController _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/dashboard-ong');
        break;
      case 1:
        Navigator.pushNamed(context, '/gestion-actividades');
        break;
      case 2:
        Navigator.pushNamed(context, '/gestion-voluntarios');
        break;
      case 3:
        Navigator.pushNamed(context, '/profile-ong');
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
          'Actividades',
          style: text.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E1E1E),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            height: 48,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            decoration: BoxDecoration(
              color: panel,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tabs,
              indicatorColor: accent,
              labelColor: accent,
              unselectedLabelColor: const Color(0xFF7A7A7A),
              labelStyle: const TextStyle(fontWeight: FontWeight.w800),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w700,
              ),
              indicatorSize: TabBarIndicatorSize.label,
              tabs: const [
                Tab(text: 'Próximas'),
                Tab(text: 'En curso'),
                Tab(text: 'Completadas'),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            children: const [
              _ActivityCard(
                title: 'Limpieza de playas',
                dateText: '10 de mayo, 10:00 AM',
                imageUrl: 'https://picsum.photos/seed/beach/200/200',
              ),
              SizedBox(height: 12),
              _ActivityCard(
                title: 'Taller de reciclaje',
                dateText: '15 de mayo, 2:00 PM',
                imageUrl: 'https://picsum.photos/seed/recycle/200/200',
              ),
            ],
          ),

          ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            children: const [
              _EmptyHint(
                icon: Icons.pending_actions_rounded,
                text: 'No hay actividades en curso.',
              ),
            ],
          ),

          ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            children: const [
              _EmptyHint(
                icon: Icons.check_circle_outline_rounded,
                text: 'Aún no hay actividades completadas.',
              ),
            ],
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/publicar-actividad'),
        tooltip: 'Añadir actividad',
        child: const Icon(Icons.add_rounded),
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.event_note_outlined),
            selectedIcon: Icon(Icons.event_note_rounded),
            label: 'Actividades',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            selectedIcon: Icon(Icons.groups_rounded),
            label: 'Voluntarios',
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

class _ActivityCard extends StatelessWidget {
  final String title;
  final String dateText;
  final String? imageUrl;

  const _ActivityCard({
    required this.title,
    required this.dateText,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Thumb(imageUrl: imageUrl),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: text.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF2A2A2A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dateText,
                        style: text.bodyMedium?.copyWith(
                          color: const Color(0xFF7A7A7A),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                _SecondaryButton(
                  label: 'Editar',
                  onPressed: () {}, // mock
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _PrimaryButton(
                    label: 'Cerrar inscripciones',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Thumb extends StatelessWidget {
  final String? imageUrl;
  const _Thumb({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: 60,
        height: 60,
        child: imageUrl == null
            ? Container(
                color: const Color(0xFFEDEDED),
                child: const Icon(Icons.image, color: Color(0xFF9AA0A6)),
              )
            : Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: const Color(0xFFEDEDED),
                  child: const Icon(
                    Icons.broken_image_rounded,
                    color: Color(0xFF9AA0A6),
                  ),
                ),
              ),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const _SecondaryButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: _GestionActividadesScreenState.accentSoft,
        foregroundColor: const Color(0xFF7A7A7A),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(fontWeight: FontWeight.w800),
      ),
      child: Text(label),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const _PrimaryButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: _GestionActividadesScreenState.accent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(fontWeight: FontWeight.w800),
      ),
      child: Text(label),
    );
  }
}

class _EmptyHint extends StatelessWidget {
  final IconData icon;
  final String text;
  const _EmptyHint({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 36),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Icon(icon, size: 36, color: const Color(0xFF9AA0A6)),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF7A7A7A),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
