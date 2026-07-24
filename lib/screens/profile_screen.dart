import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: screenHeight * 0.06,
                backgroundColor: const Color(0xFF6C63FF),
              ),
              SizedBox(height: screenHeight * 0.02),
              const Text(
                'Fuad Aliyev',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Text(
                'fuad.aliyev@gmail.com',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: screenHeight * 0.03),
              CustomPurpleButton(
                text: 'Go to Settings',
                onPressed: () => context.push('/settings'), // push naviqasiya yığınını saxlayır
              ),
            ],
          ),
        ),
      ),
    );
  }
}