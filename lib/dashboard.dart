import 'package:flutter/material.dart';
import 'widgets/activity_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 3; // Dashboard por defecto

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
      backgroundColor: const Color(0xFFF8F7F5),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: const Color(0xFFF8F7F5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF221810)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                "https://lh3.googleusercontent.com/aida-public/AB6AXuBzldjPsfH3bdatcAlaq4TImLRMz35YSfPHysc2sSP_Pb7a0up9EkIDELW0W1NSlJn32wyQaudJF8LUP7Kv7YVKowObvlCkXxUvD25FOpM0DAfzay7ed0Sub7Oxc-rIv4VVJa4Aa_N9cnr2DwbiEiLZt-4RXMkL8DO5HdfwFHdaqmu-Hn6XaN9Kl1a2UTG6qu2QYI3Dm3nqkejUTmJzL_bTG940XDmQhi1feOdgibqX5u_xU6XdQDjOublYLifP4IPVZGeAbRWXgpI",
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              "Mi Dashboard",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF221810),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            color: const Color(0xFF221810),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2780D).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Horas Acumuladas",
                          style: TextStyle(
                            color: Color(0xFFF2780D),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "120",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF221810),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2780D).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Horas Pendientes",
                          style: TextStyle(
                            color: Color(0xFFF2780D),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "30",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF221810),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              "Próximas Actividades",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF221810),
              ),
            ),
            const SizedBox(height: 12),
            const ActivityCard(
              title: "Limpieza de Parque",
              date: "20 de Julio, 2024",
              imageUrl:
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuBaW3JL5XHDaSCMg6yTCIoW0HSVuUJAlHmDJ92BX1AxDpaRCGsBS9vqWjAiCdOrPV1-ApsLznzOdYKV6hbdwI9RjEerwxnT4SKXTpH9P7eP-2GwmKw2a4unpGUDQG3MsKqF99dHgEc__I8ZrZZy_g5bKgqhVogBYjtp7XZCJdo1x-LDJcrBH5MUU1qeNeZDQS_lEuAKlr80q2YAsvbqRgIYDT1GCRNZFY-gysPqnoY_m3eBZqo89rjW0DHktw7ak-cq9x5ofhR_x0o",
            ),
            const ActivityCard(
              title: "Tutoría de Niños",
              date: "25 de Julio, 2024",
              imageUrl:
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuAEDBmwfjgPDOfBgYQeoYyiHOvPSpaCcG9EHu9ojxzP-z7T0-qD_6x9hYKbRmKbyI4VhJDiv5o9ulX6bZPg9myxAd6DScqJE1l2x8TElr4x7fz-M6SZhT1_ANXSVQtHgCGbwbqba75HnA736ybLV3u8Hxeg7jYDyuVBsxvCg6jRNGObQ5LdocX9E0IOy6Axf0lpB4iu2WQXgK3D4sCSO-tHqJ7-low2FqGjOBRPzUVXleSpwvcTwbOxRqHGCyae4qFBIGO91CeQ65Y",
            ),
            const SizedBox(height: 24),
            const Text(
              "Actividades Recomendadas",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF221810),
              ),
            ),
            const SizedBox(height: 12),
            const ActivityCard(
              title: "Construcción de Viviendas",
              date: "15 de Agosto, 2024",
              imageUrl:
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuDGEaiPawM6x5ImxvQGF-6GWVrJnAtkV_A3IfJhev0fgyHV2ztj786oSZdLOdW1EjwKsReuTGZB_J91O_mN8AWMiaz8t4atzZqZNUabtIiROBDV9Vnd46yl1Y85osTKdSE9osvbPRLO8uPw8FXk4QCq3NF65GOnl1QgzQvgZLLMBHOOz4_BeFGRnH0wiy0jkH18v62KJQCwwvoNcED36CqVOKAKoOZFFp9AafwzU0lMkzquFgyRg9Merz0h866q27XDeXYLdiwaFUg",
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFF2780D),
        unselectedItemColor: Colors.black.withOpacity(0.5),
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explorar"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: "Actividades"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}
