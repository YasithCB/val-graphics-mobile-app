import 'package:flutter/material.dart';

import '../db/constants.dart';
import '../db/services_data.dart';
import '../l10n/app_localizations.dart';
import '../widgets/service_card.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final servicesList = getServicesList(
      Localizations.localeOf(context).languageCode,
    );
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: deviceHeight * 0.03),

          // 🔹 Section Title
          Text(
            AppLocalizations.of(context)!.exploreOurMainServices,
            style: TextStyle(
              color: primaryColor,
              fontSize: 19,
              fontWeight: FontWeight.bold,
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
