import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';

class ConfirmSendMoneyScreen extends StatefulWidget {
  final String recipientNumber;

  const ConfirmSendMoneyScreen({super.key, required this.recipientNumber});

  @override
  State<ConfirmSendMoneyScreen> createState() => _ConfirmSendMoneyScreenState();
}

class _ConfirmSendMoneyScreenState extends State<ConfirmSendMoneyScreen> {
  final TextEditingController _amountController = TextEditingController();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    // Listen to text changes to enable/disable button
    _amountController.addListener(() {
      setState(() {
        _isButtonEnabled = _amountController.text
            .trim()
            .isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: RichText(
          text: const TextSpan(
            style: TextStyle(color: primaryColor, fontSize: 18),
            children: [
              TextSpan(text: "Confirm to "),
              TextSpan(
                text: "Send Money",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Contact Number Label (Left Aligned)
            const Text(
              "Contact Number",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),

            // 2. Centered Contact Number
            Center(
              child: Text(
                widget.recipientNumber,
                style: const TextStyle(
                  color: primaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),

            // 3. Amount Label (Left Aligned)
            const Text(
              "Amount",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),

            // 4. TK Input Field
            // 4. Centered and Narrow TK Input Field
            Center(
              child: SizedBox(
                width: 200, // Limits the width so it's not full-screen
                child: TextField(
                  controller: _amountController,
                  textAlign: TextAlign.center, // Centers hint and input text
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    // prefix stays next to the text instead of far left
                    prefix: const Text(
                      "TK: ",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    hintText: "0.00",
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 2),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // 5. Available Balance Row (Blue Colored)
            Row(
              children: [
                const Text(
                  "Available Balance: ",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  "12,999 TK",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const Spacer(), // Pushes the button to the bottom

            // 6. Confirm Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isButtonEnabled
                    ? () {
                  // Show Success Popup
                  showDialog(
                    context: context,
                    barrierDismissible: false, // User must click button to close
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min, // Fits content height
                            children: [
                              // 1. Top Asset Image
                              Image.asset(
                                "assets/send_money/send_money_success.png", // Replace with your success asset path
                                height: 80,
                              ),
                              const SizedBox(height: 20),

                              // 2. Success Title
                              const Text(
                                "Send Money Successful",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),

                              // 3. Success Detail Text
                              Text(
                                "You have successfully Sent TK ${_amountController.text}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 30),

                              // 4. Back To Home Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Navigate back to home or clear stack
                                    Navigator.of(context).pop(); // Closes Dialog
                                    Navigator.of(context).pop(); // Closes Confirm Screen
                                    // Add your Home navigation logic here if needed
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text(
                                    "Back To Home",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Confirm",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}