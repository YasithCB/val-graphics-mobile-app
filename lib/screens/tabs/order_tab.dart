import 'package:flutter/material.dart';
import 'package:val_graphics_mobile_app/db/constants.dart';
import 'package:val_graphics_mobile_app/screens/view_all_services_screen.dart';
import 'package:val_graphics_mobile_app/util/navigation_util.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 🎯 Modern Icon
          Icon(
            Icons.shopping_bag_outlined,
            size: 100,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 24),

          // ✨ Title
          const Text(
            "Nothing Here Yet",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 8),

          // 📝 Subtitle
          const Text(
            "Looks like you haven’t placed any orders yet.\nStart exploring to find what you need!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),

          const SizedBox(height: 32),

          // 🚀 Call-to-action Button
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: primaryColor,
            ),
            onPressed: () {
              // Navigate somewhere useful
              NavigationUtil.push(context, ViewAllServices());
            },
            icon: const Icon(Icons.search, size: 20, color: Colors.white),
            label: const Text(
              "Explore Now",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
