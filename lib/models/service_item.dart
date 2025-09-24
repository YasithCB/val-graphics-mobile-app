import 'dart:ui';

class ServiceItem {
  final String title;
  final String imagePath; // <-- added image
  final Color? color;

  ServiceItem({
    required this.title,
    required this.imagePath,
    this.color,
  });
}
