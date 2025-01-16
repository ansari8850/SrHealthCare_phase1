import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/Pages/authPages/login_pages.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/text.dart';
import 'package:sr_health_care/services/api_services.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _mobileController = TextEditingController();
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  String? _errorMessage; // To hold the error message

  Future<void> _sendCode() async {
    final mobileNo = _mobileController.text.trim();

    if (mobileNo.isEmpty) {
      setState(() {
        _errorMessage = "Please enter your mobile number.";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null; // Clear previous error
    });

    final response = await _apiService.sendPasswordResetToWhatsapp(mobileNo);

    setState(() {
      _isLoading = false;
    });

    if (response["error"] == null || response["error"] == false) {
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("OTP has been sent to your WhatsApp number."),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
     // Navigate to login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPages()),
    );
    } else {
      setState(() {
        _errorMessage = response["message"] ?? "Failed to send code.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
                text: 'Forget Password ? 🤔',
                size: 20,
                color: blackColor,
                weight: FontWeight.w500),
            const SizedBox(height: 8),
            const CustomText(
                text:
                    'Don’t worry! Enter your registration Mobile No, We will\nsend OTP for password recovery',
                size: 13,
                color: Color(0xff55545D),
                weight: FontWeight.w400),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 5),
              child: RichText(
                text: TextSpan(
                    text: 'Mobile No',
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                    children: [
                      TextSpan(
                          text: '*',
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.red))
                    ]),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(.2)),
                  borderRadius: BorderRadius.circular(8)),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: _mobileController,
                cursorColor: Colors.grey.withOpacity(.3),
                decoration: InputDecoration(
                    hintText: 'Enter mobile no',
                    border: InputBorder.none,
                    hintStyle: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff827C7C))),
              ),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 10),
              Text(
                _errorMessage!,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              ),
            ],
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _isLoading ? null : _sendCode,
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Align(
                  alignment: Alignment.center,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : CustomText(
                          text: 'Send Code on Whatsapp',
                          size: 16,
                          color: whiteColor,
                          weight: FontWeight.w500,
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
