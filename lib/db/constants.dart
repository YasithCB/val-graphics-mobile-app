import 'package:flutter/material.dart';

final Color primaryColor = Color(0xFFE81564);
final Color primaryColor5 = Color(0x17E81564);
final Color primaryColor20 = Color(0x33E81564);
final Color primaryColor50 = Color(0x80E81564);
final Color primaryColorHover = Color(0xFFAF0827);

// 📏 Get device width & height
double deviceWidth = 0;
double deviceHeight = 0;

const String baseUrl = "http://192.168.100.120:5000";

Map<String, dynamic> currentUser = {};
String currentUserToken = '';
