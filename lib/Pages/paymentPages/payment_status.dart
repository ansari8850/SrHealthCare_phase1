import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/Global/bottom_navigation.dart';
import 'package:sr_health_care/Pages/userDetailPage/user_detail_form.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/text.dart';

class PaymentStatusPage extends StatelessWidget {
  const PaymentStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the payment details passed via Get.arguments.
    final Map<String, dynamic> paymentDetails =
        Get.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/login/sucess.png',
            height: Get.height / 3,
          ),
          Text(
            'Thanks You For Subscribing\n To Student Plan',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 20, fontWeight: FontWeight.w700, color: blackColor),
          ),
          CustomText(
            text: 'Payment Status: ${paymentDetails['paymentStatus']}',
            size: 16,
            color: buttonColor,
            weight: FontWeight.w400,
          ),
          const SizedBox(height: 20),
          Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(color: buttonColor.withOpacity(.1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: 'Your Student Plan Details',
                    size: 16,
                    color: blackColor,
                    weight: FontWeight.w500),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: 'Date & Time : ',
                        size: 14,
                        color: Colors.grey,
                        weight: FontWeight.w400),
                    CustomText(
                        text: 'Tuesday, 19 04:30pm',
                        size: 14,
                        color: Color(0xff0A4D3C),
                        weight: FontWeight.w700)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: 'Plan : ',
                        size: 14,
                        color: Colors.grey,
                        weight: FontWeight.w400),
                    CustomText(
                        text: 'Student Plan',
                        size: 14,
                        color: Color(0xff0A4D3C),
                        weight: FontWeight.w700)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: 'Payment : ',
                        size: 14,
                        color: Colors.grey,
                        weight: FontWeight.w400),
                    CustomText(
                        text: 'Paid By Credit Card',
                        size: 14,
                        color: Color(0xff0A4D3C),
                        weight: FontWeight.w700)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: 'Total: ',
                        size: 14,
                        color: Colors.grey,
                        weight: FontWeight.w500),
                    CustomText(
                        text: '₹399.00/-',
                        size: 14,
                        color: buttonColor,
                        weight: FontWeight.w700)
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => UserDetailForm()));
          },
          child: Center(
            child: CustomText(
              text: 'Next',
              size: 16,
              color: whiteColor,
              weight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
