import 'package:flutter/material.dart';

import '../app.dart';
import '../db/constants.dart';

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({super.key});

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  Locale _selectedLocale = const Locale('en');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get current app language
    _selectedLocale = Localizations.localeOf(context);
  }

  void _changeLanguage(Locale locale) {
    setState(() {
      _selectedLocale = locale;
    });
    MyApp.setLocale(context, locale);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Language Settings"),
        backgroundColor: primaryColor,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            "Choose your preferred language",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 20),

          // English option
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: RadioListTile<Locale>(
              value: const Locale('en'),
              groupValue: _selectedLocale,
              activeColor: primaryColor,
              title: Row(
                children: [
                  Icon(Icons.language_outlined, color: primaryColor),
                  SizedBox(width: 10),
                  Text("English", style: TextStyle(fontSize: 16)),
                ],
              ),
              onChanged: (Locale? locale) {
                if (locale != null) _changeLanguage(locale);
              },
            ),
          ),

          const SizedBox(height: 10),

          // Arabic option
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: RadioListTile<Locale>(
              value: const Locale('ar'),
              groupValue: _selectedLocale,
              activeColor: primaryColor,
              title: Row(
                children: [
                  Icon(Icons.translate_rounded, color: primaryColor),
                  SizedBox(width: 10),
                  Text("العربية", style: TextStyle(fontSize: 16)),
                ],
              ),
              onChanged: (Locale? locale) {
                if (locale != null) _changeLanguage(locale);
              },
            ),
          ),
        ],
      ),
    );
  }
}
