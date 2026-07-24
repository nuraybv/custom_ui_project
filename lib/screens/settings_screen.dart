import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_components.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: ListView(
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
              onTap: () => context.push('/edit-profile'), // push naviqasiya yığınını saxlayır
            ),
          ],
        ),
      ),
    );
  }
}