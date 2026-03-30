import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_banking/core/utils/enums.dart';
import 'package:smart_banking/core/widgets/global_appbar.dart';

import '../../../core/navigation/app_navigator.dart';
import '../../../core/navigation/route_names.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/custom_dialog.dart';
import '../../../core/utils/helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  final _pinController = TextEditingController();
  bool _isPinVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const GlobalAppBar(
        title: "",
        canGoBack: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Log in Epay",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
              ),
              const SizedBox(height: 30),

              // Phone Number Label
              _buildLabel("Phone Number"),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: "01701*****4",
                  prefixIcon: const Icon(Icons.phone_android),
                  // Removed black border
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey
                      .shade50, // Subtle background instead of border
                ),
              ),
              const Divider(height: 1, color: Colors.grey),
              // Optional underline for structure
              const SizedBox(height: 20),

              // PIN Label
              _buildLabel("Enter 6 Digit PIN"),
              TextField(
                controller: _pinController,
                obscureText: !_isPinVisible,
                keyboardType: TextInputType.number,
                maxLength: 6,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: "123456",
                  prefixIcon: const Icon(Icons.lock_outline),
                  counterText: "",
                  // Removed black border
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  suffixIcon: IconButton(
                    icon: Icon(_isPinVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () =>
                        setState(() => _isPinVisible = !_isPinVisible),
                  ),
                ),
              ),
              const Divider(height: 1, color: Colors.grey),

              // Forgot PIN Button (Left Aligned)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    // Navigate to forgot pin screen if needed
                  },
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: const Text("Forgot PIN?"),
                ),
              ),
              const SizedBox(height: 30),

              // Action Column
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // VALIDATION LOGIC
                        if (_phoneController.text.length != 11) {
                          showCustomSnackBar(
                            context,
                            message: "Phone number must be exactly 11 characters",
                            type: MessageType.error,
                          );
                        } else if (_pinController.text.length != 6) {
                          showCustomSnackBar(
                            context,
                            message: "PIN must be exactly 6 digits",
                            type: MessageType.error,
                          );
                        } else {
                          // Success - Proceed to landing
                          AppNavigator.pushTo(RouteNames.landing);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        context.t.log_in, // Using direct string if context.t is not ready
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Simplified Fingerprint (No background, no text)
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                        Icons.fingerprint,
                        color: primaryColor,
                        size: 50
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      AppNavigator.goTo(RouteNames.sign_up);
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                          color: primaryColor, fontWeight: FontWeight.bold, ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Footer Support
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Did you face any issue?",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Contact Us",
                      style: TextStyle(fontWeight: FontWeight.bold)
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const Text(
            " *",
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}