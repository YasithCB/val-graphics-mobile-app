import 'package:flutter/material.dart';

class TabOne extends StatelessWidget {
  const TabOne({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24.0),
        child: Text('Home / Dashboard\n\nReplace with real content', textAlign: TextAlign.center),
      ),
    );
  }
}
