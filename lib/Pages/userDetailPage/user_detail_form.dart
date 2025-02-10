import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/text.dart';

class UserDetailForm extends StatefulWidget {
  const UserDetailForm({super.key});

  @override
  State<UserDetailForm> createState() => _UserDetailFormState();
}

class _UserDetailFormState extends State<UserDetailForm> {
  int currentStep = 0;

  List<String> steptiles = ["Personal", "Address", "Education", "Bio"];

  void nextStep() {
    if (currentStep < steptiles.length - 1) {
      setState(() {
        currentStep++;
      });
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        toolbarHeight: 150,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                      text: 'User Details',
                      size: 20,
                      color: blackColor,
                      weight: FontWeight.w500),
                  Text(
                    'Skip',
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: blackColor,
                        decoration: TextDecoration.underline),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                  text: 'Fill The Below Form To Know More About You',
                  size: 12,
                  color: Colors.grey,
                  weight: FontWeight.w400),
              SizedBox(
                height: 10,
              ),
              Row(
                  children: List.generate(steptiles.length, (index) {
                bool isActive = index == currentStep;
                bool isComplete = index < currentStep;
                return Expanded(
                    child: Row(
                  children: [
                    if (index != 0)
                      Expanded(
                          child: Container(
                        height: 2,
                        color: isComplete ? buttonColor : Colors.grey[300],
                      )),
                    GestureDetector(
                      onTap: () => setState(() {
                        currentStep = index;
                      }),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: isActive ? buttonColor : Colors.grey,
                                width: isActive ? 3 : 1)),
                        child: Icon(
                          Icons.circle,
                          size: 5,
                          color: isActive ? buttonColor : Colors.grey,
                        ),
                      ),
                    )
                  ],
                ));
              })),
              SizedBox(
                height: 10,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: steptiles
                      .asMap()
                      .map((index, title) => MapEntry(
                          index,
                          Text(
                            title,
                            style: TextStyle(
                                color: currentStep >= index
                                    ? buttonColor
                                    : Colors.grey,
                                fontWeight: FontWeight.bold),
                          )))
                      .values
                      .toList())
            ],
          ),
        ),
      ),
    );
  }
}
