import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/const/colors.dart';

class ProfileVisibilityScreen extends StatefulWidget {
  const ProfileVisibilityScreen({super.key});

  @override
  State<ProfileVisibilityScreen> createState() =>
      _ProfileVisibilityScreenState();
}

class _ProfileVisibilityScreenState extends State<ProfileVisibilityScreen> {
  bool isPrivateProfile = false; // State for Private Profile toggle
  bool isSearchPrivacy = false; // State for Search Privacy toggle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Profile Visibility",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Manage How Your Profile Can Be Viewed On And Off",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            _buildToggleTile(
              title: "Private Profile",
              description:
                  "When enabled, your profile will be visible only to people you approve. Others will not be able to view your details or activity.",
              value: isPrivateProfile,
              onChanged: (bool value) {
                setState(() {
                  isPrivateProfile = value;
                });
              },
            ),
            const SizedBox(height: 20),
            _buildToggleTile(
              title: "Search Privacy",
              description:
                  "When enabled, your profile and activity will not appear in search results. Only people you share your profile with directly will be able to find you.",
              value: isSearchPrivacy,
              onChanged: (bool value) {
                setState(() {
                  isSearchPrivacy = value;
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildToggleTile({
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      // padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        // border: Border.all(color: Colors.grey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                      height: 1.4),
                ),
              ],
            ),
          ),
          SizedBox(width: 10,),
          Switch(
            value: value,
            inactiveTrackColor: Colors.white,
            activeColor: const Color(0xff6656E0),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
