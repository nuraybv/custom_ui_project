import 'package:flutter/material.dart';

// Custom Purple Button
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
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: double.infinity,
      height: screenHeight * 0.065, // Responsiv hündürlük
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6C63FF),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// Menu Row Widget
class MenuRowWidget extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final VoidCallback onTap;

  const MenuRowWidget({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(leadingIcon, color: const Color(0xFF2D2D2D)),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Color(0xFF2D2D2D),
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    );
  }
}

// Custom Input Field
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
          filled: true,
          fillColor: const Color(0xFFF1F3F5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}