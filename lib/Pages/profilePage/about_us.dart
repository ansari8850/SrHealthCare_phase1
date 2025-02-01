import 'package:flutter/material.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/text.dart';
import 'package:url_launcher/url_launcher.dart'; // To open URLs in browser

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  // Function to open URL in browser
  void _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        centerTitle: false,
        title: CustomText(text: 'About Us', size: 16, color: blackColor, weight: FontWeight.w500),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Our Mobile Application for SR Healthcare Community',
              size: 14,
              color: blackColor,
              weight: FontWeight.w500,
            ),
            const SizedBox(height: 16),
            CustomText(
              text: '• Social network connecting medical & healthcare professionals',
              size: 12,
              color: blackColor,
              weight: FontWeight.w400,
            ),
            const SizedBox(height: 8),
            CustomText(
              text: '• Knowledge hub for students, professors, doctors and others',
              size: 12,
              color: blackColor,
              weight: FontWeight.w400,
            ),
            const SizedBox(height: 8),
            CustomText(
              text: '• Informative blogs, trending updates, and expert discussion panels',
              size: 12,
              color: blackColor,
              weight: FontWeight.w400,
            ),
            const SizedBox(height: 8),
            CustomText(
              text: '• Job search and opportunity postings platform',
              size: 12,
              color: blackColor,
              weight: FontWeight.w400,
            ),
            const SizedBox(height: 8),
            CustomText(
              text: '• Expert-led query resolution at your fingertips',
              size: 12,
              color: blackColor,
              weight: FontWeight.w400,
            ),
            const SizedBox(height: 8),
            CustomText(
              text: '• Access to live and recorded seminars on-demand',
              size: 12,
              color: blackColor,
              weight: FontWeight.w400,
            ),
            Spacer(),
            Center(
              child: GestureDetector(
                onTap: () => _openUrl('https://www.srhealthcarecommunity.com/'), // Replace with your desired URL
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomText(
                    text: 'Visit Website',
                    size: 16,
                    color: Colors.white,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
