import 'package:flutter/material.dart';

import '../db/services_data.dart';
import '../models/service_item.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: SERVICES.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 per row
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1, // adjust card height
          ),
          itemBuilder: (context, i) {
            final service = SERVICES[i];
            return _ServiceCard(service: service);
          },
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final ServiceItem service;

  const _ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Open ${service.title}')));
      },
      borderRadius: BorderRadius.circular(16),
      child: Card(
        color: const Color(0xFFE81564), // 🔹 pink background for the card
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        clipBehavior:
            Clip.antiAlias, // ensures children respect rounded corners
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 📷 Image on top
            Expanded(child: Image.asset(service.imagePath, fit: BoxFit.cover)),

            // 🏷 Title bar at bottom
            Container(
              color: const Color(0xFFE81564), // 🔹 pink bar background
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Text(
                service.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white, // 🔹 white text for contrast
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
