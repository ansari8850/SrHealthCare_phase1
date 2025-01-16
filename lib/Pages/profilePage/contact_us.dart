import 'package:flutter/material.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/text.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  // Function to launch phone dialer
  void _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    // if (await canLaunchUrl(phoneUri)) { 
      await launchUrl(phoneUri);
    // } else {
    //   throw 'Could not launch $phoneNumber';
    // }
  }

  // Function to launch email app
  void _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    // if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    // } else {
    //   throw 'Could not launch $email';
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        centerTitle: false,
        title: const CustomText(
          text: 'Contact Us',
          size: 20,
          color: Color(0xff3F3F3F),
          weight: FontWeight.w500,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Image.asset('assets/profile/us.png'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      color: blackColor, borderRadius: BorderRadius.circular(2)),
                  child: Icon(
                    Icons.call,
                    color: whiteColor,
                    size: 18,
                  ),
                ),
                CustomText(
                  text: 'Want to Contact Us?',
                  size: 16,
                  color: blackColor,
                  weight: FontWeight.w500,
                ),
              ],
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _launchEmail('support@srhealthcarecommunity.com'),
                      child: Column(
                        children: [
                          CustomText(
                            text: 'Email:',
                            size: 14,
                            color: blackColor,
                            weight: FontWeight.w400,
                          ),
                          CustomText(
                            text: 'support@srhealthcarecommunity.com',
                            size: 14,
                            color: buttonColor,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _launchPhone('+919447008356'),
                      child: Column(
                        children: [
                          CustomText(
                            text: 'Phone Number:',
                            size: 14,
                            color: blackColor,
                            weight: FontWeight.w400,
                          ),
                          CustomText(
                            text: '+91 94470 08356',
                            size: 14,
                            color: buttonColor,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
