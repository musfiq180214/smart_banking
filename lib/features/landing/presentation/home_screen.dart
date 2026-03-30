import 'package:flutter/material.dart';
import '../../../core/navigation/app_navigator.dart';
import '../../../core/navigation/route_names.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/custom_dialog.dart';
import '../../../core/utils/enums.dart';
import '../../../core/utils/helper.dart';
import '../../../core/widgets/language_switch.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Add this

  // State variables to track expansion
  bool _isServicesExpanded = false;
  bool _isPayBillExpanded = false;
  bool _isRemittanceExpanded = false;
  bool _isBalanceVisible = false; // Add this line
  Widget _buildSideDrawer() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              // Drawer Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "ePay Menu",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Language Switcher Toggle aligned to the left
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: LanguageToggle(),
                    ),
                  ],
                ),
              ),
              const Divider(),
              // Menu Items
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _drawerItem(Icons.home, context.t.home),
                    _drawerItem(Icons.person, "Profile"),
                    _drawerItem(Icons.receipt_long, "Statements"),
                    _drawerItem(Icons.speed, "Limits"),
                    _drawerItem(Icons.confirmation_number, "Coupons"),
                    _drawerItem(Icons.stars, "Points"),
                    _drawerItem(Icons.edit_note, "Information Update"),
                    _drawerItem(Icons.settings, "Settings"),
                    _drawerItem(Icons.group_add, "Nominee Update"),
                    _drawerItem(Icons.support_agent, "Support"),
                    _drawerItem(Icons.share, "Refer ekPay App"),
                    const Divider(),
                    _drawerItem(Icons.logout, "Logout", isLogout: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : primaryColor),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.red : primaryColor, // Logout text red for clarity
          fontWeight: isLogout ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        Navigator.pop(context); // Close drawer
        if (isLogout) {
          // Navigate to Login Screen
          AppNavigator.goTo(RouteNames.login);
        } else {
          showCustomSnackBar(
            context,
            message: "$title clicked",
            type: MessageType.success,
          );

        }
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildSideDrawer(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header with Blue background transition
            _buildHeader(),
            _buildBalanceCard(),

            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  _buildMenuGrid(
                    [
                      _MenuData("Cash In", "assets/menus/cash_in.png"),
                      _MenuData("Cash Out", "assets/menus/cash_out.png"),
                      _MenuData("Add Money", "assets/menus/add_money.png"),
                      _MenuData("Send Money", "assets/menus/send_money.png"),
                      _MenuData(
                          "Mobile Recharge", "assets/menus/mobile_recharge.png"),
                      _MenuData("MRT Recharge", "assets/menus/mrt.png"),
                      _MenuData("Make Payment", "assets/menus/make_payment.png"),
                      _MenuData("Express Card", "assets/menus/express.png"),
                      _MenuData("Self Bill", "assets/menus/cash_in.png"),
                      _MenuData("Donation", "assets/menus/cash_in.png"),
                      _MenuData("Insurance", "assets/menus/cash_in.png"),
                    ],
                    _isServicesExpanded,
                  ),
                  _buildToggleButton(
                    _isServicesExpanded,
                        () =>
                        setState(() =>
                        _isServicesExpanded = !_isServicesExpanded),
                  ),

                  const SizedBox(height: 24),

                  // 3. Pay Bill Section
                  _buildSectionHeader("Pay Bill"),
                  _buildMenuGrid(
                    [
                      _MenuData("Electricity", "assets/menus/electricity.png"),
                      _MenuData("Gas", "assets/menus/gas.png"),
                      _MenuData("Water", "assets/menus/water.png"),
                      _MenuData("Internet", "assets/menus/internet.png"),
                      _MenuData("Telephone", "assets/menus/telephone.png"),
                      _MenuData("Credit Card", "assets/menus/card.png"),
                      _MenuData("Govt Fees", "assets/menus/cash.png"),
                      _MenuData("Cable TV", "assets/menus/cable.png"),
                      _MenuData("Education", "assets/menus/electricity.png"),
                      _MenuData("Hotel", "assets/menus/electricity.png"),
                      _MenuData("Ticket", "assets/menus/electricity.png"),
                    ],
                    _isPayBillExpanded,
                  ),
                  _buildToggleButton(
                    _isPayBillExpanded,
                        () =>
                        setState(() => _isPayBillExpanded = !_isPayBillExpanded),
                  ),

                  const SizedBox(height: 24),

                  // 4. Remittance Section
                  _buildSectionHeader("Remittance"),
                  _buildMenuGrid(
                    [
                      _MenuData("Payoneer", "assets/remittance/pioneer.png"),
                      _MenuData("Paypal", "assets/remittance/paypal.png"),
                      _MenuData("Wind", "assets/remittance/wind.png"),
                      _MenuData("Wise", "assets/remittance/wise.png")
                    ],
                    _isRemittanceExpanded,
                  ),
                  // Only show button if there are more than 8 items
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- UI Helpers ---

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 60, 16, 40), // Increased bottom padding
      decoration: const BoxDecoration(color: primaryColor,
        // No border radius here makes the line perfectly straight
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => _scaffoldKey.currentState?.openDrawer(), // Open Drawer
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    "assets/profile.png",
                    height: 48,
                    width: 48,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "Musfiqur Rahman",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.emoji_events, color: Colors.amber, size: 20),
                SizedBox(width: 6),
                Text(
                  "1972 Points",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      // Added margin to match design
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "Your Balance",
            style: TextStyle(
              color: primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _isBalanceVisible ? "TK 13,999.00" : "TK ••••••••",
                style: const TextStyle(
                  color: primaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isBalanceVisible = !_isBalanceVisible;
                  });
                },
                child: Icon(
                  _isBalanceVisible ? Icons.visibility : Icons.visibility_off,
                  color: primaryColor,
                  size: 22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      // Adding a small bottom padding to the header for tight spacing
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildMenuGrid(List<_MenuData> items, bool isExpanded) {
    int displayCount = isExpanded ? items.length : (items.length > 8 ? 8 : items.length);

    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 0,
        crossAxisSpacing: 10,
        childAspectRatio: 0.85,
      ),
      itemCount: displayCount,
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () {
            if (item.title == "Cash Out") {
              AppNavigator.pushTo(RouteNames.cash_out);
            }else if (item.title == "Add Money") {
              AppNavigator.pushTo(RouteNames.add_money);
            }
            else if (item.title == "Send Money") {
              AppNavigator.pushTo(RouteNames.send_money);
            }
            else {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(content: Text("${item.title} clicked")),
              // );
              showCustomSnackBar(context, message: "${item.title} clicked", type: MessageType.success);
            }
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(item.imagePath, height: 60, width: 60),
              ),
              const SizedBox(height: 4),
              Text(
                item.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildToggleButton(bool isExpanded, VoidCallback onTap) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          elevation: 0,
        ),
        onPressed: onTap,
        child: Text(
          isExpanded ? "See Less" : "See More",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ),
    );
  }
}

class _MenuData {
  final String title;
  final String imagePath;

  _MenuData(this.title, this.imagePath);
}