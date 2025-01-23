import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsiveness
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Privacy Policy',
          style: GoogleFonts.poppins(
            color: const Color(0xff3F3F3F),
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white, // Sets the background to pure white
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                'Effective Date: 27.12.2024',
                style: GoogleFonts.poppins(
                  fontSize: screenWidth < 600 ? 14 : 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              _sectionTitle('1. Introduction', screenWidth),
              _sectionBody(
                '• Welcome to SR FIRST AID HEALTH CARE PVT LTD. We are committed to protecting the privacy and confidentiality of our clients, partners, and website visitors. '
                '• This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you interact with our services.',
                screenWidth,
              ),
              const SizedBox(height: 16),
              _sectionTitle('2. Information We Collect', screenWidth),
              _sectionBody(
                '• Personal Information: Name, email address, phone number, job title, and company details.\n'
                '• Healthcare Data: Information relevant to hospital operations and healthcare consulting.\n'
                '• Technical Information: IP address, browser type, and analytics data from website usage.',
                screenWidth,
              ),
              const SizedBox(height: 16),
              _sectionTitle('3. How We Use Your Information', screenWidth),
              _sectionBody(
                '• To provide consulting services.\n'
                '• To communicate with you regarding inquiries or services.\n'
                '• To improve our services and website.\n'
                '• To comply with legal obligations.',
                screenWidth,
              ),
              const SizedBox(height: 16),
              _sectionTitle('4. Data Sharing and Disclosure', screenWidth),
              _sectionBody(
                '• We do not sell or rent your data to third parties.\n'
                '• However, we may share data with:\n'
                '  - Service providers assisting in our operations.\n'
                ' - Legal authorities if required by law.',
                screenWidth,
              ),
              const SizedBox(height: 16),
              _sectionTitle('5. Data Security', screenWidth),
              _sectionBody(
                '• We implement industry-standard security measures to protect your data from unauthorized access, alteration, or disclosure.',
                screenWidth,
              ),
              const SizedBox(height: 16),
              _sectionTitle('6. Data Retention', screenWidth),
              _sectionBody(
                '• We retain your data only as long as necessary to fulfil the purposes outlined in this policy or as required by law.',
                screenWidth,
              ),
              const SizedBox(height: 16),
              _sectionTitle('7. Your Rights', screenWidth),
              _sectionBody(
                '• You have the right to:\n'
                '  - Access your personal data.\n'
                '  - Request corrections to inaccurate data.\n'
                '  - Request deletion of your data.\n'
                '  - Withdraw consent for data processing.',
                screenWidth,
              ),
              const SizedBox(height: 16),
              _sectionTitle('8. Cookies and Tracking Technologies', screenWidth),
              _sectionBody(
                '• Our website may use cookies to enhance your browsing experience.\n'
                '• You can manage cookie preferences through your browser settings.',
                screenWidth,
              ),
              const SizedBox(height: 16),
              _sectionTitle('9. Changes to This Policy', screenWidth),
              _sectionBody(
                '• We may update this Privacy Policy periodically.\n'
                '• Any changes will be posted on this page with an updated effective date.',
                screenWidth,
              ),
              const SizedBox(height: 16),
              _sectionTitle('10. Contact Us', screenWidth),
              _sectionBody(
                '• SR FIRST AID HEALTH CARE PVT LTD\n'
                '17/305, FIRST FLOOR, THRIKKAKARA MUNICIPALITY,\n'
                'SEA PORT AIR PORT ROAD, CHITTETHUKARA,\n'
                'KAKKANAD, KOCHI, KERALA PIN  682030\n'
                'Email: info@srhealthcarecommunity.com\n'
                'Phone: 9447008356, 9447108356',
                screenWidth ,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, double screenWidth) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: screenWidth < 600 ? 14 : 16,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _sectionBody(String text, double screenWidth) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: screenWidth < 600 ? 14 : 16,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.start,
    );
  }
}
