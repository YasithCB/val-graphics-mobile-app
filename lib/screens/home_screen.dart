import 'package:flutter/material.dart';
import 'package:val_graphics_mobile_app/screens/explore_tab.dart';
import 'package:val_graphics_mobile_app/screens/home_tab.dart';
import 'package:val_graphics_mobile_app/screens/profile_tab.dart';
import 'package:val_graphics_mobile_app/screens/tab4.dart';

import '../db/constants.dart';
import '../screens/services_screen.dart';
import '../widgets/custom_bottom_nav.dart';

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
    TabFour(),
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
        title: const Text('VAL Graphics'),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}
