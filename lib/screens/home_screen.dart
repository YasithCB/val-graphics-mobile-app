import 'package:flutter/material.dart';
import 'package:val_graphics_mobile_app/screens/tabs/explore_tab.dart';
import 'package:val_graphics_mobile_app/screens/tabs/home_tab.dart';
import 'package:val_graphics_mobile_app/screens/tabs/order_tab.dart';
import 'package:val_graphics_mobile_app/screens/tabs/profile_tab.dart';

import '../db/constants.dart';
import '../screens/services_screen.dart';
import '../widgets/navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // default to middle Services tab

  final List<Widget> _pages = const [
    HomeTab(),
    ExploreTab(),
    ServicesScreen(),
    OrdersTab(),
    ProfileTab(),
  ];

  void _onTabSelected(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    // 📏 Get device width & height
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/logo-text-white.webp', height: 30),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      backgroundColor: Colors.white,
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: Navbar(
        currentIndex: _currentIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}
