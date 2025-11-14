import 'package:flutter/material.dart';

class FeatureGrid extends StatelessWidget {
  const FeatureGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {'title': 'Pest Prediction', 'icon': Icons.bug_report_outlined, 'color': Colors.teal},
      {'title': 'Yield Prediction', 'icon': Icons.show_chart_rounded, 'color': Colors.orange},
      {'title': 'Micronutrient', 'icon': Icons.biotech_rounded, 'color': Colors.purple},
      {'title': 'Alerts', 'icon': Icons.notifications_active_outlined, 'color': Colors.redAccent},
      {'title': 'AR View', 'icon': Icons.view_in_ar_outlined, 'color': Colors.indigo},
      {'title': 'Explainability', 'icon': Icons.psychology_alt_outlined, 'color': Colors.brown},
      {'title': 'Profile', 'icon': Icons.person_outline_rounded, 'color': Colors.green},
      {'title': 'Community', 'icon': Icons.groups_2_outlined, 'color': Colors.blueGrey},
      {'title': 'Agro Credits', 'icon': Icons.monetization_on_outlined, 'color': Colors.amber},
    ];

    return GridView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.78,
      ),
      itemBuilder: (_, i) {
        final it = items[i];

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: it['color'].withOpacity(0.3), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: it['color'].withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(2, 4),
                  )
                ],
              ),
              child: Icon(it['icon'], size: 32, color: it['color']),
            ),
            const SizedBox(height: 6),
            Text(
              it['title'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        );
      },
    );
  }
}
