import 'package:flutter/material.dart';
import 'package:val_graphics_mobile_app/db/banners_data.dart';
import 'package:val_graphics_mobile_app/db/constants.dart';
import 'package:val_graphics_mobile_app/db/services_data.dart';
import 'package:val_graphics_mobile_app/screens/notification_screen.dart';
import 'package:val_graphics_mobile_app/screens/service_details_screen.dart';
import 'package:val_graphics_mobile_app/screens/view_all_services_screen.dart';
import 'package:val_graphics_mobile_app/util/navigation_util.dart';

import '../../l10n/app_localizations.dart';
import '../../widgets/home/horizontal-image-slider.dart';

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

  final Map<String, IconData> serviceIcons = {
    "Car Wrapping Services": Icons.directions_car_outlined,
    "خدمات تغليف السيارات": Icons.directions_car_outlined,

    "Car Tinting And Protection": Icons.beach_access_outlined,
    "تظليل وحماية السيارات": Icons.beach_access_outlined,

    "Interior Fitouts": Icons.chair_outlined,
    "تشطيبات داخلية": Icons.chair_outlined,

    "Digital Printing": Icons.print_outlined,
    "الطباعة الرقمية": Icons.print_outlined,

    "Billboard & Signage": Icons.developer_board,
    "اللوحات الإعلانية واللافتات": Icons.developer_board,

    "Digital Solutions": Icons.computer,
    "الحلول الرقمية": Icons.computer,
  };

  @override
  Widget build(BuildContext context) {
    print('CURRENT USER :::::::::::::');
    print(currentUser);

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
                  // Check if user exists
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 28,
                        backgroundImage: AssetImage(
                          "assets/images/user-avatar-robot.webp",
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentUser['username'] ??
                                AppLocalizations.of(context)!.helloGuest,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            currentUser['email'] ??
                                AppLocalizations.of(context)!.logInNowForBestEx,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Notification icon always on the right
                  IconButton(
                    onPressed: () {
                      NavigationUtil.push(context, NotificationScreen());
                    },
                    icon: const Icon(Icons.notifications_none, size: 28),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // === Title: Special Offers ===
              Text(
                AppLocalizations.of(context)!.specialOffers,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 12),

              // === Swipeable Banner Carousel ===
              SizedBox(
                height: 180,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: imageBanners.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, i) {
                    return BannerCard(imagePath: imageBanners[i]);
                  },
                ),
              ),

              const SizedBox(height: 8),

              // === Indicator Dots / Bars ===
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  imageBanners.length,
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
              Text(
                AppLocalizations.of(context)!.categories,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              // === Categories row (5 icons) ===
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    getServicesList(
                      Localizations.localeOf(context).languageCode,
                    ).map((service) {
                      return Expanded(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // 🔹 Navigate to Service Details
                                NavigationUtil.push(
                                  context,
                                  ServiceDetailsScreen(service: service),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryColor5,
                                ),
                                child: Icon(
                                  serviceIcons[service.name] ?? Icons.category,
                                  color: primaryColor,
                                  size: 24,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              service.name,
                              style: const TextStyle(
                                fontSize: 11,
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
                children: [
                  Text(
                    AppLocalizations.of(context)!.popularServices,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      NavigationUtil.push(context, ViewAllServices());
                    },
                    child: Text(
                      AppLocalizations.of(context)!.viewAll,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // 🔹 Horizontal grid of images - Popular Services
              HorizontalImageGrid(),
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
