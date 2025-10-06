import 'package:flutter/material.dart';
import 'package:val_graphics_mobile_app/widgets/circular_progress_indicator.dart';

import '../../api/auth_api.dart';
import '../../db/constants.dart';
import '../../l10n/app_localizations.dart';
import '../../util/navigation_util.dart';
import '../../util/snackbar_util.dart';
import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _otpSent = false;

  Future<void> _sendOtp() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      SnackBarUtil.show(context, "Please enter your email address");
      return;
    }

    setState(() => _isLoading = true);

    try {
      SnackBarUtil.show(context, "Sending OTP...");

      final result = await AuthApi.forgotPassword(email: email);

      SnackBarUtil.show(context, result["message"] ?? "OTP sent");

      if (result["success"] == true) {
        setState(() => _otpSent = true);
      }
    } catch (e) {
      print("Error: $e");
      SnackBarUtil.show(context, "Failed to send OTP");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _verifyOtpAndResetPassword() async {
    final email = _emailController.text.trim();
    final otp = _otpController.text.trim();
    final password = _passwordController.text.trim();

    if (otp.isEmpty || password.isEmpty) {
      SnackBarUtil.show(context, "Please enter OTP and new password");
      return;
    }

    setState(() => _isLoading = true);

    try {
      SnackBarUtil.show(context, "Verifying OTP...");

      final verifyResult = await AuthApi.verifyOtp(email: email, otp: otp);

      if (verifyResult["success"] == true) {
        final resetResult = await AuthApi.resetPassword(
          email: email,
          otp: otp,
          password: password,
        );

        SnackBarUtil.show(context, resetResult["message"] ?? "Password reset");

        if (resetResult["success"] == true) {
          NavigationUtil.pushReplacement(context, const LoginScreen());
        }
      } else {
        SnackBarUtil.show(
          context,
          verifyResult["message"] ?? "OTP verification failed",
        );
      }
    } catch (e) {
      print("Error: $e");
      SnackBarUtil.show(context, "Error resetting password");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, primaryColorHover],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/logo-white.webp", height: 110),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.forgotPassword,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.forgotPasswordDesc,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 40),

                  // Step 1: Email input
                  if (!_otpSent) ...[
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.email,
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.black87,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: _isLoading ? null : _sendOtp,
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: Loader(),
                              )
                            : Text(
                                AppLocalizations.of(context)!.sendOtp,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],

                  // Step 2: OTP & new password
                  if (_otpSent) ...[
                    TextField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.enterOtp,
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                          color: Colors.black87,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.newPassword,
                        prefixIcon: const Icon(
                          Icons.password_outlined,
                          color: Colors.black87,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 18,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: _isLoading
                            ? null
                            : _verifyOtpAndResetPassword,
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: Loader(),
                              )
                            : Text(
                                AppLocalizations.of(context)!.resetPassword,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],

                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.rememberYourPassword,
                        style: TextStyle(color: Colors.white70),
                      ),
                      GestureDetector(
                        onTap: () {
                          NavigationUtil.pushReplacement(
                            context,
                            const LoginScreen(),
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.login,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
