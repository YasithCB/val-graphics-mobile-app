import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:val_graphics_mobile_app/util/storage_util.dart';

import '../db/constants.dart';

class AuthApi {
  /// Register user
  static Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String mobile,
    required String password,
  }) async {
    final url = Uri.parse("$baseUrl/register");
    print("📡 [REGISTER] Sending request to: $url");

    try {
      final bodyData = {
        "username": name, // backend expects "username"
        "email": email,
        "mobile": mobile,
        "password": password,
      };

      print("➡️ [REQUEST BODY] $bodyData");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(bodyData),
      );

      print("⬅️ [RESPONSE STATUS] ${response.statusCode}");
      print("⬅️ [RESPONSE BODY] ${response.body}");

      final Map<String, dynamic> data = jsonDecode(response.body);

      // Normalize response into { success, message }
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("✅ [REGISTER SUCCESS] ${data["message"]}");
        return {
          "success": true,
          "message": data["message"] ?? "Registration successful",
        };
      } else {
        print("❌ [REGISTER FAILED] ${data["message"]}");
        return {
          "success": false,
          "message": data["message"] ?? "Registration failed",
        };
      }
    } catch (e) {
      print("🚨 [REGISTER ERROR] $e");
      return {"success": false, "message": "Something went wrong: $e"};
    }
  }

  static Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse("$baseUrl/login");
    print("📡 [LOGIN] Sending request to: $url");

    try {
      final bodyData = {"email": email, "password": password};

      print("➡️ [REQUEST BODY] $bodyData");

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(bodyData),
      );

      print("⬅️ [RESPONSE STATUS] ${response.statusCode}");
      print("⬅️ [RESPONSE BODY] ${response.body}");

      final Map<String, dynamic> data = jsonDecode(response.body);

      // save user data
      if (data["success"] == true) {
        currentUser = data["user"];
        currentUserToken = data["token"];

        await StorageUtil.saveToken(data["token"]);
        await StorageUtil.saveUser(data["user"]);
        print("✅ Saved token & user");
      }

      return {
        "success": data["success"] ?? false,
        "message": data["message"] ?? "Login failed",
        "token": data["token"],
        "user": data["user"],
      };
    } catch (e) {
      print("🚨 [LOGIN ERROR] $e");
      return {"success": false, "message": "Something went wrong: $e"};
    }
  }

  static Future<Map<String, dynamic>> updateProfile({
    required String token,
    required String name,
    required String email,
    required String mobile,
  }) async {
    final url = Uri.parse("$baseUrl/update-profile");

    print("📡 [UPDATE PROFILE] Sending request to: $url");
    print(
      "➡️ [REQUEST HEADERS] {Content-Type: application/json, Authorization: Bearer $token...}",
    );
    print(
      "➡️ [REQUEST BODY] {name: $name, email: $email, mobile: $mobile, id: ${currentUser['id']}",
    );

    try {
      final response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "mobile": mobile,
          'id': currentUser['id'],
        }),
      );

      print("⬅️ [RESPONSE STATUS] ${response.statusCode}");
      print("⬅️ [RESPONSE BODY] ${response.body}");

      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("✅ [PARSED RESPONSE] $data");
        return data;
      } else {
        return {"success": false, "message": data['message']};
      }
    } catch (e) {
      print("🚨 [UPDATE PROFILE ERROR] $e");
      return {"success": false, "message": "⚠️ Network error: $e"};
    }
  }
}
