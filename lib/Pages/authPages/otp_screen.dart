import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/Pages/authPages/set_new_password.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/services/api_services.dart'; // Import the ApiService

class OTPEntryScreen extends StatefulWidget {
  final String email; // Receive email from previous screen

  const OTPEntryScreen(
      {super.key, required this.email}); // Pass email to OTP screen

  @override
  State<OTPEntryScreen> createState() => _OTPEntryScreenState();
}

class _OTPEntryScreenState extends State<OTPEntryScreen> {
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;
  final ApiService _apiService = ApiService(); // Create instance of ApiService
  bool isResendingOtp = false; // Variable to track OTP resend status
  String resendMessage = ""; // Message to show after attempting to resend OTP

  @override
  void initState() {
    super.initState();
    controllers = List.generate(4, (index) => TextEditingController());
    focusNodes = List.generate(4, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onTextChanged(String value, int index) {
    if (value.isNotEmpty) {
      // Move focus to the next field if input is added
      if (index < focusNodes.length - 1) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      }
    } else {
      // Move focus to the previous field if input is deleted
      if (index > 0) {
        FocusScope.of(context ).requestFocus(focusNodes[index - 1]);
      }
    }
  }

  Future<void> _validateOtp() async {
    // Get the OTP from the controllers
    final otp = controllers.map((controller) => controller.text).join();

    if (otp.length != 4) {
      // Show error if OTP is not 4 digits
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 4-digit OTP")),
      );
      return;
    }

    // Call the validateOtp method from ApiService
    final response = await _apiService.validateOtp(widget.email, otp);

    if (response["error"] == true) {
      // Show error message if validation fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response["message"] ?? "Unknown error")),
      );
    } else {
      // Navigate to SetNewPassword screen if OTP is valid
      Get.to(const SetNewPassword());
    }
  }

  Future<void> _resendOtp() async {
    setState(() {
      isResendingOtp = true; // Show loading indicator
    });

    final response = await _apiService.sendOtp(widget.email); // Call sendOtp

    setState(() {
      isResendingOtp = false; // Hide loading indicator
    });

    if (response['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("OTP sent successfully to ${widget.email}")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response["message"] ?? "Error sending OTP")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        leading: Icon(
          Icons.arrow_back_ios,
          color: blackColor,
        ),
      ),
      backgroundColor: whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Code',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Please enter the OTP sent to',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff55545D),
                  ),
                ),
                Text(
                  widget.email, // Show the email passed from previous screen
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: blackColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                4,
                (index) => SizedBox(
                  width: 60,
                  height: 60,
                  child: TextField(
                    controller: controllers[index],
                    focusNode: focusNodes[index],
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    cursorColor: Colors.blueAccent,
                    onChanged: (value) => _onTextChanged(value, index),
                    decoration: InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.blueAccent, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.blueAccent, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Colors.blueAccent, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Didn't receive the email?",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: _resendOtp,
                  child: Text(
                    isResendingOtp
                        ? 'Resending...'
                        : 'Click To Resend', // Change text while resending
                    style: GoogleFonts.poppins(
                      decoration: TextDecoration.underline,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: loginTextColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _validateOtp, // Call the validateOtp function
                  child: Text(
                    'Continue',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            if (isResendingOtp) // Show loading indicator when resending OTP
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
