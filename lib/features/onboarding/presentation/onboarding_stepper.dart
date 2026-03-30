import 'package:flutter/material.dart';
import '../../../core/navigation/app_navigator.dart';
import '../../../core/navigation/route_names.dart';
import '../../../core/theme/colors.dart';
import '../../../core/widgets/global_appbar.dart'; // Assuming primaryColor (blue) is here

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;

  // Data for each step
  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/onboarding/step1.png",
      "title": "Trusted by millions an essential part of your Financial journey",
      "subtitle": "Easily transfer money to any bank account or wallet with just a few taps.",
      "stageIcon": "assets/onboarding/step1.png"
    },
    {
      "image": "assets/onboarding/step_2.png",
      "title": "Pay all Bills in Bangladesh in hassle Free",
      "subtitle": "Pay utility bills, mobile recharge, and more instantly without any hassle.",
      "stageIcon": "assets/onboarding/step_2.png"
    },
    {
      "image": "assets/onboarding/step_3.png",
      "title": "Reliable and secure money transaction over the world",
      "subtitle": "Keep a close eye on your finances with our smart transaction history.",
      "stageIcon": "assets/onboarding/step_3.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const GlobalAppBar(
        title: "",
        canGoBack: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            children: [




              // 2. Centered Image for the CURRENT step
              Image.asset(
                onboardingData[currentIndex]["image"]!,
                height: 250,
                fit: BoxFit.contain,
              ),

              const Spacer(),

              // 3. Three Dot Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return _buildDot(isActive: currentIndex == index);
                }),
              ),
              const SizedBox(height: 30),

              // 4. Text Content
              Text(
                onboardingData[currentIndex]["title"]!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const Spacer(),

              // 5. Next Button logic updated for Navigation
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (currentIndex < 2) {
                      setState(() {
                        currentIndex++;
                      });
                    } else {
                      // Navigate to Onboarding (Login/Signup) on last step
                      AppNavigator.goTo(RouteNames.login);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    currentIndex == 2 ? "Get Started" : "Next",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // 6. Skip Button updated for Navigation
              TextButton(
                onPressed: () {
                  // Navigate directly when skip is pressed
                  AppNavigator.goTo(RouteNames.login);
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStageImage(String path, bool isActive) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? primaryColor.withOpacity(0.1) : Colors.transparent,
        border: Border.all(
          color: isActive ? primaryColor : Colors.grey.shade200,
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Image.asset(
          path,
          color: isActive ? primaryColor : Colors.grey,
        ),
      ),
    );
  }

  Widget _buildDot({required bool isActive}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isActive ? 24 : 8,
      // Transitional "Pill" effect
      decoration: BoxDecoration(
        color: isActive ? primaryColor : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}