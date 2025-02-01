import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/Global/bottom_navigation.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/text.dart';

class SucessfullPost extends StatelessWidget {
  const SucessfullPost({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // toolbarHeight: 90,

          title: CustomText(
              text: 'Posted Successfully',
              size: 20,
              color: blackColor,
              weight: FontWeight.w500),
          centerTitle: true,
          backgroundColor: whiteColor,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/homepage/egg.png',
                // fit: BoxFit.fill,
                height: Get.height / 3,
              ),
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Thank You For\nPosting With',
                    style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff0D654E)),
                    children: [
                      TextSpan(
                          text: ' SR!',
                          style: GoogleFonts.poppins(
                            color: buttonColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ))
                    ])),
            const SizedBox(
              height: 15,
            ),
            const CustomText(
                text: 'Your post is successfully uploded',
                size: 16,
                color: Color(0xff0D654E),
                weight: FontWeight.w400),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: _postNowButton(),
            )
          ],
        ),
      ),
    );
  }

  Widget _postNowButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
              Get.context!,
              MaterialPageRoute(
                builder: (context) =>
                    const BottomNavPage(), // Replace with your homepage widget
              ));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Text(
          'Explore',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
