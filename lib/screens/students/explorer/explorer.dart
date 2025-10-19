import 'package:flutter/material.dart';
import '../../../core/widgets/opportunity_card.dart';
import '../../../core/theme/app_theme.dart'; // Asegúrate de importar tu AppTheme

class Explorer extends StatefulWidget {
  const Explorer({super.key});

  @override
  State<Explorer> createState() => _ExplorerState();
}

class _ExplorerState extends State<Explorer> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/explorer');
        break;
      case 2:
        Navigator.pushNamed(context, '/activities');
        break;
      case 3:
        Navigator.pushNamed(context, '/dashboard');
        break;
      case 4:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Explorar",
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.appBarTheme.foregroundColor,
          ),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        toolbarHeight: 80,
        elevation: 1,
        actions: [
          IconButton(
            icon: Icon(Icons.tune, color: theme.appBarTheme.foregroundColor),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: theme.primaryColor),
                hintText: "Buscar oportunidades",
                hintStyle: TextStyle(
                  color: theme.appBarTheme.foregroundColor?.withOpacity(0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: theme.scaffoldBackgroundColor.withOpacity(0.05),
              ),
            ),
          ),
          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                FilterChip(
                  label: const Text("Área de interés"),
                  onSelected: (_) {},
                  selectedColor: theme.primaryColor.withOpacity(0.2),
                  backgroundColor: theme.scaffoldBackgroundColor.withOpacity(0.05),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text("Modalidad"),
                  onSelected: (_) {},
                  selectedColor: theme.primaryColor.withOpacity(0.2),
                  backgroundColor: theme.scaffoldBackgroundColor.withOpacity(0.05),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text("Fecha"),
                  onSelected: (_) {},
                  selectedColor: theme.primaryColor.withOpacity(0.2),
                  backgroundColor: theme.scaffoldBackgroundColor.withOpacity(0.05),
                ),
                const SizedBox(width: 8),
                FilterChip(
                  label: const Text("Ubicación"),
                  onSelected: (_) {},
                  selectedColor: theme.primaryColor.withOpacity(0.2),
                  backgroundColor: theme.scaffoldBackgroundColor.withOpacity(0.05),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: const [
                OpportunityCard(
                  title: "Apoyo en comedor comunitario",
                  organization: "ONG Esperanza",
                  places: "20 lugares",
                  date: "Sáb, 25 de Mayo",
                  type: "Presencial",
                  imageUrl: "https://picsum.photos/100/100",
                ),
                OpportunityCard(
                  title: "Tutorías para niños",
                  organization: "Fundación Futuro",
                  places: "15 lugares",
                  date: "Dom, 26 de Mayo",
                  type: "Remoto",
                  imageUrl: "https://picsum.photos/101/101",
                ),
                OpportunityCard(
                  title: "Plantación de árboles",
                  organization: "Asociación Verde",
                  places: "25 lugares",
                  date: "Sáb, 1 de Junio",
                  type: "Presencial",
                  imageUrl: "https://picsum.photos/102/102",
                ),
                OpportunityCard(
                  title: "Limpieza de playas",
                  organization: "Activate",
                  places: "15 lugares",
                  date: "Dom, 26 de Mayo",
                  type: "Presencial",
                  imageUrl: "https://picsum.photos/101/101",
                ),
                OpportunityCard(
                  title: "Creación de formularios",
                  organization: "Fundación Futuro",
                  places: "15 lugares",
                  date: "Dom, 26 de Mayo",
                  type: "Remoto",
                  imageUrl: "https://picsum.photos/101/101",
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: theme.primaryColor,
        unselectedItemColor: theme.appBarTheme.foregroundColor?.withOpacity(0.6),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explorar"),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: "Actividades"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}
