import 'package:flutter/material.dart';

class HorizontalImageGrid extends StatelessWidget {
  final List<Map<String, String>> items;
  // each item = {"image": "...", "title": "..."}

  const HorizontalImageGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160, // enough space for image + title
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1, // only one row
          mainAxisSpacing: 0,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  item["image"]!,
                  fit: BoxFit.cover,
                  height: 100,
                  width: 140,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item["title"]!,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }
}
