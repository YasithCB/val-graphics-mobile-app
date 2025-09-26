import 'package:flutter/material.dart';
import 'package:val_graphics_mobile_app/db/services_data.dart';

import '../../screens/service_details_screen.dart';

class HorizontalImageGrid extends StatelessWidget {
  const HorizontalImageGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160, // enough space for image + title
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: servicesList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // only one row
          mainAxisSpacing: 0,
        ),
        itemBuilder: (context, index) {
          final item = servicesList[index];
          return InkWell(
            onTap: () {
              // 🔹 Navigate to Service Details
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ServiceDetailsScreen(service: item),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    item.image,
                    fit: BoxFit.cover,
                    height: 100,
                    width: 140,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
