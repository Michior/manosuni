import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  int _selectedIndex = 4; // Perfil

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
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        title: Text(
          "Perfil",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: theme.appBarTheme.foregroundColor,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: theme.appBarTheme.foregroundColor),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Foto y datos de usuario
            Column(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.primaryColor, width: 4),
                    image: const DecorationImage(
                      image: NetworkImage(
                        "https://lh3.googleusercontent.com/aida-public/AB6AXuAdpMdmbEJbaZR0GA0iK4GAdMv6ISavUdWxcZwmosDYFsRis_jgPR93gC9Zfl_KoYqVPq8c414xPu4mC0Z7CGpv1my_7TMfKrRschhHSu_i3p3pJgAdYNFakFSlKDWFAIYdvH_57Yvzp01r4k7TZsVsjU3OplHt7pqgQR6rqCEdOa6Dkvp8jrrIeo2jP_S39-fvZqrplhN3kB4Nj8ovS2A9xjWIt4ELFV7DOue3aoeWBbSeHqWlkDgnHUiZ0o2DIEhemciNE2aKi2Y",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Daniel Ramirez",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyLarge?.color),
                ),
                Text(
                  "Estudiante de Ingeniería",
                  style: TextStyle(color: theme.textTheme.bodySmall?.color),
                ),
                Text(
                  "Universidad de Monterrey",
                  style: TextStyle(color: theme.textTheme.bodySmall?.color),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Métricas
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMetric("120", "Horas Sociales", theme),
                _buildMetric("5", "Proyectos", theme),
                _buildMetric("3", "Insignias", theme),
              ],
            ),
            const SizedBox(height: 24),

            // Logros
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Logros",
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildAchievement("https://lh3.googleusercontent.com/aida-public/AB6AXuAOahuVRLgGIksbzd1Jr4QLzoQ_fn4wD4nscacsDAQ8LcFqjTlhLBUXhjt5gkoxCoQX66_sLOnaB-1HXnbDZTE4nSQXasJ0EnQ7KO-hqLM1D44SZR7J9XBbT8DuAUPru-Y03s30NnL3MRUnXqfKdkfr3sf2_OwRkva97kHWTUoadooSsmnXMWr1XrHltsRLK_BoJN6Al_bK7WaONf-sNmg5z3SBx-x-XSlcwwmZYtH2J6AZgXAu0D_IOaiy_L3e5CpTah7qfJjF0LE"),
                _buildAchievement("https://lh3.googleusercontent.com/aida-public/AB6AXuDAgTne4Rgbicss1j4H8XarCge6jtQUlPtJSDOmTbMSOG9Qy4E_gvgxr87ejQKgeDdQUPdb3-yQj-CxcTKyQu0160CR9Jz6WPVevAtpBTga31G1yDC3lEp2L8_G-ROxXcf25LiIPV_n2BcxxmqeYxrV14ZNbBEFXqlTIjN9w0TKBCs-VLrJ_RIivbyaMUNganI10uCFKCJI25fVoeGBoWdID77sjJxf46tmng-zTN7Dc_exMD4mJkFizhRAmgZ_Q5C3HefYQh3dlBQ"),
                _buildAchievement("https://lh3.googleusercontent.com/aida-public/AB6AXuCc6hqI-NYk3paYE-6HSfGRWFuFeZmuVPkwRdau1hP7_d6XYz3ka_M_jzZK2UgEClSEP74PnXaaIEhXjDptpjTeFYoGWo3SElaMDRnKKHg-fxNfKx-3IhU02qhIbg3_GkudHkphyUYvYUx_YWtxKc3xt31pB4YbfzjqG5aCgiJieUoSBgXI0DVxdRyAmUx7q5AOeyN2C5I4uIM91Yr38EUE-Ia1f7vDCEmpGLMjwLc3zq6can53Ci3UmUU9N3itDiEz0G-6hrUSnN8"),
              ],
            ),
            const SizedBox(height: 24),

            // Portafolio
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Portafolio",
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: AppTheme.primaryColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(12),
                  color: theme.scaffoldBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Descargar Portafolio",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: theme.textTheme.bodyLarge?.color),
                    ),
                    const Icon(Icons.download, color: AppTheme.primaryColor),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: theme.bottomNavigationBarTheme.unselectedItemColor,
        backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
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

  Widget _buildMetric(String value, String label, ThemeData theme) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: theme.textTheme.bodySmall?.color, fontSize: 12)),
      ],
    );
  }

  Widget _buildAchievement(String imageUrl) {
    return Container(
      height: 90,
      width: 90,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
      ),
    );
  }
}
