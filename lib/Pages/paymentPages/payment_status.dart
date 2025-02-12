import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/text.dart';

class PaymentStatusPage extends StatelessWidget {
  const PaymentStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve payment details passed from the PaymentPlan page.
    final Map<String, dynamic> paymentDetails =
        Get.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: 'Payment Receipt',
          size: 18,
          color: whiteColor,
          weight: FontWeight.w600,
        ),
        backgroundColor: buttonColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Payment Receipt: ${paymentDetails['paymentReceipt']}',
              size: 16,
              color: blackColor,
              weight: FontWeight.w500,
            ),
            const SizedBox(height: 8),
            CustomText(
              text: 'User ID: ${paymentDetails['userId']}',
              size: 16,
              color: blackColor,
              weight: FontWeight.w500,
            ),
            const SizedBox(height: 8),
            CustomText(
              text: 'Date & Time: ${paymentDetails['dateTime']}',
              size: 16,
              color: blackColor,
              weight: FontWeight.w500,
            ),
            const SizedBox(height: 8),
            CustomText(
              text: 'Plan Name: ${paymentDetails['planName']}',
              size: 16,
              color: blackColor,
              weight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
