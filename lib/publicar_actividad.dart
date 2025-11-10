import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:manosuni/theme/app_theme.dart';
import 'package:manosuni/services/activities_service.dart';

class PublicarActividadScreen extends ConsumerStatefulWidget {
  const PublicarActividadScreen({super.key});

  @override
  ConsumerState<PublicarActividadScreen> createState() =>
      _PublicarActividadScreenState();
}

class _PublicarActividadScreenState
    extends ConsumerState<PublicarActividadScreen> {
  final _titleCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _requirementsCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  final _capacityCtrl = TextEditingController(text: '20');
  final _durationHoursCtrl = TextEditingController(text: '2');

  DateTime? _date;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String _category = 'Ambiental';
  String _modality = 'onsite';

  Activity? _editing;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_editing == null) {
      final Activity? a =
          ModalRoute.of(context)?.settings.arguments as Activity?;
      if (a != null) {
        _editing = a;

        _titleCtrl.text = a.title;
        _descriptionCtrl.text = a.description;
        _capacityCtrl.text = '${a.capacity}';
        _category = a.category.isNotEmpty ? a.category : 'Ambiental';
        _modality = a.modality.isNotEmpty ? a.modality : 'onsite';

        final s = a.start.toLocal();
        final e = a.end.toLocal();

        _date = DateTime(s.year, s.month, s.day);
        _startTime = TimeOfDay(hour: s.hour, minute: s.minute);
        _endTime = TimeOfDay(hour: e.hour, minute: e.minute);
      }
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _locationCtrl.dispose();
    _requirementsCtrl.dispose();
    _descriptionCtrl.dispose();
    _capacityCtrl.dispose();
    _durationHoursCtrl.dispose();
    super.dispose();
  }

  InputDecoration _deco(BuildContext ctx, String hint, {IconData? icon}) {
    final theme = Theme.of(ctx);
    return InputDecoration(
      hintText: hint,
      prefixIcon: icon != null
          ? Icon(icon, color: theme.iconTheme.color)
          : null,
      filled: true,
      fillColor: theme.colorScheme.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    );
  }

  Widget _label(BuildContext context, String t) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        t,
        style: theme.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w800,
          color: theme.textTheme.bodyLarge?.color,
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final initial = _date ?? now;
    final d = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
    );
    if (d != null) setState(() => _date = d);
  }

  Future<void> _pickStartTime() async {
    final t = await showTimePicker(
      context: context,
      initialTime: _startTime ?? const TimeOfDay(hour: 10, minute: 0),
    );
    if (t != null) setState(() => _startTime = t);
  }

  Future<void> _pickEndTime() async {
    final t = await showTimePicker(
      context: context,
      initialTime: _endTime ?? const TimeOfDay(hour: 12, minute: 0),
    );
    if (t != null) setState(() => _endTime = t);
  }

  DateTime _combine(DateTime date, TimeOfDay time) =>
      DateTime(date.year, date.month, date.day, time.hour, time.minute);

  Future<void> _submit() async {
    final svc = ref.read(activitiesServiceProvider);

    if (_titleCtrl.text.trim().isEmpty) {
      _showSnack('El título es obligatorio');
      return;
    }
    if (_date == null || _startTime == null || _endTime == null) {
      _showSnack('Selecciona fecha, hora inicio y fin');
      return;
    }
    final cap = int.tryParse(_capacityCtrl.text.trim()) ?? 0;
    if (cap <= 0) {
      _showSnack('Cupos inválidos');
      return;
    }

    final start = _combine(_date!, _startTime!);
    final end = _combine(_date!, _endTime!);
    if (!end.isAfter(start)) {
      _showSnack('La hora fin debe ser posterior a la de inicio');
      return;
    }

    try {
      if (_editing == null) {
        await svc.createActivity(
          ngoId: 1,
          title: _titleCtrl.text.trim(),
          description: _descriptionCtrl.text.trim(),
          category: _category,
          modality: _modality,
          start: start,
          end: end,
          capacity: cap,
        );
        _showSnack('Actividad publicada');
      } else {
        await svc.updateActivity(
          activityId: _editing!.id,
          title: _titleCtrl.text.trim(),
          description: _descriptionCtrl.text.trim(),
          category: _category,
          modality: _modality,
          start: start,
          end: end,
          capacity: cap,
        );
        _showSnack('Actividad actualizada');
      }

      ref.invalidate(activitiesProvider);

      if (mounted) {
        Navigator.popUntil(
          context,
          ModalRoute.withName('/gestion-actividades'),
        );
      }
    } catch (e) {
      _showSnack('Error: $e');
    }
  }

  void _showSnack(String m) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));
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
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: theme.appBarTheme.foregroundColor,
          ),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        centerTitle: true,
        title: Text(
          _editing == null ? 'Publicar actividad' : 'Editar actividad',
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: theme.colorScheme.surface,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label(context, 'Título'),
                  TextField(
                    controller: _titleCtrl,
                    decoration: _deco(
                      context,
                      'Ej. Jornada de Reforestación',
                      icon: Icons.title_rounded,
                    ),
                  ),
                  const SizedBox(height: 14),

                  _label(context, 'Fecha'),
                  TextField(
                    readOnly: true,
                    onTap: _pickDate,
                    decoration: _deco(
                      context,
                      _date == null
                          ? 'Seleccionar fecha'
                          : '${_date!.day.toString().padLeft(2, '0')}/${_date!.month.toString().padLeft(2, '0')}/${_date!.year}',
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
                            _label(context, 'Inicio'),
                            TextField(
                              readOnly: true,
                              onTap: _pickStartTime,
                              decoration: _deco(
                                context,
                                _startTime == null
                                    ? '10:00 AM'
                                    : _startTime!.format(context),
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
                            _label(context, 'Fin'),
                            TextField(
                              readOnly: true,
                              onTap: _pickEndTime,
                              decoration: _deco(
                                context,
                                _endTime == null
                                    ? '12:00 PM'
                                    : _endTime!.format(context),
                                icon: Icons.schedule_rounded,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  _label(context, 'Ubicación'),
                  TextField(
                    controller: _locationCtrl,
                    decoration: _deco(
                      context,
                      'Ej. Parque Central, San Salvador',
                      icon: Icons.place_rounded,
                    ),
                  ),
                  const SizedBox(height: 14),

                  _label(context, 'Categoría'),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _ChipToggle(
                        text: 'Ambiental',
                        selected: _category == 'Ambiental',
                        onTap: () => setState(() => _category = 'Ambiental'),
                      ),
                      _ChipToggle(
                        text: 'Educación',
                        selected: _category == 'Educación',
                        onTap: () => setState(() => _category = 'Educación'),
                      ),
                      _ChipToggle(
                        text: 'Salud',
                        selected: _category == 'Salud',
                        onTap: () => setState(() => _category = 'Salud'),
                      ),
                      _ChipToggle(
                        text: 'Comunidad',
                        selected: _category == 'Comunidad',
                        onTap: () => setState(() => _category = 'Comunidad'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _label(context, 'Cupos'),
                            TextField(
                              controller: _capacityCtrl,
                              keyboardType: TextInputType.number,
                              decoration: _deco(
                                context,
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
                            _label(context, 'Duración (horas)'),
                            TextField(
                              controller: _durationHoursCtrl,
                              keyboardType: TextInputType.number,
                              decoration: _deco(
                                context,
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

                  _label(context, 'Requisitos'),
                  TextField(
                    controller: _requirementsCtrl,
                    maxLines: 3,
                    decoration: _deco(
                      context,
                      'Ej. Mayor de 18, ropa cómoda, etc.',
                    ),
                  ),
                  const SizedBox(height: 14),

                  _label(context, 'Descripción'),
                  TextField(
                    controller: _descriptionCtrl,
                    maxLines: 5,
                    decoration: _deco(
                      context,
                      'Describe la actividad, tareas y objetivos',
                    ),
                  ),
                  const SizedBox(height: 16),

                  _label(context, 'Imagen (opcional)'),
                  const _UploadMock(),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _submit,
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                _editing == null ? 'Publicar' : 'Guardar cambios',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
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
            icon: Icon(Icons.event_note),
            label: "Actividades",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }

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
}

class _ChipToggle extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;
  const _ChipToggle({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
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
            color: selected
                ? AppTheme.primaryColor
                : theme.colorScheme.onSurface,
          ),
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
      onTap: () {},
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
            Icon(
              Icons.cloud_upload_rounded,
              size: 28,
              color: theme.iconTheme.color,
            ),
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
