import 'package:flutter/material.dart';
import 'package:smart_banking/core/theme/colors.dart';
import 'package:smart_banking/core/utils/enums.dart';

import '../../../core/navigation/app_navigator.dart';
import '../../../core/navigation/route_names.dart';
import '../../../core/utils/custom_dialog.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  bool isAgentSelected = true;

  // 1. Add this controller
  final TextEditingController _numberController = TextEditingController();

  @override
  void dispose() {
    _numberController.dispose(); // Clean up the controller
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => AppNavigator.pop(),
        ),
        title: const Text(
          'Send Money',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isAgentSelected ? _buildAgentView() : _buildAtmView(),
          ],
        ),
      ),
    );
  }



  // --- AGENT VIEW ---
  // --- AGENT VIEW ---
  Widget _buildAgentView() {
    // --- AGENT VIEW ---Widget _buildAgentView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Agent Number Input
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _numberController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter the Name or Number",
              hintStyle: const TextStyle(color: Colors.grey),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Updated: Wrapped in GestureDetector for navigation
                  GestureDetector(
                    onTap: () {
                      if (_numberController.text.trim().isNotEmpty) {
                        // Using AppNavigator with the route name and passing the number as 'extra'
                        AppNavigator.pushTo(
                          RouteNames.confirm_send_money,
                          extra: _numberController.text.trim(),
                        );

                      } else {

                        showCustomSnackBar(context, message: "Please select or enter a number first", type: MessageType.error);

                      }
                    },
                    child: const Icon(Icons.chevron_right, color: primaryColor, size: 30),
                  ),
                  const SizedBox(width: 10),
                  Image.asset("assets/send_money/contact.png", height: 24)
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        // ... rest of your code


        _sectionTitle("Recent Contacts"),
        _contactItem("Samantha", "Bank - 098734228756"),
        _contactItem("Rose Hope", "Bank - 098734228758"),

        const SizedBox(height: 15),
        _sectionTitle("All Contacts"),
        _contactItem("Andrea Summer", "Bank - 0987 3422 8756"),
        _contactItem("Karen William", "Bank - 0987 3422 8756"),
      ],
    );
  }

  // --- ATM VIEW ---
  // --- ATM VIEW ---
  Widget _buildAtmView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Balance Info
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Centering row-wise
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Available Balance: ",
                style: TextStyle(color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8), // Small gap between label and amount
              const Text(
                "139,999 TK",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),

        const Text(
          "Search for Partner Bank",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
        ),
        const Divider(height: 20),

        // Bank List
        _bankListItem(
            "Basic Bank", "Dhanmondi", "assets/banks/bank_1.png"),
        _bankListItem(
            "Brack Bangla", "Gulshan", "assets/banks/bank_2.png"),
        _bankListItem("Islamic Bank", "Uttara", "assets/banks/bank_3.png"),
      ],
    );
  }

  // UI Helpers
  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(title, style: const TextStyle(
          fontWeight: FontWeight.normal, color: Colors.black)),
    );
  }

  Widget _contactItem(String name, String detail) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
          radius: 22,
          backgroundColor: Colors.blue.shade50,
          child: const Icon(Icons.person, color: Colors.grey)
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      subtitle: Text(
        detail,
        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
      ),
      onTap: () {
        setState(() {
          // Splitting by '-' and taking the last part to remove "Bank - "
          // then trimming whitespace to get just the number
          if (detail.contains('-')) {
            _numberController.text = detail.split('-').last.trim();
          } else {
            _numberController.text = detail;
          }

          // Keep the cursor at the end of the text
          _numberController.selection = TextSelection.fromPosition(
            TextPosition(offset: _numberController.text.length),
          );
        });
      },
    );
  }

  Widget _bankListItem(String title, String branch, String assetPath) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16)),
              Row(
                children: [
                  Text("Branch Name: ",style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  Text(branch,
                      style: const TextStyle(color: Colors.grey, fontSize: 13)),
                ],
              ),
            ],
          ),

          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: Image.asset(
                assetPath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.account_balance, color: Colors.grey),
              ),
            ),
          )

        ],
      ),
    );
  }
}