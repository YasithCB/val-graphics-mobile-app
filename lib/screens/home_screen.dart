import 'package:flutter/material.dart';
import 'package:val_graphics_mobile_app/screens/tab1.dart';
import 'package:val_graphics_mobile_app/screens/tab2.dart';
import 'package:val_graphics_mobile_app/screens/tab4.dart';
import 'package:val_graphics_mobile_app/screens/tab5.dart';
import '../screens/services_screen.dart';
import '../widgets/custom_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 2; // default to middle Services tab

  final List<Widget> _pages = const [
    TabOne(),
    TabTwo(),
    ServicesScreen(),
    TabFour(),
    TabFive(),
  ];

  void _onTabSelected(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('VAL Graphics'),
        centerTitle: true,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}
