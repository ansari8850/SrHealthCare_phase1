import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/CustomWidget/app_cache_network_image.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/text.dart';
import 'package:sr_health_care/services/image_picker_service.dart';
import 'package:sr_health_care/trash/address.dart';

import 'modelandservice/login_user_profile.dart';
import 'modelandservice/user_profile_service.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  File? _image;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _LastNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _street1Controller = TextEditingController();
  final TextEditingController _street2Controller = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _bioControler = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  final TextEditingController _cityController = TextEditingController();
  final List<String> countryList = ['India', 'USA', 'Canada', 'Australia'];
  final Map<String, List<String>> stateMap = {
    'India': ['Maharashtra', 'Karnataka', 'Delhi', 'Gujarat'],
    'USA': ['California', 'Texas', 'New York', 'Florida'],
    'Canada': ['Ontario', 'Quebec', 'British Columbia', 'Alberta'],
    'Australia': ['New South Wales', 'Victoria', 'Queensland', 'Tasmania'],
  };
  final Map<String, List<String>> cityMap = {
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur', 'Nashik'],
    'Karnataka': ['Bengaluru', 'Mysuru', 'Mangaluru', 'Hubli'],
    'Delhi': ['New Delhi', 'Dwarka', 'Karol Bagh', 'Rohini'],
    'Gujarat': ['Ahmedabad', 'Surat', 'Vadodara', 'Rajkot'],
    'California': ['Los Angeles', 'San Francisco', 'San Diego', 'Sacramento'],
    'Texas': ['Houston', 'Dallas', 'Austin', 'San Antonio'],
    'Ontario': ['Toronto', 'Ottawa', 'Mississauga', 'Brampton'],
    'Victoria': ['Melbourne', 'Geelong', 'Ballarat', 'Bendigo'],
  };
  String selectedCountry = '';
  String selectedState = '';
  String selectedCity = '';

  LoginUserProfile? _userProfile;

  void _fetchUserProfile() async {
    _userProfile = await UserProfileApiService().fetchUserProfile();

    _firstNameController.text = _userProfile?.name ?? '';
    _emailController.text = _userProfile?.email ?? '';
    _mobileController.text = _userProfile?.mobileNo ?? '';
    _LastNameController.text = _userProfile?.lastName ?? '';
    _displayNameController.text = _userProfile?.displayName ?? '';
    _street1Controller.text = _userProfile?.street1 ?? '';
    _street2Controller.text = _userProfile?.street2 ?? '';
    _pinCodeController.text = _userProfile?.zipCode ?? '';
    _bioControler.text = _userProfile?.bio ?? '';

    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _firstNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _LastNameController.dispose();
    _displayNameController.dispose();
    _street1Controller.dispose();
    _street2Controller.dispose();
    _pinCodeController.dispose();
    _bioControler.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _cityController.dispose();
  }

  bool _isBioVisible = false;

  void _toggleBioVisibility() {
    setState(() {
      _isBioVisible = !_isBioVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: CustomText(
            text: 'Edit Profile',
            size: 20,
            color: blackColor,
            weight: FontWeight.w500),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 50,
                    // backgroundImage: AssetImage('assets/homepage/dr1.jpg'),
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              _image!,
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            ))
                        : CircleAvatar(
                            radius: 50,
                            // backgroundColor: buttonColor,
                            child: AppCacheNetworkImage(
                              imageUrl: _userProfile?.photo?.url ?? "",
                              fit: BoxFit.cover,
                              borderRadius: 50,
                            ),
                          ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.edit,
                            color: buttonColor,
                            size: 18,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          GestureDetector(
                            onTap: () async {
                              final image = await ImagePickerService()
                                  .pickImageFromGallery();
                              File("${image}");
                              setState(() {
                                _image = image;
                              });
                            },
                            child: CustomText(
                                text: 'Change Photo',
                                size: 12,
                                color: blackColor,
                                weight: FontWeight.w400),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Icon(
                      //       Icons.delete,
                      //       color: Colors.red,
                      //       size: 18,
                      //     ),
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     CustomText(
                      //         text: 'Delete Photo',
                      //         size: 12,
                      //         color: Colors.red,
                      //         weight: FontWeight.w400)
                      //   ],
                      // )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              CustomText(
                  text: 'Personal Detail',
                  size: 16,
                  color: blackColor,
                  weight: FontWeight.w500),
              SizedBox(
                height: 20,
              ),
              _buildTextFiledProfile(
                  'First Name', "${_userProfile?.name}", _firstNameController),
              _buildTextFiledProfile('Last Name', "${_userProfile?.lastName}",
                  _LastNameController),
              _buildTextFiledProfile('Display Name',
                  "${_userProfile?.displayName}", _displayNameController),
              _buildTextFiledProfile('Mobile Number',
                  "${_userProfile?.mobileNo}", _mobileController),
              SizedBox(
                height: 10,
              ),
              CustomText(
                  text: 'Address Details',
                  size: 16,
                  color: blackColor,
                  weight: FontWeight.w500),
              SizedBox(
                height: 10,
              ),
              _buildDropdown(
                'Country',
                'Select Country',
                _countryController,
                countryList,
              ),
              const SizedBox(height: 10),
              if (selectedCountry.isNotEmpty)
                _buildDropdown(
                  'State',
                  'Select State',
                  _stateController,
                  stateMap[selectedCountry] ?? [],
                ),
              const SizedBox(height: 10),
              if (selectedState.isNotEmpty)
                _buildDropdown(
                  'City',
                  'Select City',
                  _cityController,
                  cityMap[selectedState] ?? [],
                ),
              _buildTextFiledProfile(
                  'Street 1', "${_userProfile?.street1}", _street1Controller),
              _buildTextFiledProfile(
                  'Street 2', "${_userProfile?.street2}", _street2Controller),
              _buildTextFiledProfile(
                  'ZipCode', "${_userProfile?.zipCode}", _pinCodeController),
              SizedBox(
                height: 10,
              ),
              CustomText(
                  text: 'Bio',
                  size: 16,
                  color: blackColor,
                  weight: FontWeight.w500),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Icon(Icons.add, color: buttonColor, size: 18),
                  GestureDetector(
                      onTap: () {
                        _toggleBioVisibility(); // Ensure the method is invoked properly
                      },
                      child: CustomText(
                          text: _isBioVisible
                              ? 'Cancel'
                              : 'Add Bio', // Change text dynamically
                          size: 14,
                          color: buttonColor,
                          weight: FontWeight.w400))
                ],
              ),
              if (_isBioVisible)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.withOpacity(.3)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        maxLines: 5,
                        controller: _bioControler,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter your bio',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                      // const SizedBox(height: 10),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       _isBioVisible = false; // Close the bio input
                      //     });
                      //     // Call API or save the updated bio here
                      //     log('Bio updated: ${_bioControler.text}');
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: buttonColor,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //   ),
                      //   child: CustomText(
                      //       text: 'Save Bio',
                      //       size: 14,
                      //       color: Colors.white,
                      //       weight: FontWeight.w500),
                      // ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        splashColor: Colors.transparent,
        onTap: () async {
          // Combine the address fields
          final String address = _countryController.text +
              _stateController.text +
              _cityController.text;

          // Show loading dialog
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          );

          // Perform the API call
          try {
            final result = await UserProfileApiService().updateProfile(
              image: _image,
              email: _emailController.text,
              name: _firstNameController.text,
              lastname: _LastNameController.text,
              address: address,
              bio: _bioControler.text,
              street1: _street1Controller.text,
              street2: _street2Controller.text,
              zipCode: _pinCodeController.text,
              mobileNumber: _mobileController.text,
            );

            // Dismiss the loading dialog
            Navigator.pop(context); // Pop the dialog

            // Navigate back to the previous page
            Navigator.pop(context, true); // Passing 'true' to indicate success

            // Optionally, show a success Snackbar on the previous page
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Profile updated successfully!',
                  style: GoogleFonts.poppins(color: whiteColor),
                ),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.black,
              ),
            );
          } catch (error) {
            // Dismiss the loading dialog
            Navigator.pop(context); // Pop the dialog

            // Show error Snackbar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to update profile. Please try again.'),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Container(
          margin: const EdgeInsets.all(10),
          height: 50,
          decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: CustomText(
              text: 'Update Now',
              size: 16,
              color: whiteColor,
              weight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String hint,
      TextEditingController controller, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(
                text: label,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: blackColor),
                children: [
              TextSpan(
                text: "*",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.red),
              )
            ])),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonFormField<String>(
            value: controller.text.isNotEmpty && items.contains(controller.text)
                ? controller.text
                : null,
            style: GoogleFonts.poppins(
                color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400),
            borderRadius: BorderRadius.circular(12),
            dropdownColor: Colors.white,
            // value: controller.text.isNotEmpty ? controller.text : null,
            items: items.toSet().map((String value) {
              return DropdownMenuItem(
                value: value,
                child: Text(
                  value,
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black),
                ),
              );
            }).toList(),
            onChanged: (value) {
              controller.text = value.toString();
              if (label == 'Country') {
                setState(() {
                  selectedCountry = value!;
                  selectedState =
                      ''; // Reset state and city when country changes
                  selectedCity = '';
                  _stateController.clear();
                  _cityController.clear();
                });
              } else if (label == 'State') {
                setState(() {
                  selectedState = value!;
                  selectedCity = ''; // Reset city when state changes
                  _cityController.clear();
                });
              } else if (label == 'City') {
                setState(() {
                  selectedCity = value!;
                });
              }
            },

            // controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(
                  color: Colors.grey.shade100,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Padding _buildTextFiledProfile(
      String title, String subtitle, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
                fontSize: 16, fontWeight: FontWeight.w400, color: blackColor),
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(.3)),
                borderRadius: BorderRadius.circular(12)),
            child: TextField(
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
              controller: controller,
              decoration: InputDecoration(
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey),
                  hintText: subtitle,
                  border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }
}
