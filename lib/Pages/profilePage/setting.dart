import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/CustomWidget/app_cache_network_image.dart';
import 'package:sr_health_care/Pages/authPages/login_pages.dart';
import 'package:sr_health_care/Pages/profilePage/about_us.dart';
import 'package:sr_health_care/Pages/profilePage/contact_us.dart';
import 'package:sr_health_care/Pages/profilePage/my_followers.dart';
import 'package:sr_health_care/Pages/profilePage/profile_update.dart';
import 'package:sr_health_care/Pages/profilePage/profile_visibility.dart';
import 'package:sr_health_care/Pages/profilePage/save_post.dart';
import 'package:sr_health_care/Pages/profilePage/terms.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/sharedference.dart';
import 'package:sr_health_care/services/api_services.dart';
import 'package:sr_health_care/services/share_plus_service.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key, required this.onUpdate});
  final void Function() onUpdate;

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
          child: _buildProfileHeader(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            // borderRadius: BorderRadius.circular(16),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withValues(alpha:0.2),
            //     spreadRadius: 1,
            //     blurRadius: 8,
            //     offset: const Offset(0, 3),
            //   ),
            // ],
          ),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              _buildMenuItems(context),
              SizedBox(
                height: 20,
              ),
              // const Spacer(),
              _buildLogoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // Profile Header with Icon
  Widget _buildProfileHeader() {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: AppCacheNetworkImage(
        imageUrl: SharedPreferenceHelper().getUserData()?.photo?.url ?? '',
        height: 60,
        width: 60,
        borderRadius: 50,
      ),
      title: Text(
        '${SharedPreferenceHelper().getUserData()?.name ?? ''}  ${SharedPreferenceHelper().getUserData()?.lastName ?? ''}',
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
      ),
      subtitle: Text(
        SharedPreferenceHelper().getUserData()?.email ?? '',
        style: GoogleFonts.poppins(
            fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w400),
      ),
      trailing: GestureDetector(
        onTap: () {
          Get.to(const ProfilePage())?.then((_) {
            widget.onUpdate();
            setState(() {});
          });
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Edit',
              style: GoogleFonts.poppins(color: buttonColor, fontSize: 14),
            ),
            const SizedBox(width: 4),
            Icon(Icons.edit, color: buttonColor, size: 15),
          ],
        ),
      ),
    );
  }

  // Menu Items List
  Widget _buildMenuItems(BuildContext context) {
    return Column(
      children: [
        _buildMenuItem('assets/profile/profilevi.png', 'Profile Visibility',
            () {
          Get.to(const ProfileVisibilityScreen());
          // Navigate to NotificationPage when Profile Visibility is tapped
        }),
        _buildMenuItem('assets/profile/save.png', 'Saved Posts', () {
          Get.to(const SavedPostsPage());
          // Add functionality here if needed
        }),
        _buildMenuItem('assets/profile/aboutus.png', 'About us', () {
          // Add functionality here if needed
          Get.to(AboutUs());
        }),
        _buildMenuItem('assets/profile/followers.png', 'My followers', () {
          Get.to(const FollowersPage());
          // Add functionality here if needed
        }),
        _buildMenuItem('assets/profile/share.png', 'Share the app', () {
          ShareService()
              .shareText('Hello This Is Sr Health Care App, Download Now');
          log('you have tap this button');
        }),
        _buildMenuItem('assets/profile/contactus.png', 'Contact Us', () {
          // Add functionality here if needed
          Get.to(const ContactUs());
        }),
        // _buildMenuItem('assets/profile/help.png', 'Help & Support', () {
        //   // Add functionality here if needed
        //   Get.to(HelpAndSupportPage());
        // }),
        _buildMenuItem('assets/profile/terms.png', 'Privacy Policies', () {
          // Add functionality here if needed
          Get.to(const PrivacyPolicyPage());
        }),
      ],
    );
  }

  // Individual Menu Item
  Widget _buildMenuItem(String icon, String title, VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(
        icon,
        height: 20,
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),
      ),
      trailing: Image.asset(
        'assets/profile/forward.png',
        height: 20,
      ),
      onTap: onTap,
    );
  }

  // Logout Button

  Widget _buildLogoutButton(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(
        'assets/profile/logout.png',
        height: 20,
      ),
      title: Text(
        'Log Out',
        style: GoogleFonts.poppins(
            color: Colors.red, fontSize: 16, fontWeight: FontWeight.w500),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.white,
              title: Center(
                child: Text(
                  'Are You Sure?',
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'You Want To Logout',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  // SizedBox(height: 20),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          // Add your logout logic here
                          Navigator.pop(context); // Close the dialog
                          final apiService = ApiService();
                          apiService.logout();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPages()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Logged out successfully!')),
                          );
                        },
                        child: Text(
                          'Logout',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// Notification Page
