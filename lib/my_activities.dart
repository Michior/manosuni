import 'package:flutter/material.dart';

class MisActividades extends StatelessWidget {
  const MisActividades({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F5), // background-light
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F7F5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Mis Actividades",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Próximas Actividades
            const Text(
              "Próximas Actividades",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(12)),
                    child: Image.network(
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuBYljBbgYwJF9F7N7RMxlfWPo6QnbAKuPh5gaZMOmm1KZ8CfDXYQ8EONjBD-KGX2Rx_eh1YrDjg0sDkYjKvWX1pvRUMTRigJ9zCnCHdeXdGeZRGAvw5n99fffIVEOKbbl_9yFNF0JEQU40Y5YkkJJwup0WvCIj1MFvbONKbSNlmkbtd1Faqu9ijvKS1P--uzou5Evrnc6W7JukUTZFhYxue6AGQvSw6152LMGeFv9-YIY3-vjcY2qMRvLyllum25clEgUQVPQKYlyc",
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Voluntariado",
                            style: TextStyle(
                                color: Color(0xFFF2780D),
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                        const SizedBox(height: 4),
                        const Text(
                          "Limpieza de la Playa",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const Text(
                          "Organizado por EcoMar",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Acción: ver detalles
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0x33F2780D),
                            foregroundColor: const Color(0xFFF2780D),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                          ),
                          child: const Text(
                            "Ver detalles",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Historial
            const Text(
              "Historial de Voluntariado",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildHistorialItem(
              "Ayuda en el Comedor Social",
              "2 horas",
              "https://lh3.googleusercontent.com/aida-public/AB6AXuCfTs-0tfzt1p-UeyHolj8rQWAU5r_6lwcMJv0c7SSreBvDfqnvCVs2_MTYotXPtICmPM0yielFucv88hzycByeb5Xs6m4GB0FtcE9KxLFVzy1A3BwBVAzMwomI3LW1vFNAYEMDUmq93JPhMDWEyWIwvMW0dftJrFcwjZwZO_TX5iDbzISpJbgmNkjsK1XFOqjiEErfaCwZfyFn2GxMwcnSulJAww6Rj57Kn_nC10U3dRr5cAwXYnUuQ7vqlO55P1WlRZz8YbEG1Lg",
            ),
            _buildHistorialItem(
              "Taller de Reciclaje",
              "3 horas",
              "https://lh3.googleusercontent.com/aida-public/AB6AXuAf4apWDjh59fk8UsmhaZWF4NhD78RFLmsHEUu_FAj7dLHJIi2PvF8lp-2wQoBZcGNGKmdCs8Y7yiw7F9y8_jWlzJs25a4wh-IoFIj7B28_zpdHeoCiwnqA9XdOOHC6_vG0WLpbZrCooml7KmtNyGRH_H6pgBhNvOX8HK9n4WzCjyNFYY4LjuuzwO-2xqfQHmMbcgf9FZzXZJXkzdlZGRegBWVhtXuZnwfARRqZ-Za30WeNyoWN8-jmn5HGv51HLtCKPJtIFTfW1RE",
            ),

            const SizedBox(height: 24),

            // Horas Validadas
            const Text(
              "Horas Validadas",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Horas de Servicio Social",
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Text("15/20 horas",
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: 0.75,
                        color: const Color(0xFFF2780D),
                        backgroundColor: Colors.grey[300],
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2, // "Mis Actividades"
        selectedItemColor: const Color(0xFFF2780D),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explorar"),
          BottomNavigationBarItem(
              icon: Icon(Icons.event), label: "Mis Actividades"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
        onTap: (index) {
          // Aquí puedes cambiar de página
        },
      ),
    );
  }

  Widget _buildHistorialItem(String title, String subtitle, String imageUrl) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(imageUrl, width: 56, height: 56, fit: BoxFit.cover),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
