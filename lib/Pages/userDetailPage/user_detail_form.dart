// user_detail_form.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/CustomWidget/custom_textfiled.dart';
import 'package:sr_health_care/CustomWidget/customdropdown.dart';
import 'package:sr_health_care/Pages/userDetailPage/bio_step.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/text.dart';

class UserDetailForm extends StatefulWidget {
  const UserDetailForm({super.key});

  @override
  State<UserDetailForm> createState() => _UserDetailFormState();
}

class _UserDetailFormState extends State<UserDetailForm> {
  // Personal Details Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController mobileController =
      TextEditingController(text: "+91 ");
  final TextEditingController emailController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController emergencyNumberController =
      TextEditingController();

  // Address Controllers
  final TextEditingController street1Controller = TextEditingController();
  final TextEditingController street2Controller = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();

  // Dropdown selections for personal
  String? selectedUserType;
  String? selectedDepartment;

  // Dropdown selections for address
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;

  // For Education step
  String? selectedDegree;
  String? educationPdfFileName; // Stores the selected PDF file name

  // Options for personal dropdowns
  List<String> userTypes = ["Hospital", "Doctor"];
  List<String> departments = [
    "Dermology",
    "Neurology",
    "Geology",
    "Orthopedic"
  ];

  // Options for address dropdowns
  List<String> countries = ["India", "USA", "UK"];
  List<String> states = ["Maharashtra", "Karnataka", "Delhi"];
  List<String> cities = ["Mumbai", "Bangalore", "New Delhi"];

  // Options for Education step dropdown
  List<String> degreeOptions = ["mobs", "md", "bpharma", "dharma"];

  int currentStep = 0;
  List<String> steptiles = ["Personal", "Address", "Education", "Bio"];

  // Validate fields for the current step
  bool validateCurrentStepFields() {
    if (currentStep == 0) {
      // Validate Personal details
      if (fullNameController.text.isEmpty ||
          mobileController.text.length != 14 || // "+91 " (4) + 10 digits
          emailController.text.isEmpty ||
          !RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.(com|in)$")
              .hasMatch(emailController.text) ||
          displayNameController.text.isEmpty ||
          selectedUserType == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text("Please fill all required personal fields correctly."),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    } else if (currentStep == 1) {
      // Validate Address fields
      if (selectedCountry == null ||
          selectedState == null ||
          selectedCity == null ||
          street1Controller.text.isEmpty ||
          zipCodeController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please fill all required address fields correctly."),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
      if (!RegExp(r'^\d+$').hasMatch(zipCodeController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Enter a valid zip code."),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    } else if (currentStep == 2) {
      // Validate Education fields
      if (selectedDegree == null || educationPdfFileName == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "Please select your degree and upload your education PDF."),
            backgroundColor: Colors.red,
          ),
        );
        return false;
      }
    }
    // For step 3 (Bio), no extra validation is added in this example.
    return true;
  }

  void nextStep() {
    if (validateCurrentStepFields()) {
      if (currentStep < steptiles.length - 1) {
        setState(() {
          currentStep++;
        });
      } else {
        // Final submission action.
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

  // Function to pick PDF for Education step (same as before)
  Future<void> pickEducationPdf() async {
    // Implement PDF picking using your preferred package
    // This is a placeholder for your PDF picking logic.
    // After selecting the PDF, update the educationPdfFileName variable.
    setState(() {
      educationPdfFileName = "selected_document.pdf";
    });
  }

  Widget buildStepContent() {
    if (currentStep == 0) {
      // Personal Details Step
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          CustomTextField(
            label: "Full Name",
            controller: fullNameController,
            isRequired: true,
          ),
          CustomTextField(
            label: "Mobile Number",
            controller: mobileController,
            isRequired: true,
            keyboardType: TextInputType.phone,
            maxLength: 14,
            inputFormatters: [
              LengthLimitingTextInputFormatter(14),
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
          CustomTextField(
            label: "Email",
            controller: emailController,
            isRequired: true,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Email is required";
              }
              String pattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.(com|in)$";
              if (!RegExp(pattern).hasMatch(value)) {
                return "Enter a valid email (e.g., example@gmail.com)";
              }
              return null;
            },
          ),
          CustomTextField(
            label: "Display Name",
            controller: displayNameController,
            isRequired: true,
          ),
          CustomTextField(
            label: "Emergency Number",
            controller: emergencyNumberController,
            isRequired: false,
            keyboardType: TextInputType.phone,
          ),
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
        ],
      );
    } else if (currentStep == 1) {
      // Address Step
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDropdown(
            label: "Country",
            options: countries,
            isRequired: true,
            selectedValue: selectedCountry,
            onChanged: (value) {
              setState(() {
                selectedCountry = value;
              });
            },
          ),
          CustomDropdown(
            label: "State",
            options: states,
            isRequired: true,
            selectedValue: selectedState,
            onChanged: (value) {
              setState(() {
                selectedState = value;
              });
            },
          ),
          CustomDropdown(
            label: "City",
            options: cities,
            isRequired: true,
            selectedValue: selectedCity,
            onChanged: (value) {
              setState(() {
                selectedCity = value;
              });
            },
          ),
          CustomTextField(
            label: "Street 1",
            controller: street1Controller,
            isRequired: true,
          ),
          CustomTextField(
            label: "Street 2",
            controller: street2Controller,
            isRequired: false,
          ),
          CustomTextField(
            label: "Zip Code",
            controller: zipCodeController,
            isRequired: true,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Zip code is required";
              }
              if (!RegExp(r'^\d+$').hasMatch(value)) {
                return "Enter a valid zip code";
              }
              return null;
            },
          ),
        ],
      );
    } else if (currentStep == 2) {
      // Education Step
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDropdown(
            label: "Degree",
            options: degreeOptions,
            isRequired: true,
            selectedValue: selectedDegree,
            onChanged: (value) {
              setState(() {
                selectedDegree = value;
              });
            },
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: pickEducationPdf,
            child: Container(
              height: 150,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.5)),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.upload_file, size: 40, color: Colors.grey),
                    const SizedBox(height: 10),
                    Text(
                      educationPdfFileName != null
                          ? educationPdfFileName!
                          : "Drop your PDF document here for your education",
                      style:
                          GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    } else if (currentStep == 3) {
      // Bio Step using our new BioStepWidget
      return const BioStepWidget();
    } else {
      return const SizedBox.shrink();
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
            buildStepContent(),
            const SizedBox(height: 20),
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
