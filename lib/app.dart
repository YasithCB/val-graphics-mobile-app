import 'package:flutter/material.dart';
import 'package:val_graphics_mobile_app/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFE81564);

    return MaterialApp(
      title: 'VAL Graphics',
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
