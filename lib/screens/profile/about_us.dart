import 'package:flutter/material.dart';
import 'package:val_graphics_mobile_app/db/constants.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // Logo
              Image.asset(
                "assets/logo.webp",
                height: 100, // adjust size
              ),

              const SizedBox(height: 16),

              const Text(
                "Creative Solutions Under One Roof",
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              // About Content
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(Icons.info_outline, size: 40, color: primaryColor),
                      SizedBox(height: 12),
                      Text(
                        "We are a leading creative agency specializing in "
                        "vehicle branding, digital printing, interior design, and signage. "
                        "Our mission is to deliver innovative and high-quality solutions "
                        "that help businesses stand out.",
                        style: TextStyle(fontSize: 16, height: 1.5),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Mission / Vision Section
              Row(
                children: [
                  Expanded(
                    child: Card(
                      color: Colors.white70,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Icon(Icons.flag, size: 40, color: primaryColor),
                            SizedBox(height: 8),
                            Text(
                              "Our Mission",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "To empower brands with creative solutions that inspire and connect with people.",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Card(
                      color: Colors.white70,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Icon(
                              Icons.visibility,
                              size: 40,
                              color: primaryColor,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Our Vision",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "To be the go-to creative partner across the UAE for branding and design solutions.",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Contact Section
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Icon(Icons.contact_mail, size: 40, color: primaryColor),
                      SizedBox(height: 12),
                      Text(
                        "Get in Touch",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text("📍 Abu Dhabi, United Arab Emirates"),
                      Text("📞 +971 502 30 31 30"),
                      Text("📧 info@valgraphics.com"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
