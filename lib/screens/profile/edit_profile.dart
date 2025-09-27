import 'package:flutter/material.dart';
import 'package:val_graphics_mobile_app/api/auth_api.dart';
import 'package:val_graphics_mobile_app/screens/home_screen.dart';
import 'package:val_graphics_mobile_app/util/snackbar_util.dart';
import 'package:val_graphics_mobile_app/util/storage_util.dart';

import '../../db/constants.dart';
import '../../util/util.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController(
    text: currentUser['username'],
  );
  final TextEditingController _emailController = TextEditingController(
    text: currentUser['email'],
  );
  final TextEditingController _mobileController = TextEditingController(
    text: currentUser['mobile'],
  );

  bool _isSaving = false;

  void _saveProfile() async {
    final confirmed = await confirmAction(
      context,
      "Confirm Update",
      " This action can't be undone.",
    );
    if (!confirmed) return; // ❌ Stop if not confirmed

    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isSaving = true);

      final result = await AuthApi.updateProfile(
        token: currentUserToken,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        mobile: _mobileController.text.trim(),
      );

      setState(() => _isSaving = false);

      // update the user data
      if (result['success']) {
        currentUser = result['user'];
        StorageUtil.saveUser(result['user']);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }

      SnackBarUtil.show(context, result["message"] ?? "Something went wrong");
    }
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 16),

              TextFormField(
                controller: _nameController,
                decoration: _inputDecoration(
                  "Full Name",
                  Icons.person_2_outlined,
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter your name" : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: _inputDecoration("Email", Icons.email_outlined),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your email";
                  }
                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );
                  if (!emailRegex.hasMatch(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _mobileController,
                decoration: _inputDecoration(
                  "Mobile",
                  Icons.phone_android_outlined,
                ),
                keyboardType: TextInputType.phone,
                validator: (value) => value == null || value.length < 7
                    ? "Enter valid mobile"
                    : null,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _saveProfile,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: primaryColor,
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text(
                          "Save",
                          style: TextStyle(fontSize: 18, color: Colors.white),
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
