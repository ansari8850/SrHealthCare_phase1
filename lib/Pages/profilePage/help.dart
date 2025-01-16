import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/Pages/profilePage/manage.dart';

class HelpAndSupportPage extends StatelessWidget {
  final List<Map<String, dynamic>> topics = [
    {'title': 'Getting Started', 'page': null},
    {'title': 'Managing Your Account', 'page': const ManagingAccountPage()},
    {'title': 'Posting Content', 'page': null},
    {'title': 'Exploring Posts', 'page': null},
    {'title': 'Interacting with Content', 'page': null},
    {'title': 'Notifications and Alerts', 'page': null},
    {'title': 'Events', 'page': null},
    {'title': 'Job Application', 'page': null},
    {'title': 'Privacy And Security', 'page': null},
    {'title': 'Contacting Support', 'page': null},
  ];

  HelpAndSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.white, // Set the background color of the entire page to white
      appBar: AppBar(
        title: Text('Help & Support',
            style: GoogleFonts.poppins(
                color: const Color(0xff3F3F3F),
                fontSize: 20,
                fontWeight: FontWeight.w500)),
        backgroundColor: Colors.white, // Set the background of AppBar to white
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'All Topics',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: topics.length,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  leading: Image.asset(
                    'assets/profile/he.png',
                    height: 25,
                  ),
                  title: Text(topics[index]['title'],
                      style: GoogleFonts.poppins(
                          color: const Color(0xff3F3F3F),
                          fontSize: 16,
                          fontWeight: FontWeight.w400)),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      size: 16, color: Colors.black),
                  onTap: () {
                    if (topics[index]['page'] != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => topics[index]['page']),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
