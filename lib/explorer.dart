import 'package:flutter/material.dart';
import 'opportunity_card.dart'; // Importa el componente

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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Explorar",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.black),
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
                prefixIcon: const Icon(Icons.search),
                hintText: "Buscar oportunidades",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                FilterChip(label: const Text("Área de interés"), onSelected: (_) {}),
                const SizedBox(width: 8),
                FilterChip(label: const Text("Modalidad"), onSelected: (_) {}),
                const SizedBox(width: 8),
                FilterChip(label: const Text("Fecha"), onSelected: (_) {}),
                const SizedBox(width: 8),
                FilterChip(label: const Text("Ubicación"), onSelected: (_) {}),
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
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFF2780D),
        unselectedItemColor: Colors.grey,
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
