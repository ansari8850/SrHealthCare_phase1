import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/Pages/paymentPages/payment_mode_selection.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/text.dart';

// PAGE 1: Select Subscription Plan

class PaymentPlan extends StatefulWidget {
  const PaymentPlan({super.key});

  @override
  State<PaymentPlan> createState() => _PaymentPlanState();
}

class _PaymentPlanState extends State<PaymentPlan> {
  String? selectedPlan; // Tracks the selected plan's id.

  // List of subscription plans.
  final List<Map<String, dynamic>> _plans = [
    {
      'id': 'student',
      'name': 'Student Plan',
      'yearlyPrice': '₹399/Yr',
      'discount': '20% off',
      'originalMonthly': '₹41.66',
      'discountedMonthly': '₹33.25/Mo',
    },
    {
      'id': 'commercial',
      'name': 'Commercial Institute Plan',
      'yearlyPrice': '₹599/Yr',
      'discount': '20% off',
      'originalMonthly': '₹70.22',
      'discountedMonthly': '₹49.90/Mo',
    },
  ];

  // List of feature details.
  final List<Map<String, String>> _features = [
    {
      'icon': 'assets/login/star.png',
      'title': 'Unlimited Posting',
      'subtitle':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    },
    {
      'icon': 'assets/login/bookmark.png',
      'title': 'Unlimited Bookmarks',
      'subtitle':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    },
    {
      'icon': 'assets/login/ads.png',
      'title': 'Remove All Ads',
      'subtitle':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    },
    {
      'icon': 'assets/login/events.png',
      'title': 'More Event Posts',
      'subtitle':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    },
  ];

  void _navigateToPaymentMode() {
    if (selectedPlan == null) {
      Get.snackbar('Error', 'Please select a subscription plan.');
      return;
    }

    // Get the details of the selected plan.
    final selectedPlanDetails =
        _plans.firstWhere((plan) => plan['id'] == selectedPlan);

    // Navigate to the Payment Mode Selection page, passing the selected plan details.
    Get.to(() => PaymentModeSelection(), arguments: selectedPlanDetails);
  }

  @override
  Widget build(BuildContext context) {
    // Get details of the currently selected plan (if any) for dynamic text.
    final selectedPlanDetails = selectedPlan != null
        ? _plans.firstWhere((plan) => plan['id'] == selectedPlan)
        : null;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: Size(Get.width, 170),
        child: PlannerAppBar(), // Assume this is your custom AppBar widget.
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Center(
              child: CustomText(
                text: "Unlock the full posting experience with our ",
                size: 12,
                color: const Color(0xff0A4D3C),
                weight: FontWeight.w400,
              ),
            ),
            Center(
              child: CustomText(
                text: "Designed Subscription Plans",
                size: 20,
                color: buttonColor,
                weight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),

            // Build plan selection containers dynamically.
            Column(
              children: _plans.map((plan) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: _buildPlanContainer(
                    planName: plan['name'],
                    yearlyPrice: plan['yearlyPrice'],
                    discount: plan['discount'],
                    originalMonthly: plan['originalMonthly'],
                    discountedMonthly: plan['discountedMonthly'],
                    isSelected: selectedPlan == plan['id'],
                    value: plan['id'],
                    onChanged: (value) {
                      setState(() {
                        selectedPlan = value;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Features list built dynamically.
            Container(
              padding: const EdgeInsets.all(10),
              width: Get.width,
              decoration: BoxDecoration(
                color: buttonColor.withOpacity(.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  CustomText(
                    text: "What's Inside?",
                    size: 20,
                    color: blackColor,
                    weight: FontWeight.w700,
                  ),
                  const SizedBox(height: 10),
                  ..._features.map((feature) {
                    return ListTile(
                      contentPadding: const EdgeInsets.only(top: 10),
                      leading: CircleAvatar(
                        backgroundColor: whiteColor,
                        child: Image.asset(
                          feature['icon']!,
                          height: 20,
                        ),
                      ),
                      title: CustomText(
                        text: feature['title']!,
                        size: 16,
                        color: blackColor,
                        weight: FontWeight.w700,
                      ),
                      subtitle: CustomText(
                        text: feature['subtitle']!,
                        size: 14,
                        color: Colors.grey,
                        weight: FontWeight.w400,
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Dynamic RichText showing the selected plan details.
            selectedPlanDetails != null
                ? RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Subscribe Today And You Will Be Charged ",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(
                          text: ' ${selectedPlanDetails['yearlyPrice']} ',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: blackColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: "Cancel Anytime",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 20),
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
          onTap: _navigateToPaymentMode,
          child: Center(
            child: CustomText(
              text: 'Subscribe Now',
              size: 16,
              color: whiteColor,
              weight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  // Widget to build each plan container.
  Widget _buildPlanContainer({
    required String planName,
    required String yearlyPrice,
    required String discount,
    required String originalMonthly,
    required String discountedMonthly,
    required bool isSelected,
    required String value,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: buttonColor, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Radio<String>(
                splashRadius: 0.0,
                value: value,
                groupValue: selectedPlan,
                onChanged: onChanged,
                activeColor: buttonColor,
              ),
              CustomText(
                text: planName,
                size: 18,
                color: blackColor,
                weight: FontWeight.w500,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: 'Yearly',
                  size: 16,
                  color: blackColor,
                  weight: FontWeight.w500,
                ),
                CustomText(
                  text: yearlyPrice,
                  size: 16,
                  color: blackColor,
                  weight: FontWeight.w500,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: discount,
                  size: 16,
                  color: const Color(0xff402CD8),
                  weight: FontWeight.w500,
                ),
                RichText(
                  text: TextSpan(
                    text: originalMonthly,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                    children: [
                      TextSpan(
                        text: '  $discountedMonthly',
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          decoration: TextDecoration.none,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlannerAppBar extends StatelessWidget {
  const PlannerAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 170,
        flexibleSpace: Stack(
          children: [
            Container(
              decoration: BoxDecoration(color: whiteColor),
            ),
            Positioned(
                top: 40,
                left: MediaQuery.of(context).size.width / 3,
                child: Image.asset(
                  'assets/login/plannerlogo.png',
                  height: 100,
                )),
            Positioned(
                top: 30,
                left: MediaQuery.of(context).size.width / 6.8,
                child: Image.asset(
                  'assets/login/Sparkles.png',
                  height: 50,
                )),
            Positioned(
                top: 10,
                right: MediaQuery.of(context).size.width / 6.8,
                child: Image.asset(
                  'assets/login/Sparkles.png',
                  height: 50,
                )),
            Positioned(
                bottom: 10,
                left: MediaQuery.of(context).size.width / 6.8,
                child: Image.asset(
                  'assets/login/Sparkles.png',
                  height: 50,
                )),
            Positioned(
                bottom: 40,
                right: MediaQuery.of(context).size.width / 4.3,
                child: Image.asset(
                  'assets/login/Sparkles.png',
                  height: 50,
                )),
            Positioned(
                bottom: 10,
                right: 30,
                child: Image.asset(
                  'assets/login/Collision.png',
                  height: 50,
                )),
            Positioned(
                top: 80,
                left: 10,
                child: Image.asset(
                  'assets/login/Collision.png',
                  height: 50,
                )),
          ],
        ));
  }
}
