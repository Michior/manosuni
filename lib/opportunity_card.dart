import 'package:flutter/material.dart';
import 'opportunity_details.dart';

class OpportunityCard extends StatelessWidget {
  final String title;
  final String organization;
  final String places;
  final String date;
  final String type;
  final String imageUrl;

  const OpportunityCard({
    super.key,
    required this.title,
    required this.organization,
    required this.places,
    required this.date,
    required this.type,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OpportunityDetails(
              title: title,
              description:
                  "Participa en la actividad de voluntariado y contribuye a la comunidad. ¡Haz la diferencia!",
              requirements:
                  "No se requieren habilidades especiales, solo entusiasmo y ganas de colaborar.",
              duration: "4 horas",
              organizationName: organization,
              organizationSubtitle: "ONG asociada",
              imageUrl: imageUrl,
              orgLogoUrl: "https://picsum.photos/50/50",
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        margin: const EdgeInsets.only(bottom: 12),
        child: Column(
          children: [
            ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(organization),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    places.split(" ")[0],
                    style: const TextStyle(
                        color: Color(0xFFF2780D), fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "lugares",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(date,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  Text(type,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
