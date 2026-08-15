import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'settings_screen.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // AuthService-i dinləyirik ki, daxil olan istifadəçi dəyişdikdə yenilənsin
    final authService = Provider.of<AuthService>(context);
    final userEmail = authService.currentUserEmail ?? 'user@example.com';
    final userName = userEmail.split('@')[0]; // E-poçtdan istifadəçi adı düzəldirik

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profil şəkli və dinamik məlumatlar
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.deepPurple,
                  child: Icon(Icons.person, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 12),
                Text(
                  userName.toUpperCase(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  userEmail,
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Statistika kartları
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatCard('24', 'Expenses'),
              _buildStatCard('128', 'Categories'),
              _buildStatCard('7', 'Goals'),
            ],
          ),
          const SizedBox(height: 24),

          // Menyu siyahısı
          const Text('Menu', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                _buildMenuItem(Icons.receipt_long, 'My Activity', () {}),
                _buildDivider(),
                _buildMenuItem(Icons.bookmark_border, 'Saved Items', () {}),
                _buildDivider(),
                _buildMenuItem(Icons.folder_outlined, 'My Projects', () {}),
                _buildDivider(),
                _buildMenuItem(Icons.message_outlined, 'Messages', () {}),
                _buildDivider(),
                _buildMenuItem(Icons.notifications_outlined, 'Notifications', () {}),
                _buildDivider(),
                _buildMenuItem(Icons.security, 'Privacy & Security', () {}),
                _buildDivider(),
                _buildMenuItem(Icons.help_outline, 'Help & Support', () {}),
                _buildDivider(),
                _buildMenuItem(Icons.info_outline, 'About App', () {}),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 🚪 Log Out Düyməsi
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade50,
                foregroundColor: Colors.red,
                elevation: 0,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                try {
                  final authSrv = Provider.of<AuthService>(context, listen: false);
                  await authSrv.logout();

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
              icon: const Icon(Icons.logout),
              label: const Text('Log Out', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStatCard(String count, String label) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Text(count, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple, size: 22),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, indent: 50, endIndent: 16);
  }
}