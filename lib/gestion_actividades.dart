import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'theme/app_theme.dart';
import 'services/activities_service.dart';

class GestionActividadesScreen extends ConsumerStatefulWidget {
  const GestionActividadesScreen({super.key});

  @override
  ConsumerState<GestionActividadesScreen> createState() =>
      _GestionActividadesScreenState();
}

class _GestionActividadesScreenState
    extends ConsumerState<GestionActividadesScreen>
    with SingleTickerProviderStateMixin {
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

  // ==== UTIL ====
  Future<void> _refreshTab(WidgetRef ref, String status) async {
    final args = (
      ngoId: 1,
      status: status,
      page: 1,
      limit: 10,
      q: null as String?,
    );
    await ref.refresh(activitiesProvider(args).future);
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
          'Actividades',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.appBarTheme.foregroundColor,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            height: 48,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tabs,
              indicatorColor: AppTheme.primaryColor,
              labelColor: AppTheme.primaryColor,
              unselectedLabelColor: theme.textTheme.bodySmall?.color,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
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
          _ActivitiesTab(
            status: 'open',

            primaryLabel: 'Cerrar inscripciones',
            primaryEnabled: (a) => a.status == 'open',
            onPrimary: (context, ref, a) async {
              await ref
                  .read(activitiesServiceProvider)
                  .closeActivity(activityId: a.id);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Inscripciones cerradas')),
                );
              }
              await _refreshTab(ref, 'open');
              await _refreshTab(ref, 'closed');
              _tabs.animateTo(1);
            },
          ),

          _ActivitiesTab(
            status: 'closed',

            primaryLabel: 'Terminar',
            primaryEnabled: (a) => a.status == 'closed',
            onPrimary: (context, ref, a) async {
              await ref
                  .read(activitiesServiceProvider)
                  .completeActivity(activityId: a.id);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Actividad terminada')),
                );
              }
              await _refreshTab(ref, 'closed');
              await _refreshTab(ref, 'completed');
              _tabs.animateTo(2);
            },
          ),

          _ActivitiesTab(
            status: 'completed',
            primaryLabel: 'Completada',
            primaryEnabled: (a) => false,
            onPrimary: (context, ref, a) async {},
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/publicar-actividad'),
        tooltip: 'Añadir actividad',
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: theme.bottomNavigationBarTheme.unselectedItemColor,
        backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            label: "Actividades",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: "Voluntarios",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}

class _ActivitiesTab extends ConsumerWidget {
  const _ActivitiesTab({
    required this.status,
    required this.primaryLabel,
    required this.primaryEnabled,
    required this.onPrimary,
  });

  final String status;
  final String primaryLabel;
  final bool Function(Activity) primaryEnabled;
  final Future<void> Function(BuildContext, WidgetRef, Activity) onPrimary;

  String _formatDateRange(DateTime start, DateTime end) {
    String two(int n) => n.toString().padLeft(2, '0');
    String hm(DateTime d) {
      final h = d.hour % 12 == 0 ? 12 : d.hour % 12;
      final m = two(d.minute);
      final ampm = d.hour >= 12 ? 'PM' : 'AM';
      return '$h:$m $ampm';
    }

    final s = start.toLocal();
    final e = end.toLocal();
    return '${two(s.day)}/${two(s.month)} ${hm(s)} – ${hm(e)}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = (
      ngoId: 1,
      status: status,
      page: 1,
      limit: 10,
      q: null as String?,
    );
    final async = ref.watch(activitiesProvider(args));

    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => _ErrorHint(
        message: 'No se pudieron cargar las actividades',
        detail: e.toString(),
        onRetry: () async => ref.refresh(activitiesProvider(args).future),
      ),
      data: (items) {
        if (items.isEmpty) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
            children: [
              _EmptyHint(
                icon: status == 'completed'
                    ? Icons.check_circle_outline_rounded
                    : (status == 'closed'
                          ? Icons.photo_camera_outlined
                          : Icons.pending_actions_rounded),
                text: status == 'completed'
                    ? 'No hay actividades completadas.'
                    : (status == 'closed'
                          ? 'No hay actividades en curso.'
                          : 'No hay actividades próximas.'),
              ),
            ],
          );
        }

        return RefreshIndicator(
          onRefresh: () async => ref.refresh(activitiesProvider(args).future),
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, i) {
              final a = items[i];

              return _ActivityCard(
                title: a.title,
                dateText: _formatDateRange(a.start, a.end),
                imageUrl: null,
                closed: a.status != 'open',
                primaryLabel: primaryLabel,
                primaryEnabled: primaryEnabled(a),
                onPrimary: () => onPrimary(context, ref, a),
                onEdit: () => Navigator.pushNamed(
                  context,
                  '/publicar-actividad',
                  arguments: a,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final String title;
  final String dateText;
  final String? imageUrl;
  final bool closed;
  final String primaryLabel;
  final bool primaryEnabled;
  final VoidCallback onEdit;
  final VoidCallback onPrimary;

  const _ActivityCard({
    required this.title,
    required this.dateText,
    this.imageUrl,
    required this.closed,
    required this.primaryLabel,
    required this.primaryEnabled,
    required this.onEdit,
    required this.onPrimary,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: theme.colorScheme.surface,
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
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dateText,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodySmall?.color,
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
                _SecondaryButton(label: 'Editar', onPressed: onEdit),
                const SizedBox(width: 10),
                Expanded(
                  child: _PrimaryButton(
                    label: primaryLabel,
                    onPressed: primaryEnabled ? onPrimary : null,
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
    final theme = Theme.of(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: 60,
        height: 60,
        child: imageUrl == null
            ? Container(
                color: theme.colorScheme.surface,
                child: Icon(
                  Icons.image,
                  color: theme.textTheme.bodySmall?.color,
                ),
              )
            : Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: theme.colorScheme.surface,
                  child: Icon(
                    Icons.broken_image_rounded,
                    color: theme.textTheme.bodySmall?.color,
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
    final theme = Theme.of(context);
    return FilledButton.tonal(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
        foregroundColor: theme.textTheme.bodySmall?.color,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
      child: Text(label),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const _PrimaryButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        disabledBackgroundColor: AppTheme.primaryColor.withOpacity(0.25),
        disabledForegroundColor: Colors.white,
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
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 36),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Icon(icon, size: 36, color: theme.textTheme.bodySmall?.color),
          const SizedBox(height: 10),
          Text(
            text,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.textTheme.bodySmall?.color,
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorHint extends StatelessWidget {
  const _ErrorHint({
    required this.message,
    required this.detail,
    required this.onRetry,
  });

  final String message;
  final String detail;
  final Future<void> Function() onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.wifi_off_rounded,
              size: 42,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              detail,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => onRetry(),
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
