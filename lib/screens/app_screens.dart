import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_components.dart'; // Widget-ləri bura bağlayırıq

// SCREEN 1: Onboarding
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const CircleAvatar(
              radius: 90,
              backgroundColor: Color(0xFFEFEEFF),
              child: Icon(Icons.phone_android, size: 80, color: Color(0xFF6C63FF)),
            ),
            const SizedBox(height: 40),
            const Text(
              'Manage your\nprofile easily',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF2D2D2D)),
            ),
            const SizedBox(height: 16),
            const Text(
              'All your information in one place.\nKeep track and update anytime.',
              textAlign: TextAlign.center,
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
    );
  }
}

// SCREEN 2: Profile
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true, elevation: 0, backgroundColor: Colors.transparent, foregroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const CircleAvatar(radius: 50, backgroundColor: Color(0xFF6C63FF)),
            const SizedBox(height: 15),
            const Text('Fuad Aliyev', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text('fuad.aliyev@gmail.com', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 25),
            CustomPurpleButton(
              text: 'Go to Settings',
              onPressed: () => context.go('/settings'),
            ),
          ],
        ),
      ),
    );
  }
}

// SCREEN 3: Settings
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), centerTitle: true, elevation: 0, backgroundColor: Colors.transparent, foregroundColor: Colors.black),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'ACCOUNT',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            ),
          ),
          MenuRowWidget(
            leadingIcon: Icons.lock_outline,
            title: 'Privacy',
            onTap: () {},
          ),
          MenuRowWidget(
            leadingIcon: Icons.security,
            title: 'Security',
            onTap: () {},
          ),
          MenuRowWidget(
            leadingIcon: Icons.person_outline,
            title: 'Edit Profile Information',
            onTap: () => context.go('/edit-profile'),
          ),
        ],
      ),
    );
  }
}

// SCREEN 4: Edit Profile
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile'), centerTitle: true, elevation: 0, backgroundColor: Colors.transparent, foregroundColor: Colors.black),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const CustomInputField(label: 'Full Name', initialValue: 'Fuad Aliyev'),
            const CustomInputField(label: 'Email', initialValue: 'fuad.aliyev@gmail.com'),
            const Spacer(),
            CustomPurpleButton(
              text: 'Save Changes',
              onPressed: () => context.go('/'),
            ),
          ],
        ),
      ),
    );
  }
}