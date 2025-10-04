import 'package:flutter/material.dart';

import '../db/constants.dart';
import '../db/services_data.dart';
import '../widgets/service_card.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: deviceHeight * 0.035),

          // 🔹 Section Title
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black, // default color for rest
              ),
              children: [
                TextSpan(
                  text: "Explore ",
                  style: TextStyle(
                    color: primaryColor2, // 🔹 only "Explore" in primary color
                  ),
                ),
                const TextSpan(text: "Our Main Services"),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // 🔹 Services List
          Expanded(
            child: ListView.builder(
              itemCount: servicesList.length,
              itemBuilder: (context, index) {
                final item = servicesList[index];
                return ServiceCard(service: item);
              },
            ),
          ),
        ],
      ),
    );
  }
}
