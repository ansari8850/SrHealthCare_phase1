import 'package:flutter/material.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/text.dart';

class PaymentPlan extends StatefulWidget {
  const PaymentPlan({super.key});

  @override
  State<PaymentPlan> createState() => _PaymentPlanState();
}

class _PaymentPlanState extends State<PaymentPlan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: whiteColor,
        flexibleSpace: Container(
          height: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [
                    buttonColor.withOpacity(.7),
                    buttonColor.withOpacity(.3)
                  ])),
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.close),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                      text: 'PICK A SUBSCRIPTON',
                      size: 22,
                      color: blackColor,
                      weight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [Container()],
      ),
    );
  }
}
