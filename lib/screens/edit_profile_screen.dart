import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/custom_components.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
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
              const CustomInputField(
                label: 'Full Name',
                initialValue: 'Fuad Aliyev',
              ),
              const CustomInputField(
                label: 'Email',
                initialValue: 'fuad.aliyev@gmail.com',
              ),
              const Spacer(),
              CustomPurpleButton(
                text: 'Save Changes',
                onPressed: () => context.pop(), // pop edilərək geri qayıdır
              ),
            ],
          ),
        ),
      ),
    );
  }
}