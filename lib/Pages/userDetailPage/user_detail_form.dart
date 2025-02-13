import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/CustomWidget/custom_textfiled.dart';
import 'package:sr_health_care/CustomWidget/customdropdown.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/text.dart';

class UserDetailForm extends StatefulWidget {
  const UserDetailForm({super.key});

  @override
  State<UserDetailForm> createState() => _UserDetailFormState();
}

class _UserDetailFormState extends State<UserDetailForm> {
  final TextEditingController fullNameController = TextEditingController();
  // Pre-populated with "+91 " (4 characters) so the user can only add 10 more digits.
  final TextEditingController mobileController =
      TextEditingController(text: "+91 ");
  final TextEditingController emailController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController emergencyNumberController =
      TextEditingController();

  String? selectedUserType;
  String? selectedDepartment;

  List<String> userTypes = ["Admin", "User", "Guest"];
  List<String> departments = ["HR", "Finance", "Engineering", "Marketing"];

  int currentStep = 0;
  List<String> steptiles = ["Personal", "Address", "Education", "Bio"];

  // Validate required fields for the current step.
  bool validateFields() {
    // Validate mobile number using a RegExp to ensure it starts with "+91 " followed by 10 digits.
    if (fullNameController.text.isEmpty ||
        mobileController.text.length !=
            14 || // 4 characters for "+91 " + 10 digits
        emailController.text.isEmpty ||
        !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.(com|in)$")
            .hasMatch(emailController.text) ||
        displayNameController.text.isEmpty ||
        selectedUserType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all required fields correctly."),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
    return true;
  }

  void nextStep() {
    if (validateFields()) {
      if (currentStep < steptiles.length - 1) {
        setState(() {
          currentStep++;
        });
      } else {
        // Submit action can be handled here.
        // For example, save the data or navigate to a different page.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Form submitted successfully!"),
            backgroundColor: Colors.green,
          ),
        );
      }
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
        elevation: 0,
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        toolbarHeight: 150,
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'User Details',
                size: 20,
                color: blackColor,
                weight: FontWeight.w500,
              ),
              const SizedBox(height: 10),
              CustomText(
                text: 'Fill The Below Form To Know More About You',
                size: 12,
                color: Colors.grey,
                weight: FontWeight.w400,
              ),
              const SizedBox(height: 10),
              // Step indicators
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
                              color:
                                  isComplete ? buttonColor : Colors.grey[300],
                            ),
                          ),
                        GestureDetector(
                          onTap: () => setState(() {
                            currentStep = index;
                          }),
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isActive ? buttonColor : Colors.grey,
                                width: isActive ? 3 : 1,
                              ),
                            ),
                            child: Icon(
                              Icons.circle,
                              size: 5,
                              color: isActive ? buttonColor : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(height: 10),
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
                            fontWeight: FontWeight.bold,
                          ),
                        )))
                    .values
                    .toList(),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Type Dropdown (Required)
            CustomDropdown(
              label: "User Type",
              options: userTypes,
              isRequired: true,
              selectedValue: selectedUserType,
              onChanged: (value) {
                setState(() {
                  selectedUserType = value;
                });
              },
            ),
            // Full Name (Required)
            CustomTextField(
              label: "Full Name",
              controller: fullNameController,
              isRequired: true,
            ),
            // Mobile Number (Required) – limit total length to 14 characters ("+91 " + 10 digits)
            CustomTextField(
              label: "Mobile Number",
              controller: mobileController,
              isRequired: true,
              keyboardType: TextInputType.phone,
              maxLength: 14,
              inputFormatters: [
                LengthLimitingTextInputFormatter(14),
                // Optionally allow only digits, spaces, and the '+' character:
                FilteringTextInputFormatter.allow(RegExp(r'[0-9+ ]')),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Mobile number is required";
                }
                String pattern = r"^\+91 \d{10}$";
                if (!RegExp(pattern).hasMatch(value)) {
                  return "Enter a valid 10-digit mobile number";
                }
                return null;
              },
            ),
            // Email (Required) – must contain "@" and end with ".com" or ".in"
            CustomTextField(
              label: "Email",
              controller: emailController,
              isRequired: true,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email is required";
                }
                String pattern =
                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.(com|in)$";
                if (!RegExp(pattern).hasMatch(value)) {
                  return "Enter a valid email (e.g., example@gmail.com)";
                }
                return null;
              },
            ),
            // Display Name (Required)
            CustomTextField(
              label: "Display Name",
              controller: displayNameController,
              isRequired: true,
            ),
            // Emergency Number (Optional)
            CustomTextField(
              label: "Emergency Number",
              controller: emergencyNumberController,
              isRequired: false,
              keyboardType: TextInputType.phone,
            ),
            // Department Dropdown (Optional)
            CustomDropdown(
              label: "Department",
              options: departments,
              selectedValue: selectedDepartment,
              onChanged: (value) {
                setState(() {
                  selectedDepartment = value;
                });
              },
            ),
            const SizedBox(height: 20),
            // Navigation Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentStep > 0)
                    ElevatedButton(
                      onPressed: previousStep,
                      child: const Text("Previous"),
                    ),
                  ElevatedButton(
                    onPressed: nextStep,
                    child: Text(
                      currentStep == steptiles.length - 1 ? "Submit" : "Next",
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
