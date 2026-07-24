import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_components.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              CircleAvatar(
                radius: screenHeight * 0.1,
                backgroundColor: const Color(0xFFEFEEFF),
                child: const Icon(
                  Icons.phone_android,
                  size: 70,
                  color: Color(0xFF6C63FF),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              const Text(
                'Manage your\nprofile easily',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2D2D),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'All your information in one place.\nKeep track and update anytime.',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              const Spacer(),
              CustomPurpleButton(
                text: 'Continue',
                onPressed: () => context.go('/profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}