import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/custom_dialog.dart';
import '../../../core/utils/enums.dart';
import '../../../core/widgets/global_appbar.dart';

class OTPConfirmationScreen extends StatefulWidget {
  final String phoneNumber;

  const OTPConfirmationScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OTPConfirmationScreen> createState() => _OTPConfirmationScreenState();
}

class _OTPConfirmationScreenState extends State<OTPConfirmationScreen> {
  // 4 Controllers for the 4 OTP boxes
  final List<TextEditingController> _controllers =
  List.generate(4, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const GlobalAppBar(
        title: "",
        canGoBack: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              // Header Text
              Text(
                "Confirm your Phone",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor, // #003780 from your Figma
                ),
              ),
              const SizedBox(height: 12),
              // Description Text
              Text.rich(
                TextSpan(
                  text: "We send 4 digit of code to ",
                  style: const TextStyle(color: Colors.black87, fontSize: 15),
                  children: [
                    TextSpan(
                      text: widget.phoneNumber,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // 4 OTP Boxes in a row
              // 4 OTP Boxes in a row
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center the boxes
                children: [
                  _buildOTPBox(0),
                  const SizedBox(width: 12),
                  _buildOTPBox(1),
                  const SizedBox(width: 12),
                  _buildOTPBox(2),
                  const SizedBox(width: 12),
                  _buildOTPBox(3),
                ],
              ),

              const SizedBox(height: 30),

              // Didn't get code section
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't get the code?",
                    style: TextStyle(color: Colors.black54, fontSize: 14),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle Resend logic
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      "Resend",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),


              const Spacer(),

              // Bottom Verify Button
              ElevatedButton(
                onPressed: () async {
                  String otp = _controllers.map((e) => e.text).join();

                  // 1. Validation Check
                  if (otp.length < 4) {
                    showCustomSnackBar(
                      context,
                      message: "Please enter the complete 4-digit code",
                      type: MessageType.error,
                    );
                    return;
                  }

                  // 2. Show Loading Dialog
                  showCustomDialog(
                    context,
                    title: "Verifying",
                    message: "Please wait while we confirm your code...",
                    type: MessageType.info,
                    showLoading: true,
                  );

                  // 3. Simulate API Delay
                  await Future.delayed(const Duration(seconds: 2));

                  // 4. Close Loading Dialog
                  if (context.mounted) Navigator.of(context).pop();

                  // 5. Success/Error Logic (Example)
                  if (otp == "1234") { // Replace with actual logic
                    showCustomSnackBar(
                      context,
                      message: "Phone verified successfully!",
                      type: MessageType.success,
                    );
                    // Navigate to next screen here
                  } else {
                    showCustomSnackBar(
                      context,
                      message: "The OTP you entered is incorrect",
                      type: MessageType.error,
                    );
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
                child: const Text(
                  "Verify Your Phone",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),

              // Footer Support
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Did you face any issue? ",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Contact US",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget to build each OTP box
  // Helper widget to build each OTP box
  // Helper widget to build each OTP box
  Widget _buildOTPBox(int index) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        // Yellow-Grey background color
        color: const Color(0xFFE2E2D0),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.black,
          width: 1.5,
        ),
      ),
      child: Center(
        child: TextField(
          controller: _controllers[index],
          focusNode: _focusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 124,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          decoration: const InputDecoration(
            counterText: "",
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (value) {
            if (value.isNotEmpty) {
              if (index < 3) {
                _focusNodes[index + 1].requestFocus();
              } else {
                _focusNodes[index].unfocus();
              }
            } else if (value.isEmpty && index > 0) {
              _focusNodes[index - 1].requestFocus();
            }
            setState(() {});
          },
        ),
      ),
    );
  }
}
