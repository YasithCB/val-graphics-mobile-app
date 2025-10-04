import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    // style values
    const double normalIconSize = 24;
    const double centerIconSize = 42;

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTabSelected,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, size: normalIconSize),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search, size: normalIconSize),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          // make center tab visually prominent
          icon: SizedBox(
            height: centerIconSize,
            width: centerIconSize,
            child: Center(
              child: Icon(Icons.account_tree_outlined, size: centerIconSize),
            ),
          ),
          label: 'Services',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart, size: normalIconSize),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, size: normalIconSize),
          label: 'Profile',
        ),
      ],
    );
  }
}
