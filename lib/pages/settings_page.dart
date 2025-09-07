import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  bool wifiOnly = false;

  Widget buildSettingTile({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.deepPurple.shade400),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ),
            trailing ??
                const Icon(Icons.arrow_forward_ios,
                    size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        elevation: 3,
        shadowColor: Colors.black26,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        children: [
          // 🔹 Reading Preferences
          buildSettingTile(
            icon: Icons.chrome_reader_mode,
            title: 'Reading Mode',
            onTap: () {},
          ),

          buildSettingTile(
            icon: Icons.file_download,
            title: 'Download Preferences',
            trailing: Switch(
              value: wifiOnly,
              onChanged: (value) {
                setState(() {
                  wifiOnly = value;
                });
              },
              activeColor: Colors.deepPurple,
            ),
          ),

          buildSettingTile(
            icon: Icons.dark_mode,
            title: 'Dark Mode',
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
              activeColor: Colors.deepPurple,
            ),
          ),

          // 🔹 Notifications & Storage
          buildSettingTile(
            icon: Icons.notifications_active,
            title: 'Notifications',
            onTap: () {},
          ),
          buildSettingTile(
            icon: Icons.storage,
            title: 'Storage Settings',
            onTap: () {},
          ),

          // 🔹 Help & Info
          buildSettingTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {},
          ),
          buildSettingTile(
            icon: Icons.privacy_tip,
            title: 'Terms & Privacy',
            onTap: () {},
          ),
          buildSettingTile(
            icon: Icons.info_outline,
            title: 'About Manga App',
            onTap: () {},
          ),

          // 🔹 Logout
          buildSettingTile(
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
