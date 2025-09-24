import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

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
      themeMode: ThemeMode.dark, // 🔹 follow system setting (light/dark)
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }

}
