import 'package:flutter/material.dart';
import 'package:smart_banking/core/theme/colors.dart';
import '../../../core/navigation/app_navigator.dart';

class AddMoneyScreen extends StatefulWidget {
  const AddMoneyScreen({super.key});

  @override
  State<AddMoneyScreen> createState() => _AddMoneyScreenState();
}

class _AddMoneyScreenState extends State<AddMoneyScreen> {
  // Top level selection (Bank to Ekpay vs Card to Ekpay)
  bool isBankToEkpay = true;

  // Source selection (Bank Account vs Internet Banking)
  int selectedSourceIndex = 0; // 0 for Bank Account, 1 for Internet Banking

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
          'Add Money',
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
            // 1. Top Selectable Cards (Bank to Ekpay / Card to Ekpay)
            Row(
              children: [
                Expanded(
                  child: _buildMainSelectableBox(
                    title: "Bank to Ekpay",
                    iconPath: "assets/add_money/bank_to_ekpay.png", // Path to your asset
                    isSelected: isBankToEkpay,
                    onTap: () => setState(() => isBankToEkpay = true),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildMainSelectableBox(
                    title: "Card to Ekpay",
                    iconPath: "assets/add_money/card_to_akpay.png", // Path to your asset
                    isSelected: !isBankToEkpay,
                    onTap: () => setState(() => isBankToEkpay = false),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
            // Centered Header
            SizedBox(
              width: double.infinity, child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Select Your Add Money Source",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            ),
            const SizedBox(height: 20),
            // 2. Horizontal Source Selection (Radio-style with Assets)
            // 2. Vertical Source Selection (Column-style)
            Column(
              children: [
                _buildSourceOption(
                  index: 0,
                  title: "Bank Account",
                  assetPath: "assets/menus/cash_in.png",
                ),
                const SizedBox(height: 12), // Vertical gap between items
                _buildSourceOption(
                  index: 1,
                  title: "Internet Banking",
                  assetPath: "assets/menus/add_money.png",
                ),
              ],
            ),

            const SizedBox(height: 40),

            // 3. Placeholder for the specific list content based on selection
            _buildSourceContent(),
          ],
        ),
      ),
    );
  }

  // Top Level Selectable Box (Same style as Cash Out)
  Widget _buildMainSelectableBox({
  required String title,
  required String iconPath,
  required bool isSelected,
  required VoidCallback onTap,
}) {
return GestureDetector(
onTap: onTap,
child: Container(
padding: const EdgeInsets.symmetric(vertical: 20),
decoration: BoxDecoration(
color: isSelected ? primaryColor : Colors.white,
borderRadius: BorderRadius.circular(12),
border: Border.all(color: primaryColor, width: 1.5),
),
child: Column(
children: [
Image.asset(
iconPath,
height: 32,
width: 32,
// Applies white if selected, otherwise uses the theme's primaryColor
color: isSelected ? Colors.white : primaryColor,
),
const SizedBox(height: 8),
Text(
title,
style: TextStyle(
color: isSelected ? Colors.white : primaryColor,
fontWeight: FontWeight.bold,
),
),
],
),
),
);
}
  // Source Option Row (Vertical selection with radio-circle at the right)
  Widget _buildSourceOption({
    required int index,
    required String title,
    required String assetPath,
  }) {
    bool isSelected = selectedSourceIndex == index;

    return GestureDetector(
      onTap: () => setState(() => selectedSourceIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey.shade200,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // 1. The Asset Icon (Left)
            Image.asset(assetPath, height: 28, width: 28),
            const SizedBox(width: 12),

            // 2. The Title (Center - Expanded to push radio to right)
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? primaryColor : Colors.black87,
                ),
              ),
            ),

            // 3. The Circle Radio Indicator (Right)
            Container(
              height: 22,
              width: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? primaryColor : Colors.grey.shade300,
                  width: 2,
                ),
                color: isSelected ? primaryColor : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // Dynamic Content based on selection
  Widget _buildSourceContent() {
    if (selectedSourceIndex == 0) {
      return const Center(child: Text("Linked Bank Accounts will appear here"));
    } else {
      return const Center(
          child: Text("Available Internet Banking portals will appear here"));
    }
  }
}