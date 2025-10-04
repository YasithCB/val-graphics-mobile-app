import 'package:flutter/material.dart';
import 'package:val_graphics_mobile_app/db/constants.dart';

import '../../app.dart'; // adjust import for MyApp

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Locale>(
          value: currentLocale,
          icon: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Icon(Icons.language_rounded, color: Colors.white),
          ),
          borderRadius: BorderRadius.circular(12),
          dropdownColor: Colors.black,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          items: const [
            DropdownMenuItem(value: Locale('en'), child: Text("English")),
            DropdownMenuItem(value: Locale('ar'), child: Text("العربية")),
          ],
          onChanged: (Locale? locale) {
            if (locale != null) {
              MyApp.setLocale(context, locale);
            }
          },
        ),
      ),
    );
  }
}
