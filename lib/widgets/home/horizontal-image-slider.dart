import 'package:flutter/material.dart';
import 'package:val_graphics_mobile_app/db/services_data.dart';
import 'package:val_graphics_mobile_app/util/navigation_util.dart';

import '../../screens/sub_service_details_screen.dart';

class HorizontalImageGrid extends StatelessWidget {
  const HorizontalImageGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final popularServices = getPopularServices(
      Localizations.localeOf(context).languageCode,
    );

    return SizedBox(
      height: 160, // enough space for image + title
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: popularServices.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // only one row
          mainAxisSpacing: 0,
        ),
        itemBuilder: (context, index) {
          final item = popularServices[index];
          return InkWell(
            onTap: () {
              // 🔹 Navigate to Service Details
              NavigationUtil.push(
                context,
                SubServiceDetailsScreen(service: item),
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
                    width: 150,
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
