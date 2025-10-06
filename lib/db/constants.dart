import 'package:flutter/material.dart';

final Color primaryColor = const Color(0xFF03031E);
final Color primaryColor2 = const Color(0xFFCC9001);
final Color primaryColor5 = const Color(0x1203031E);
final Color primaryColor20 = const Color(0x3303031E);
final Color primaryColor50 = const Color(0x8003031E);
final Color primaryColorHover = const Color(0xFF030347);

const LinearGradient metallicGold = LinearGradient(
  colors: [
    Color(0xFFFFD700), // Pure gold
    Color(0xFFDAA520), // Goldenrod
    Color(0xFFC9A227), // Medium gold tone
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

// 📏 Get device width & height
double deviceWidth = 0;
double deviceHeight = 0;

const String baseUrl = "http://192.168.100.120:5000";

Map<String, dynamic> currentUser = {};
String currentUserToken = '';

// COMPANY DATA
const String mobile = '+97126350660';
