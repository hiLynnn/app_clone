import 'package:app_clone/core/common/utils/app_string.dart';
import 'package:app_clone/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final str = AppString.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          _buildHeader(str),
          const SizedBox(height: 20),
          _buildMenuList(context, str),
        ],
      ),
    );
  }

  // ---------------- HEADER BLUE ----------------
  Widget _buildHeader(AppLocalizations str) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, bottom: 30),
      decoration: const BoxDecoration(
        color: Color(0xFF1877F2),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage("https://i.pravatar.cc/300?img=12"),
          ),
          const SizedBox(height: 12),

          Text(
            str.profile_username,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 6),
          Text(
            str.profile_email,
            style: const TextStyle(fontSize: 15, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  // ---------------- MENU LIST ----------------
  Widget _buildMenuList(BuildContext context, AppLocalizations str) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          _menuItem(
            icon: Icons.settings,
            labelKr: str.profile_edit_info,
            onTap: () {},
          ),
          _menuItem(
            icon: Icons.mail,
            labelKr: str.profile_inbox,
            badge: 2,
            onTap: () {},
          ),
          _menuItem(
            icon: Icons.description,
            labelKr: str.profile_contract,
            onTap: () {},
          ),
          _menuItem(
            icon: Icons.logout,
            labelKr: str.profile_logout,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // ---------------- MENU ITEM ----------------
  Widget _menuItem({
    required IconData icon,
    required String labelKr,
    VoidCallback? onTap,
    int badge = 0,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                Icon(icon, size: 30, color: Colors.blue),
                if (badge > 0)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        badge.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    labelKr,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(Icons.chevron_right, size: 26, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
