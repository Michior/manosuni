import 'package:flutter/material.dart';

class PublicarActividadScreen extends StatelessWidget {
  const PublicarActividadScreen({super.key});

  static const Color bg = Color(0xFFF6F5F2);
  static const Color accent = Color(0xFFF39A4B);
  static const Color accentSoft = Color(0xFFFFF1E6);

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/dashboard-ong');
        break;
      case 1:
        Navigator.pushNamed(context, '/publicar-actividad');
        break;
      case 2:
        Navigator.pushNamed(context, '/gestion-actividades');
        break;
      case 3:
        Navigator.pushNamed(context, '/profile-ong');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    InputDecoration deco(String hint, {IconData? icon}) {
      return InputDecoration(
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon) : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      );
    }

    Widget label(String t) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        t,
        style: text.bodyLarge?.copyWith(
          fontWeight: FontWeight.w800,
          color: const Color(0xFF1E1E1E),
        ),
      ),
    );

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
          'Publicar actividad',
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  label('Título'),
                  TextField(
                    decoration: deco(
                      'Ej. Jornada de Reforestación',
                      icon: Icons.title_rounded,
                    ),
                  ),
                  const SizedBox(height: 14),

                  label('Fecha'),
                  TextField(
                    readOnly: true,
                    decoration: deco(
                      'Seleccionar fecha',
                      icon: Icons.calendar_today_rounded,
                    ),
                  ),
                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            label('Inicio'),
                            TextField(
                              readOnly: true,
                              decoration: deco(
                                '10:00 AM',
                                icon: Icons.schedule_rounded,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            label('Fin'),
                            TextField(
                              readOnly: true,
                              decoration: deco(
                                '12:00 PM',
                                icon: Icons.schedule_rounded,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  label('Ubicación'),
                  TextField(
                    decoration: deco(
                      'Ej. Parque Central, San Salvador',
                      icon: Icons.place_rounded,
                    ),
                  ),
                  const SizedBox(height: 14),

                  label('Categoría'),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      _ChipMock(text: 'Ambiental', selected: true),
                      _ChipMock(text: 'Educación'),
                      _ChipMock(text: 'Salud'),
                      _ChipMock(text: 'Comunidad'),
                    ],
                  ),
                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            label('Cupos'),
                            TextField(
                              keyboardType: TextInputType.number,
                              decoration: deco(
                                'Ej. 20',
                                icon: Icons.people_alt_rounded,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            label('Duración (horas)'),
                            TextField(
                              keyboardType: TextInputType.number,
                              decoration: deco(
                                'Ej. 2',
                                icon: Icons.timer_outlined,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  label('Requisitos'),
                  TextField(
                    maxLines: 3,
                    decoration: deco('Ej. Mayor de 18, ropa cómoda, etc.'),
                  ),
                  const SizedBox(height: 14),

                  label('Descripción'),
                  TextField(
                    maxLines: 5,
                    decoration: deco(
                      'Describe la actividad, tareas y objetivos',
                    ),
                  ),
                  const SizedBox(height: 16),

                  label('Imagen (opcional)'),
                  const _UploadMock(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => Navigator.pushNamed(context, '/gestion-actividades'),
              style: FilledButton.styleFrom(
                backgroundColor: accent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Publicar',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: 1,
        onDestinationSelected: (i) => _onItemTapped(context, i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.event_available_outlined),
            selectedIcon: Icon(Icons.event_available_rounded),
            label: 'Publicar',
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

class _ChipMock extends StatelessWidget {
  final String text;
  final bool selected;
  const _ChipMock({required this.text, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: selected
            ? PublicarActividadScreen.accentSoft
            : const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: selected
              ? PublicarActividadScreen.accent
              : const Color(0xFFE6E6E6),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: selected
              ? PublicarActividadScreen.accent
              : const Color(0xFF535353),
        ),
      ),
    );
  }
}

class _UploadMock extends StatelessWidget {
  const _UploadMock();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {}, // mock
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9F9),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFEAEAEA)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.cloud_upload_rounded,
              size: 28,
              color: Color(0xFF8B8B8B),
            ),
            SizedBox(width: 8),
            Text(
              'Adjuntar imagen',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF8B8B8B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
