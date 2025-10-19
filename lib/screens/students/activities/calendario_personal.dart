import 'package:flutter/material.dart';

class CalendarPersonalScreen extends StatefulWidget {
  const CalendarPersonalScreen({super.key});

  @override
  State<CalendarPersonalScreen> createState() => _CalendarPersonalScreenState();
}

class _CalendarPersonalScreenState extends State<CalendarPersonalScreen> {
  static const Color accent = Color(0xFFF39A4B);
  static const Color accentSoft = Color(0xFFFFF1E6);
  static const Color bg = Color(0xFFF6F5F2);

  DateTime _month = DateTime(2024, 5, 1);
  int? _selectedDay = 5;

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
          'Calendario',
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
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _IconPill(icon: Icons.chevron_left_rounded, onTap: () {}),
                      Text(
                        'Mayo 2024',
                        style: text.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E1E1E),
                        ),
                      ),
                      _IconPill(
                        icon: Icons.chevron_right_rounded,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      _Dow('D'),
                      _Dow('L'),
                      _Dow('M'),
                      _Dow('M'),
                      _Dow('J'),
                      _Dow('V'),
                      _Dow('S'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _MonthGrid(
                    month: _month,
                    selectedDay: _selectedDay,
                    dotDay: 12,
                    onTapDay: (d) => setState(() => _selectedDay = d),
                    accent: accent,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Actividades',
            style: text.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1E1E1E),
            ),
          ),
          const SizedBox(height: 12),
          const _ActivityTile(
            icon: Icons.event,
            iconBg: accentSoft,
            iconColor: accent,
            title: 'Limpieza de Parque',
            subtitle: '10:00 AM - 12:00 PM',
          ),
          const SizedBox(height: 12),
          const _ActivityTile(
            icon: Icons.search_rounded,
            iconBg: accentSoft,
            iconColor: accent,
            title: 'Tutoría de Niños',
            subtitle: '2:00 PM - 4:00 PM',
          ),
          const SizedBox(height: 24),
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

class _IconPill extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _IconPill({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: const Color(0xFF585858)),
      ),
    );
  }
}

class _Dow extends StatelessWidget {
  final String label;
  const _Dow(this.label);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      child: Center(
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: const Color(0xFF9AA0A6),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _MonthGrid extends StatelessWidget {
  final DateTime month;
  final int? selectedDay;
  final int? dotDay;
  final void Function(int day) onTapDay;
  final Color accent;

  const _MonthGrid({
    required this.month,
    required this.selectedDay,
    required this.dotDay,
    required this.onTapDay,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    final year = month.year;
    final m = month.month;
    final daysInMonth = DateUtils.getDaysInMonth(year, m);
    final firstWeekday = DateTime(year, m, 1).weekday; 
    final leadingBlanks = firstWeekday % 7; 

    final totalCells = leadingBlanks + daysInMonth;
    final rows = (totalCells / 7).ceil();

    return Column(
      children: List.generate(rows, (row) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (col) {
              final idx = row * 7 + col;
              final dayNum = idx - leadingBlanks + 1;
              if (dayNum < 1 || dayNum > daysInMonth) {
                return const SizedBox(width: 40, height: 40);
              }
              final isSelected = dayNum == selectedDay;
              return _DayCell(
                day: dayNum,
                selected: isSelected,
                hasDot: dotDay == dayNum,
                accent: accent,
                onTap: () => onTapDay(dayNum),
              );
            }),
          ),
        );
      }),
    );
  }
}

class _DayCell extends StatelessWidget {
  final int day;
  final bool selected;
  final bool hasDot;
  final Color accent;
  final VoidCallback onTap;

  const _DayCell({
    required this.day,
    required this.selected,
    required this.hasDot,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final circle = Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: selected ? accent : Colors.transparent,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        '$day',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: selected ? Colors.white : const Color(0xFF2A2A2A),
          fontWeight: FontWeight.w700,
        ),
      ),
    );

    final dot = hasDot
        ? Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: selected ? Colors.white : accent,
                shape: BoxShape.circle,
              ),
            ),
          )
        : const SizedBox(height: 8);

    return SizedBox(
      width: 40,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Column(mainAxisSize: MainAxisSize.min, children: [circle, dot]),
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _ActivityTile({
    required this.icon,
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
