import 'package:flutter/material.dart';

class GestionVoluntariosScreen extends StatelessWidget {
  const GestionVoluntariosScreen({super.key});

  static const Color bg = Color(0xFFF6F5F2);
  static const Color panel = Colors.white;
  static const Color titleColor = Color(0xFF1E1E1E);
  static const Color subtle = Color(0xFF7A7A7A);
  static const Color accent = Color(0xFFF39A4B);
  static const Color accentSoft = Color(0xFFFFF1E6);
  static const Color ok = Color(0xFF2E7D32); 
  static const Color warn = Color(0xFFE65100); 
  static const Color error = Color(0xFFC62828); 

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
          'Volunteers',
          style: text.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: titleColor,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        children: [
          Card(
            color: panel,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Activity: Community Dining Support',
                    style: text.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: titleColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '12/07/2024',
                    style: text.bodyMedium?.copyWith(
                      color: subtle,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Registered Volunteers',
                        style: text.titleSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: titleColor,
                        ),
                      ),
                      Text(
                        '15',
                        style: text.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: accent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  const _VolunteerTile(
                    name: 'Sofia Ramirez',
                    statusText: 'Pending',
                    statusColor: warn,
                    trailingType: _VolunteerTrailing.validate,
                    avatarTone: _AvatarTone.orange,
                  ),
                  const SizedBox(height: 10),
                  const _VolunteerTile(
                    name: 'Carlos Mendoza',
                    statusText: 'Attended',
                    statusColor: ok,
                    trailingType: _VolunteerTrailing.validated,
                    avatarTone: _AvatarTone.green,
                  ),
                  const SizedBox(height: 10),
                  const _VolunteerTile(
                    name: 'Ana Lopez',
                    statusText: 'Not Attended',
                    statusColor: error,
                    trailingType: _VolunteerTrailing.validate,
                    avatarTone: _AvatarTone.pink,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: 2,
        onDestinationSelected: (_) {},
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.event_note_outlined),
            selectedIcon: Icon(Icons.event_note_rounded),
            label: 'Activities',
          ),
          NavigationDestination(
            icon: Icon(Icons.groups_outlined),
            selectedIcon: Icon(Icons.groups_rounded),
            label: 'Volunteers',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

enum _VolunteerTrailing { validate, validated }

enum _AvatarTone { orange, green, pink }

class _VolunteerTile extends StatelessWidget {
  final String name;
  final String statusText;
  final Color statusColor;
  final _VolunteerTrailing trailingType;
  final _AvatarTone avatarTone;

  const _VolunteerTile({
    required this.name,
    required this.statusText,
    required this.statusColor,
    required this.trailingType,
    required this.avatarTone,
  });

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    Widget trailing;
    switch (trailingType) {
      case _VolunteerTrailing.validate:
        trailing = FilledButton(
          onPressed: () {},
          style: FilledButton.styleFrom(
            backgroundColor: GestionVoluntariosScreen.accent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.w800),
          ),
          child: const Text('Validate'),
        );
        break;
      case _VolunteerTrailing.validated:
        trailing = Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: GestionVoluntariosScreen.accentSoft,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'Validated',
            style: TextStyle(
              color: Color(0xFF7A7A7A),
              fontWeight: FontWeight.w800,
            ),
          ),
        );
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: Row(
        children: [
          _LocalAvatar(tone: avatarTone),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: text.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF2A2A2A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  statusText,
                  style: text.bodyMedium?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}

class _LocalAvatar extends StatelessWidget {
  final _AvatarTone tone;
  const _LocalAvatar({required this.tone});

  Color get _bg {
    switch (tone) {
      case _AvatarTone.orange:
        return const Color(0xFFFFE5C7);
      case _AvatarTone.green:
        return const Color(0xFFCDEBDD);
      case _AvatarTone.pink:
        return const Color(0xFFFAD5E5);
    }
  }

  Color get _fg {
    switch (tone) {
      case _AvatarTone.orange:
        return const Color(0xFF8A5A16);
      case _AvatarTone.green:
        return const Color(0xFF2E7D32);
      case _AvatarTone.pink:
        return const Color(0xFFC2185B);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(color: _bg, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Icon(Icons.person, color: _fg),
    );
  }
}
