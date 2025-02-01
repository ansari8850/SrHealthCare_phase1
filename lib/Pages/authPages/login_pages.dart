import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/Global/bottom_navigation.dart';
import 'package:sr_health_care/Pages/authPages/forget_password.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/sharedference.dart';
import 'package:sr_health_care/const/text.dart';
import 'package:sr_health_care/services/api_services.dart';
// Import your ApiService class

class LoginPages extends StatefulWidget {
  const LoginPages({super.key});

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  // Method to handle login
  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter email and password")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final apiService = ApiService();
    final response = await apiService.login(email, password);

    setState(() {
      _isLoading = false;
    });

    if (response?.$1 == null && response?.$2 != null) {
      final loginData = response?.$2;
      // Login successful
      final accessToken = loginData?.accessToken;
      final userName = loginData?.result?.name;

      if (accessToken?.isNotEmpty == true && loginData?.result != null) {
        // Save data in SharedPreferences
        await SharedPreferenceHelper()
            .saveLoginData(accessToken!, loginData!.result!);
      }

      if (mounted) {
        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Welcome, $userName!")),
        ); // Navigate to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavPage()),
        );
      }
    } else {
      if (mounted) {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response?.$1 ?? "Login failed")),
        );
      }
    }
  }


 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: whiteColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image.asset('assets/spalsh/splashlogo.png', height: 200),
            const CustomText(
                text: 'Welcome! 👋',
                size: 20,
                color: Color(0xff010007),
                weight: FontWeight.w700),
            const SizedBox(height: 8), 
            const CustomText(
                text:
                    'Log In to enjoy healthy posting and events\n around the world ',
                size: 14,
                color: Color(0xff8B8A90),
                weight: FontWeight.w400),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 5),
              child: RichText(
                text: TextSpan(
                  text: 'Email',
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
                          color: Colors.red),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(.2)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _emailController,
                cursorColor: Colors.grey.withOpacity(.3),
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff827C7C)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 5, top: 25),
              child: RichText(
                text: TextSpan(
                  text: 'Password',
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
                          color: Colors.red),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(.2)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                cursorColor: Colors.grey.withOpacity(.3),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey.withOpacity(.3),
                    ),
                  ),
                  hintText: 'Enter Password',
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff827C7C)),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: GestureDetector(
                  onTap: () {
                    Get.to(const ForgetPassword());
                  },
                  child: CustomText(
                      text: 'Forget password?',
                      size: 14,
                      color: loginTextColor,
                      weight: FontWeight.w400),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: _isLoading ? null : _login,
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
                          text: 'LogIn',
                          size: 16,
                          color: whiteColor,
                          weight: FontWeight.w500,
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          
          ],
        ),
      ),
    );
  }
}
