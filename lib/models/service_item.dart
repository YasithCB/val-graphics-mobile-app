import 'package:flutter/cupertino.dart';

class ServiceItem {
  final String title;
  final String imagePath; // <-- added image
  final IconData icon;
  final Color? color;

  ServiceItem({
    required this.title,
    required this.imagePath,
    required this.icon,
    this.color,
  });
}
