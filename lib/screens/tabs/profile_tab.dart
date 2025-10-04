import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:val_graphics_mobile_app/screens/auth/login_screen.dart';
import 'package:val_graphics_mobile_app/screens/language_settings_screen.dart';
import 'package:val_graphics_mobile_app/screens/profile/about_us.dart';
import 'package:val_graphics_mobile_app/screens/profile/edit_profile.dart';
import 'package:val_graphics_mobile_app/util/storage_util.dart';

import '../../db/constants.dart';
import '../../l10n/app_localizations.dart';
import '../../util/navigation_util.dart';
import '../../util/snackbar_util.dart';
import '../../util/util.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    Future<void> handleLogout(BuildContext context) async {
      final confirmed = await confirmAction(context, "Confirm Logout", "");
      if (!confirmed) return; // ❌ Stop if not confirmed

      await StorageUtil.clear();
      // clear local var
      currentUser = {};

      print("🚪 Logged out");
      SnackBarUtil.show(context, "Logged out");

      NavigationUtil.pushAndRemoveUntil(context, LoginScreen());
    }

    handleLogin() {
      NavigationUtil.pushAndRemoveUntil(context, LoginScreen());
    }

    Future<void> openCall() async {
      final Uri url = Uri(scheme: 'tel', path: mobile);

      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $mobile';
      }
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        // Use SingleChildScrollView so page content doesn't overflow on small screens
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: deviceHeight * 0.05),

              // === Centered Avatar with Name/Email ===
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50, // 🔹 bigger avatar
                        backgroundImage: AssetImage(
                          "assets/images/user-avatar-robot.webp",
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        currentUser['username'] ??
                            AppLocalizations.of(context)!.helloGuest,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        currentUser['email'] ??
                            AppLocalizations.of(context)!.logInNowForBestEx,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),
              const Divider(color: Colors.black12),
              const SizedBox(height: 24),

              // 📋 Options
              Column(
                children: [
                  if (currentUser.isNotEmpty)
                    ListTile(
                      onTap: () => {
                        NavigationUtil.push(context, EditProfileScreen()),
                      },
                      leading: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryColor5,
                        ),
                        child: Icon(
                          Icons.edit,
                          color: primaryColorHover,
                          size: 20,
                        ),
                      ),
                      title: Text(AppLocalizations.of(context)!.editProfile),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    ),

                  ListTile(
                    onTap: () => NavigationUtil.push(context, AboutUsScreen()),
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor5,
                      ),
                      child: Icon(
                        Icons.info_outline,
                        color: primaryColorHover,
                        size: 20,
                      ),
                    ),
                    title: Text(AppLocalizations.of(context)!.aboutUs),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  ListTile(
                    onTap: () {
                      NavigationUtil.push(context, LanguageSettingsScreen());
                    },
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor5,
                      ),
                      child: Icon(
                        Icons.language,
                        color: primaryColorHover,
                        size: 20,
                      ),
                    ),
                    title: Text(AppLocalizations.of(context)!.language),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  ListTile(
                    onTap: openCall,
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor5,
                      ),
                      child: Icon(
                        Icons.call_outlined,
                        color: primaryColorHover,
                        size: 20,
                      ),
                    ),
                    title: Text(AppLocalizations.of(context)!.contactSup),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor5,
                      ),
                      child: Icon(
                        Icons.star_rate_outlined,
                        color: primaryColorHover,
                        size: 20,
                      ),
                    ),
                    title: Text(AppLocalizations.of(context)!.rateTheApp),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 🚪 Logout button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,

                  foregroundColor: primaryColor,
                  minimumSize: const Size.fromHeight(50), // full width
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: Icon(
                  currentUser.isEmpty
                      ? Icons.login_outlined
                      : Icons.logout_rounded,
                  color: Colors.white,
                ),
                label: Text(
                  currentUser.isEmpty
                      ? AppLocalizations.of(context)!.loginNow
                      : AppLocalizations.of(context)!.logout,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                onPressed: () =>
                    currentUser.isEmpty ? handleLogin() : handleLogout(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
