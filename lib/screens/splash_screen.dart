import 'package:flutter/material.dart';
import 'package:val_graphics_mobile_app/db/constants.dart';
import 'package:val_graphics_mobile_app/util/navigation_util.dart';
import 'package:val_graphics_mobile_app/util/storage_util.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _checkUserData();

    // 🔹 Setup animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // fade duration
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  Future<void> _checkUserData() async {
    currentUser = await StorageUtil.getUser() ?? {};

    print('::::::::::::::::::: USER :::::::::::::::::::');
    print(currentUser);

    await Future.delayed(const Duration(seconds: 2)); // splash delay

    NavigationUtil.pushReplacement(context, HomeScreen());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SizedBox(
            height: 160,
            width: 160,
            child: Image.asset("assets/logo-white.webp"),
          ),
        ),
      ),
    );
  }
}
