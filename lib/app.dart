import 'package:flutter/material.dart';
import 'package:val_graphics_mobile_app/screens/splash_screen.dart';

import 'db/constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: primaryColor),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(primary: primaryColor),
        useMaterial3: true,
      ),
      // themeMode: ThemeMode.system, // 🔹 follow system setting (light/dark)
      themeMode: ThemeMode.light, // 🔹 follow system setting (light/dark)
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
