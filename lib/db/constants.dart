import 'package:flutter/material.dart';

final Color primaryColor = Color(0xFF03031E);
final Color primaryColor2 = Color(0xFFDA9C0B);
final Color primaryColor5 = Color(0x1203031E);
final Color primaryColor20 = Color(0x3303031E);
final Color primaryColor50 = Color(0x8003031E);
final Color primaryColorHover = Color(0xFF030347);

// 📏 Get device width & height
double deviceWidth = 0;
double deviceHeight = 0;

const String baseUrl = "http://192.168.100.120:5000";

Map<String, dynamic> currentUser = {};
String currentUserToken = '';
