import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ImpactReportsScreen extends StatelessWidget {
  const ImpactReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Impact Reports"),
        backgroundColor: const Color(0xFFF1780F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Tarjeta de Total Hours Contributed
            _buildStatCard(
              title: "Total Hours Contributed",
              value: "1,250 hrs",
              color: Colors.blue,
            ),

            const SizedBox(height: 16),

            // Tarjeta de Recurring Volunteers
            _buildStatCard(
              title: "Recurring Volunteers",
              value: "65%",
              color: Colors.green,
            ),

            const SizedBox(height: 16),

            // Gráfica Circular: Distribución de Impacto
            const Text(
              "Impact Distribution",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 200, child: _ImpactPieChart()),

            const SizedBox(height: 16),

            // Gráfica de barras: Volunteer Hours por mes
            const Text(
              "Volunteer Hours per Month",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 200, child: _ImpactBarChart()),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            Text(value,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color)),
          ],
        ),
      ),
    );
  }
}

// Gráfica circular
class _ImpactPieChart extends StatelessWidget {
  const _ImpactPieChart();

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: 40,
            title: "Education",
            color: Colors.blue,
            radius: 50,
          ),
          PieChartSectionData(
            value: 30,
            title: "Environment",
            color: Colors.green,
            radius: 50,
          ),
          PieChartSectionData(
            value: 20,
            title: "Health",
            color: Colors.orange,
            radius: 50,
          ),
          PieChartSectionData(
            value: 10,
            title: "Other",
            color: Colors.purple,
            radius: 50,
          ),
        ],
        sectionsSpace: 2,
        centerSpaceRadius: 30,
      ),
    );
  }
}

// Gráfica de barras
class _ImpactBarChart extends StatelessWidget {
  const _ImpactBarChart();

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: [
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(toY: 100, color: Colors.blue),
          ]),
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(toY: 80, color: Colors.green),
          ]),
          BarChartGroupData(x: 2, barRods: [
            BarChartRodData(toY: 120, color: Colors.orange),
          ]),
          BarChartGroupData(x: 3, barRods: [
            BarChartRodData(toY: 90, color: Colors.purple),
          ]),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 0:
                    return const Text("Jan");
                  case 1:
                    return const Text("Feb");
                  case 2:
                    return const Text("Mar");
                  case 3:
                    return const Text("Apr");
                  default:
                    return const Text("");
                }
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 28),
          ),
        ),
        borderData: FlBorderData(show: false),
      ),
    );
  }
}