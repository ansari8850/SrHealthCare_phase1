import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/Pages/paymentPages/add_card.dart';
import 'package:sr_health_care/Pages/paymentPages/payment_status.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/text.dart';

class PaymentModeSelection extends StatefulWidget {
  const PaymentModeSelection({super.key});

  @override
  State<PaymentModeSelection> createState() => _PaymentModeSelectionState();
}

class _PaymentModeSelectionState extends State<PaymentModeSelection> {
  String? selectedPaymentMethod;

  // List to hold the added card details.
  final List<Map<String, dynamic>> _addedCards = [];

  void _processPayment() {
    // Show a dialog with a circular progress indicator
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false, // Prevent dismissing the dialog
        child: AlertDialog(
          title: CustomText(
            text: 'Processing your payment',
            size: 16,
            color: blackColor,
            weight: FontWeight.w700,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              CustomText(
                text:
                    'Please wait while we complete your transaction. Don\'t close the screen.',
                size: 14,
                color: Colors.grey,
                weight: FontWeight.w400,
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    // Simulate payment processing delay (e.g., 3 seconds)
    Future.delayed(const Duration(seconds: 3), () {
      // Dismiss the processing dialog.
      Get.back();

      // Prepare dummy payment details. Replace these values with actual details.
      final paymentDetails = {
        'paymentStatus': 'Success',
        'totalAmount': selectedPaymentMethod == 'card'
            ? '₹399'
            : selectedPaymentMethod == 'apple_pay'
                ? '₹399'
                : selectedPaymentMethod == 'phone_pay'
                    ? '₹399'
                    : '₹399', // You can adjust amounts accordingly.
        'planName': 'Designed Subscription Plan',
        'transactionNumber': 'TXN${DateTime.now().millisecondsSinceEpoch}',
        'dateTime': DateTime.now().toString(),
        'planEndDate': DateTime.now().add(const Duration(days: 365)).toString(),
      };

      Get.to(() => const PaymentStatusPage(), arguments: paymentDetails);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        toolbarHeight: 80,
        backgroundColor: Colors.grey.withOpacity(.1),
        title: CustomText(
          text: 'Select payment method',
          size: 16,
          color: blackColor,
          weight: FontWeight.w700,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Credit/Debit Card Section
            Row(
              children: [
                Radio<String>(
                  value: 'card',
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value;
                    });
                  },
                ),
                CustomText(
                  text: 'Credit/ Debit Card',
                  size: 16,
                  color: blackColor,
                  weight: FontWeight.w500,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: _addedCards.isEmpty
                  ? InkWell(
                      onTap: () async {
                        var newCard = await Get.to(() => const AddCardPage());
                        if (newCard != null) {
                          setState(() {
                            _addedCards.add(newCard);
                          });
                        }
                      },
                      child: Row(
                        children: [
                          Icon(Icons.add, color: buttonColor),
                          const SizedBox(width: 10),
                          CustomText(
                            text: 'Add Card',
                            size: 14,
                            color: buttonColor,
                            weight: FontWeight.w700,
                          ),
                        ],
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // List the added cards
                        ..._addedCards.map((card) {
                          // Display each card's details.
                          final cardNumber = card['cardNumber'] as String;
                          final last4Digits = cardNumber.length >= 4
                              ? cardNumber.substring(cardNumber.length - 4)
                              : cardNumber;
                          return Card(
                            color: whiteColor,
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              leading: Radio<String>(
                                value: cardNumber,
                                groupValue: selectedPaymentMethod,
                                onChanged: (value) {
                                  setState(() {
                                    selectedPaymentMethod = cardNumber;
                                  });
                                },
                              ),
                              title: CustomText(
                                text: '${card['cardType']} ****$last4Digits',
                                size: 16,
                                color: blackColor,
                                weight: FontWeight.w500,
                              ),
                              subtitle: CustomText(
                                text: card['cardHolder'],
                                size: 14,
                                color: Colors.grey,
                                weight: FontWeight.w400,
                              ),
                            ),
                          );
                        }),
                        // Option to add another card
                        InkWell(
                          onTap: () async {
                            var newCard =
                                await Get.to(() => const AddCardPage());
                            if (newCard != null) {
                              setState(() {
                                _addedCards.add(newCard);
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                Icon(Icons.add, color: buttonColor),
                                const SizedBox(width: 10),
                                CustomText(
                                  text: 'Add Another Card',
                                  size: 14,
                                  color: buttonColor,
                                  weight: FontWeight.w700,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            const SizedBox(height: 20),
            // Apple Pay Option
            Card(
              elevation: 1,
              color: whiteColor,
              child: ListTile(
                leading: Radio<String>(
                  value: 'apple_pay',
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value;
                    });
                  },
                ),
                title: CustomText(
                  text: 'Apple Pay',
                  size: 16,
                  color: blackColor,
                  weight: FontWeight.w500,
                ),
                trailing: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: blackColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/login/apple.png', height: 10),
                      const SizedBox(width: 5),
                      Text(
                        'Pay',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: whiteColor,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // PhonePe Option
            Card(
              elevation: 1,
              color: whiteColor,
              child: ListTile(
                leading: Radio<String>(
                  value: 'phone_pay',
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value;
                    });
                  },
                ),
                title: CustomText(
                  text: 'PhonePe',
                  size: 16,
                  color: blackColor,
                  weight: FontWeight.w500,
                ),
                trailing: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: .2),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/login/phonepe.png', height: 20),
                      const SizedBox(width: 5),
                      Text(
                        'Pay',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: blackColor,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Google Pay Option
            Card(
              elevation: 1,
              color: whiteColor,
              child: ListTile(
                leading: Radio<String>(
                  value: 'google_pay',
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      selectedPaymentMethod = value;
                    });
                  },
                ),
                title: CustomText(
                  text: 'Google Pay',
                  size: 16,
                  color: blackColor,
                  weight: FontWeight.w500,
                ),
                trailing: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey, width: .2),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/login/google.png', height: 10),
                      const SizedBox(width: 5),
                      Text(
                        'Pay',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: blackColor,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
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
            // Make sure a payment method is selected before processing
            if (selectedPaymentMethod == null) {
              Get.snackbar('Error', 'Please select a payment method');
              return;
            }
            _processPayment();
          },
          child: Center(
            child: CustomText(
              text: 'Pay Now',
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
