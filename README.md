import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// --- NAVİQASİYA AYARLARI ---
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/edit-profile',
      builder: (context, state) => const EditProfileScreen(),
    ),
  ],
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),
    );
  }
}

// ==========================================
// KONTROL 5: REUSABLE CUSTOM WIDGETS (Yenidən İstifadə Olunan Widget-lər)
// ==========================================

// 1. Dizayndakı Bənövşəyi Əsas Düymə
class CustomPurpleButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomPurpleButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6C63FF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 0,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}

// 2. Settings Ekranındakı Menyu Sətirləri
class MenuRowWidget extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final String? trailingText;
  final VoidCallback onTap;

  const MenuRowWidget({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.trailingText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(leadingIcon, color: Colors.grey[700]),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null)
            Text(trailingText!, style: TextStyle(color: Colors.grey[500])),
          const SizedBox(width: 5),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}

// 3. Edit Profile Ekranındakı Məlumat Daxiletmə Sahələri
class CustomInputField extends StatelessWidget {
  final String label;
  final String initialValue;

  const CustomInputField({
    super.key,
    required this.label,
    required this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// EKRANLAR (SCREENS) - Dizayn Referansına Uyğun Skelet
// ==========================================

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
            // Reusable düyməmizi işlədirik
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
        padding: const EdgeInsets.all(16.0),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
            child: Text('ACCOUNT'),
          ),
          // Reusable menyu sətirlərimizi işlədirik
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
            // Reusable daxiletmə sahələrimizi işlədirik
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