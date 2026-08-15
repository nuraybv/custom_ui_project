import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool pushNotifications = true;
  bool emailNotifications = false;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('PREFERENCES', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.notifications_outlined, color: Colors.deepPurple),
                  title: const Text('Push Notifications', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  value: pushNotifications,
                  activeThumbColor: Colors.deepPurple,
                  onChanged: (val) => setState(() => pushNotifications = val),
                ),
                const Divider(height: 1, indent: 50, endIndent: 16),
                SwitchListTile(
                  secondary: const Icon(Icons.email_outlined, color: Colors.deepPurple),
                  title: const Text('Email Notifications', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  value: emailNotifications,
                  activeThumbColor: Colors.deepPurple,
                  onChanged: (val) => setState(() => emailNotifications = val),
                ),
                const Divider(height: 1, indent: 50, endIndent: 16),
                SwitchListTile(
                  secondary: const Icon(Icons.dark_mode_outlined, color: Colors.deepPurple),
                  title: const Text('Dark Mode', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  value: darkMode,
                  activeThumbColor: Colors.deepPurple,
                  onChanged: (val) => setState(() => darkMode = val),
                ),
                const Divider(height: 1, indent: 50, endIndent: 16),
                ListTile(
                  leading: const Icon(Icons.language, color: Colors.deepPurple),
                  title: const Text('Language', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  trailing: Text('English', style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('ACCOUNT', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
            child: Column(
              children: [
                _buildSettingsItem(Icons.lock_outline, 'Privacy', () {}),
                const Divider(height: 1, indent: 50, endIndent: 16),
                _buildSettingsItem(Icons.security_outlined, 'Security', () {}),
                const Divider(height: 1, indent: 50, endIndent: 16),
                _buildSettingsItem(Icons.block, 'Blocked Users', () {}),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('MORE', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color: Colors.grey.shade200)),
            child: Column(
              children: [
                _buildSettingsItem(Icons.help_outline, 'Help & Support', () {}),
                const Divider(height: 1, indent: 50, endIndent: 16),
                _buildSettingsItem(Icons.info_outline, 'About App', () {}),
                const Divider(height: 1, indent: 50, endIndent: 16),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text('Logout', style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.w500)),
                  onTap: () async {
                    try {
                      final authService = Provider.of<AuthService>(context, listen: false);
                      await authService.logout();

                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                          (route) => false,
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Logout failed: $e')),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple, size: 22),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      onTap: onTap,
    );
  }
}