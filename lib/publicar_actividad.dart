import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

class PublicarActividadScreen extends StatelessWidget {
  const PublicarActividadScreen({super.key});

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
    final theme = Theme.of(context);

    InputDecoration deco(String hint, {IconData? icon}) {
      return InputDecoration(
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon, color: theme.iconTheme.color) : null,
        filled: true,
        fillColor: theme.colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
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
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
        );

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
          'Publicar actividad',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.appBarTheme.foregroundColor,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        children: [
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: theme.colorScheme.surface,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  label('Título'),
                  TextField(
                    decoration: deco('Ej. Jornada de Reforestación',
                        icon: Icons.title_rounded),
                  ),
                  const SizedBox(height: 14),

                  label('Fecha'),
                  TextField(
                    readOnly: true,
                    decoration: deco('Seleccionar fecha',
                        icon: Icons.calendar_today_rounded),
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
                              decoration: deco('10:00 AM',
                                  icon: Icons.schedule_rounded),
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
                              decoration: deco('12:00 PM',
                                  icon: Icons.schedule_rounded),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  label('Ubicación'),
                  TextField(
                    decoration: deco('Ej. Parque Central, San Salvador',
                        icon: Icons.place_rounded),
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
                              decoration: deco('Ej. 20',
                                  icon: Icons.people_alt_rounded),
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
                              decoration: deco('Ej. 2',
                                  icon: Icons.timer_outlined),
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
                    decoration: deco('Describe la actividad, tareas y objetivos'),
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
              onPressed: () =>
                  Navigator.pushNamed(context, '/gestion-actividades'),
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
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

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: theme.bottomNavigationBarTheme.unselectedItemColor,
        backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
        onTap: (i) => _onItemTapped(context, i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Publicar"),
          BottomNavigationBarItem(
              icon: Icon(Icons.event_note), label: "Actividades"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
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
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: selected
            ? AppTheme.primaryColor.withOpacity(0.1)
            : theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: selected ? AppTheme.primaryColor : Colors.grey.shade400,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: selected ? AppTheme.primaryColor : theme.colorScheme.onSurface,
        ),
      ),
    );
  }
}

class _UploadMock extends StatelessWidget {
  const _UploadMock();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {}, // mock
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_upload_rounded,
                size: 28, color: theme.iconTheme.color),
            const SizedBox(width: 8),
            Text(
              'Adjuntar imagen',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: theme.textTheme.bodySmall?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
