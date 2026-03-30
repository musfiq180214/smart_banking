import 'package:flutter/material.dart';
import 'package:smart_banking/core/theme/colors.dart';

import '../../../core/navigation/app_navigator.dart';

class CashOutScreen extends StatefulWidget {
  const CashOutScreen({super.key});

  @override
  State<CashOutScreen> createState() => _CashOutScreenState();
}

class _CashOutScreenState extends State<CashOutScreen> {
  bool isAgentSelected = true; // Initial state: Agent selected

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
          'Cash Out',
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
            // Selection Row (Agent vs ATM)
            // Selection Row (Agent vs ATM)
            Row(
              children: [
                Expanded(
                  child: _buildSelectableBox(title: "Agent",
                    assetPath: "assets/cash_out/agent.png", // Update with your local path
                    isSelected: isAgentSelected,
                    onTap: () => setState(() => isAgentSelected = true),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildSelectableBox(
                    title: "ATM",
                    assetPath: "assets/cash_out/ATM.png", // Update with your local path
                    isSelected: !isAgentSelected,
                    onTap: () => setState(() => isAgentSelected = false),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // Conditional Content
            isAgentSelected ? _buildAgentView() : _buildAtmView(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Did you face any issue? ",
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
            GestureDetector(
              onTap: () {
                // Add your contact/support navigation logic here
              },
              child: const Text(
                "Contact Us",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Common Selectable Box Component
  // Common Selectable Box Component with Asset Images
  Widget _buildSelectableBox({
    required String title,
    required String assetPath, // Changed from IconData
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: primaryColor, width: 1.5),
        ),
        child: Column(
          children: [
            // Using Image.asset instead of Icon
            Image.asset(
              assetPath,
              height: 24, // Matches standard icon size
              width: 24,
              color: isSelected ? Colors.white : primaryColor, // Tints the asset
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.image_not_supported,
                color: isSelected ? Colors.white : primaryColor,
              ),
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
  // --- AGENT VIEW ---
  Widget _buildAgentView() {
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
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Input Agent Number",
              hintStyle: TextStyle(color: Colors.grey),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.chevron_right, color: primaryColor),
                  const SizedBox(width: 10),
                  Icon(
                      Icons.contact_page_outlined, color: primaryColor),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // QR Code Button
        // QR Code Button
        SizedBox(width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.qr_code_scanner, size: 20),
            label: const Text("Tap to Scan QR Code"),
            style: OutlinedButton.styleFrom(
              foregroundColor: primaryColor,
              // Increased width from 1.0 (default) to 2.0 or 2.5 for a bolder look
              side: const BorderSide(color: primaryColor, width: 2.0),
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                // 100 ensures it stays perfectly circular/pill-shaped regardless of height
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ),
        const SizedBox(height: 25),

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Available Balance: ",
                style: TextStyle(color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              const Text(
                "139,999 TK",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),

        // NEW SEARCH INPUT FIELD
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: "Search for Partner Bank",
              hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),

            ),
          ),
        ),
        const Divider(height: 20),

        // Bank List
        _bankListItem("Basic Bank", "Dhanmondi", "assets/banks/bank_1.png"),
        _bankListItem("Brack Bangla", "Gulshan", "assets/banks/bank_2.png"),
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
    return ListTile(contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.blue.shade50,

        // Or keep the letter-based profile icon:
        child: Icon(Icons.person, color: Colors.grey)
      ),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
      subtitle: Text(
        detail,
        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
      ),
      // trailing: const Icon(
      //     Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      onTap: () {
        // Add navigation or selection logic here
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