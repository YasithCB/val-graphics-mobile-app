import 'package:flutter/material.dart';
import 'package:val_graphics_mobile_app/db/banners_data.dart';
import 'package:val_graphics_mobile_app/db/services_data.dart';

import '../widgets/home/horizontal-image-slider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFE81564);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        // Use SingleChildScrollView so page content doesn't overflow on small screens
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === Top Row: Avatar + Name/Email + Notification Icon ===
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 28,
                        backgroundImage: AssetImage(
                          "assets/images/sample-avatar.webp",
                        ), // replace
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "John Doe",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "john.doe@email.com",
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Notification icon on the right
                  IconButton(
                    onPressed: () {
                      // TODO: handle notification tap
                    },
                    icon: const Icon(Icons.notifications_none, size: 28),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // === Title: Special Offers ===
              const Text(
                "Special Offers",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 12),

              // === Swipeable Banner Carousel ===
              SizedBox(
                height: 180,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: IMAGE_BANNERS.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, i) {
                    return BannerCard(imagePath: IMAGE_BANNERS[i]);
                  },
                ),
              ),

              const SizedBox(height: 8),

              // === Indicator Dots / Bars ===
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  IMAGE_BANNERS.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 20 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? primaryColor
                          : primaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // === Categories title ===
              const Text(
                "Categories",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              // === Categories row (5 icons) ===
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: SERVICES.map((service) {
                  return Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor.withOpacity(0.10),
                          ),
                          child: Icon(
                            service.icon,
                            color: primaryColor,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          service.title,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              // 🔹 Title row - Popular Services
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Popular Services",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "View all",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFFE81564),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // 🔹 Horizontal grid of images - Popular Services
              HorizontalImageGrid(
                items: [
                  {
                    "image": "assets/images/services/1.webp",
                    "title": "BRANDING",
                  },
                  {
                    "image": "assets/images/services/2.webp",
                    "title": "PRINTING",
                  },
                  {
                    "image": "assets/images/services/3.webp",
                    "title": "SIGNAGE",
                  },
                  {
                    "image": "assets/images/services/4.webp",
                    "title": "INTERIOR",
                  },
                  {
                    "image": "assets/images/services/5.webp",
                    "title": "DIGITAL",
                  },
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BannerCard extends StatelessWidget {
  final String imagePath;
  const BannerCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}
