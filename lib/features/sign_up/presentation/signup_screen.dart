import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_banking/core/utils/enums.dart';
import 'package:smart_banking/core/utils/logger.dart';
import 'package:smart_banking/core/widgets/global_appbar.dart';

import '../../../core/navigation/app_navigator.dart';
import '../../../core/navigation/route_names.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/custom_dialog.dart';
import '../../../core/utils/helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _phoneController = TextEditingController();
  final _pinController = TextEditingController();
  final _confirmPinController = TextEditingController();
  bool _isPinVisible = false;
  bool _isConfirmPinVisible = false;

  void _handleSignUp() {
    final phone = _phoneController.text.trim();
    final pin = _pinController.text.trim();
    final confirmPin = _confirmPinController.text.trim();

    // 1. Check for empty fields
    if (phone.isEmpty || pin.isEmpty || confirmPin.isEmpty) {
      showCustomSnackBar(context,
          type: MessageType.error,
          message: "Please fill in all mandatory fields");
      return;
    }

    // 2. Phone Number Validation (Basic length check for BD numbers)
    if (phone.length < 11) {
      showCustomSnackBar(context,
          type: MessageType.error,
          message: "Please enter a valid phone number");
      return;
    }

    // 3. PIN Length Validation
    if (pin.length != 6) {
      showCustomSnackBar(context,
          type: MessageType.error, message: "PIN must be exactly 6 digits");
      return;
    }

    // 4. Similarity Validation
    if (pin != confirmPin) {
      showCustomSnackBar(context,
          type: MessageType.error, message: "PINs do not match!");
      return;
    }

    // Success logic
    AppLogger.i("Validation Successful. Navigating to OTP for: $phone");

    // Pass the phone number to the OTP screen via 'extra'
    AppNavigator.pushTo(
      RouteNames.opt_confirmation,
      extra: phone,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: GlobalAppBar(
        title: "",
        canGoBack: true,
        // Using goTo here ensures a clean navigation back to Login
        onBackPress: () => AppNavigator.goTo(RouteNames.login),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Text(
                context.t.create_account,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
              const SizedBox(height: 30),

              // Phone Number Field
              _buildLabel("Phone Number"),
              _buildTextField(
                controller: _phoneController,
                hintText: "01701*****4",
                icon: Icons.phone_android,
                keyboardType: TextInputType.phone,
              ),
              const Divider(height: 1, color: Colors.grey),
              const SizedBox(height: 20),

              // PIN Field
              _buildLabel("Enter 6 Digit PIN"),
              _buildTextField(
                controller: _pinController,
                hintText: "123456",
                icon: Icons.lock_outline,
                isPassword: true,
                isVisible: _isPinVisible,
                onToggleVisibility: () =>
                    setState(() => _isPinVisible = !_isPinVisible),
                maxLength: 6,
              ),
              const Divider(height: 1, color: Colors.grey),
              const SizedBox(height: 20),

              // Confirm PIN Field
              _buildLabel("Re-Enter 6 Digit PIN"),
              _buildTextField(
                controller: _confirmPinController,
                hintText: "123456",
                icon: Icons.lock_reset,
                isPassword: true,
                isVisible: _isConfirmPinVisible,
                onToggleVisibility: () =>
                    setState(() =>
                    _isConfirmPinVisible = !_isConfirmPinVisible),
                maxLength: 6,
              ),
              const Divider(height: 1, color: Colors.grey),
              const SizedBox(height: 40),

              // Action Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleSignUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 0,
                  ),
                  child: const Text("SIGN UP",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 40),

              // Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Did you face any issue? ",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Add contact support logic
                    },
                    child: Text(
                      "Contact Us",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
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

  // Refactored TextField builder to reduce redundancy and handle visibility errors
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.number,
    bool isPassword = false,
    bool isVisible = false,
    VoidCallback? onToggleVisibility,
    int? maxLength,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword && !isVisible,
      keyboardType: keyboardType,
      maxLength: maxLength,
      inputFormatters: keyboardType == TextInputType.number
          ? [FilteringTextInputFormatter.digitsOnly]
          : null,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        counterText: "",
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey.shade50,
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: onToggleVisibility,
        )
            : null,
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Text(text,
              style: const TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 14)),
          const Text(" *",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _pinController.dispose();
    _confirmPinController.dispose();
    super.dispose();
  }
}