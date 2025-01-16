import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ManagingAccountPage(),
    );
  }
}

class ManagingAccountPage extends StatefulWidget {
  const ManagingAccountPage({super.key});

  @override
  _ManagingAccountPageState createState() => _ManagingAccountPageState();
}

class _ManagingAccountPageState extends State<ManagingAccountPage> {
  final List<bool> _isExpanded = [false, false, false];

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
        backgroundColor: Colors.white,
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
              'Managing Your Account?',
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildExpansionTile(
                  0,
                  'How to update your profile information?',
                  'Lorem ipsum dolor sit amet consectetur. Cras metus risus mi quis nunc blandit vel cursus volutpat. Tempor morbi eget et ut netus dignissim volutpat.',
                ),
                _buildExpansionTile(
                  1,
                  'How to reset password?',
                  'To reset your password, go to the login page, click on "Forgot Password", and follow the instructions sent to your email.',
                ),
                _buildExpansionTile(
                  2,
                  'How to deactivate my account?',
                  'To deactivate your account, go to Account Settings, select Deactivate, and confirm your choice. Note that this action is reversible.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionTile(int index, String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded[index] = !_isExpanded[index];
              });
            },
            child: Container(
              color: Colors.white, // Ensure the background is white
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Icon(
                    _isExpanded[index]
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded[index])
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: Text(
                content,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w400),
              ),
            ),
        ],
      ),
    );
  }
}
