import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/const/colors.dart';

class AboutProfilePage extends StatelessWidget {
  const AboutProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'About Profile',
          style: GoogleFonts.poppins(
            color: const Color(0xff3F3F3F),
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dr. Manish Rajput',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 15),
            _infoRow('Joined SR Healthcare Community', 'July, 2024'),
            // const Divider(thickness: 1, color: Colors.grey),
            _infoRow('Contact Information', '2 Months Ago Updated'),
            // const Divider(thickness: 1, color: Colors.grey),
            _infoRow('Profile Photo', '2 Months Ago Updated'),
            // const Divider(thickness: 1, color: Colors.grey),
            _infoRow('Verification', 'July, 2024'),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
                fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w400),
          ),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AboutProfilePage(),
  ));
}
