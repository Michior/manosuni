import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

class GestionVoluntariosScreen extends StatelessWidget {
  const GestionVoluntariosScreen({super.key});

  static const Color ok = Color(0xFF2E7D32);
  static const Color warn = Color(0xFFE65100);
  static const Color error = Color(0xFFC62828);

  void _onItemTapped(BuildContext context, int index) {
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded,
              color: theme.appBarTheme.foregroundColor),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        centerTitle: true,
        title: Text(
          'Voluntarios',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.appBarTheme.foregroundColor,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Actividad: Apoyo en Comedor Comunitario',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '12/07/2024',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Voluntarios Inscritos',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '15',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                const _VolunteerTile(
                  name: 'Sofía Ramirez',
                  statusText: 'Pendiente',
                  statusColor: warn,
                  trailingType: _VolunteerTrailing.validate,
                  avatarTone: _AvatarTone.orange,
                ),
                const SizedBox(height: 10),
                const _VolunteerTile(
                  name: 'Carlos Mendoza',
                  statusText: 'Asistió',
                  statusColor: ok,
                  trailingType: _VolunteerTrailing.validated,
                  avatarTone: _AvatarTone.green,
                ),
                const SizedBox(height: 10),
                const _VolunteerTile(
                  name: 'Ana López',
                  statusText: 'No asistió',
                  statusColor: error,
                  trailingType: _VolunteerTrailing.validate,
                  avatarTone: _AvatarTone.pink,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: theme.bottomNavigationBarTheme.unselectedItemColor,
        backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
        onTap: (i) => _onItemTapped(context, i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Actividades"),
          BottomNavigationBarItem(icon: Icon(Icons.groups), label: "Voluntarios"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
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
    final theme = Theme.of(context);

    Widget trailing;
    switch (trailingType) {
      case _VolunteerTrailing.validate:
        trailing = ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {},
          child: const Text(
            "Validar",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        );
        break;
      case _VolunteerTrailing.validated:
        trailing = Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "Validado",
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodySmall?.color,
            ),
          ),
        );
        break;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
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
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  statusText,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
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

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (tone) {
      case _AvatarTone.orange:
        bg = const Color(0xFFFFE5C7);
        fg = const Color(0xFF8A5A16);
        break;
      case _AvatarTone.green:
        bg = const Color(0xFFCDEBDD);
        fg = const Color(0xFF2E7D32);
        break;
      case _AvatarTone.pink:
        bg = const Color(0xFFFAD5E5);
        fg = const Color(0xFFC2185B);
        break;
    }

    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Icon(Icons.person, color: fg),
    );
  }
}
