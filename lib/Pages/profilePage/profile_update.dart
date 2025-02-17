import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/CustomWidget/app_cache_network_image.dart';
import 'package:sr_health_care/Pages/profilePage/modelandservice/login_user_profile.dart';
import 'package:sr_health_care/Pages/profilePage/modelandservice/user_profile_service.dart';
import 'package:sr_health_care/Pages/profilePage/profile_edit.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/text.dart';
import 'package:sr_health_care/services/image_picker_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  LoginUserProfile? _userProfile;
  bool _isLoading = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  void _fetchUserProfile() async {
    setState(() {
      _isLoading = true;
    });
    _userProfile = await UserProfileApiService().fetchUserProfile();

    _fullNameController.text = _userProfile?.name ?? '';
    _emailController.text = _userProfile?.email ?? '';
    _mobileController.text = _userProfile?.mobileNo ?? '';
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 0,
          title: CustomText(
              text: 'My Profile',
              size: 20,
              color: blackColor,
              weight: FontWeight.w500),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                  onTap: () {
                    Get.to(ProfileEdit());
                  },
                  child: Icon(
                    Icons.edit,
                    color: buttonColor,
                  )),
            )
          ],
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            margin: EdgeInsets.all(10),
                            color: whiteColor,
                            child: Column(
                              // mainAxisSize: MainAxisSize.max,
                              children: [
                                CircleAvatar(
                                    radius: 50,
                                    child: AppCacheNetworkImage(
                                      imageUrl: _userProfile?.photo?.url ?? '',
                                      borderRadius: 50,
                                      height: 100,
                                      width: Get.width,
                                    )),
                                SizedBox(
                                  height: 8,
                                ),
                                CustomText(
                                    text:
                                        "${_userProfile?.name ?? ''} ${_userProfile?.lastName}",
                                    size: 22,
                                    color: blackColor,
                                    weight: FontWeight.w500),
                                CustomText(
                                    text: _userProfile?.email ?? '',
                                    size: 12,
                                    color: Colors.grey,
                                    weight: FontWeight.w400),
                                // SizedBox(height: 10,),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                          text: 'Mobile Number',
                                          size: 12,
                                          color: Colors.grey,
                                          weight: FontWeight.w400),
                                      CustomText(
                                          text:
                                              "+91 ${_userProfile?.mobileNo ?? ''}",
                                          size: 12,
                                          color: blackColor,
                                          weight: FontWeight.w400)
                                    ],
                                  ),
                                ),
                                // SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, bottom: 10, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                          text: 'Display Name',
                                          size: 12,
                                          color: Colors.grey,
                                          weight: FontWeight.w400),
                                      CustomText(
                                          text:
                                              " ${_userProfile?.displayName ?? ''}",
                                          size: 12,
                                          color: blackColor,
                                          weight: FontWeight.w400)
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: 'Bio',
                                    size: 14,
                                    color: blackColor,
                                    weight: FontWeight.w500),
                                CustomText(
                                    text: _userProfile?.bio ?? '',
                                    size: 12,
                                    color: Colors.grey,
                                    weight: FontWeight.w400),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomText(
                                    text: 'Saved Address',
                                    size: 14,
                                    color: blackColor,
                                    weight: FontWeight.w500),
                                CustomText(
                                    text:
                                        // _userProfile?.address??'',
                                        '${_userProfile?.street1} ${_userProfile?.street2} ${_userProfile?.zipCode}   ',
                                    size: 12,
                                    color: Colors.grey,
                                    weight: FontWeight.w400),
                              ],
                            ),
                          ),
                        ]))));
  }

  Column _buildTextFiledProfile(
      String title, String subtitle, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withValues(alpha: .3)),
              borderRadius: BorderRadius.circular(12)),
          child: TextField(
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
    );
  }
}

// Function to show the modal bottom sheet
void showCustomBottomSheet(BuildContext context, Function(File?) onPickImage) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent, // Makes the modal edges rounded
    builder: (context) {
      return Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: const EdgeInsets.only(
                top: 20), // Adds space for the close button
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.blueAccent,
                width: 1.5, // Blue border width
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildOptionTile(
                  context,
                  title: "Delete Photo",
                  textColor: Colors.redAccent,
                  onTap: () {
                    Navigator.pop(context);
                    // Add your delete logic here
                  },
                ),
                buildOptionTile(
                  context,
                  title: "Change Photo",
                  onTap: () async {
                    Navigator.pop(context);
                    final image =
                        await ImagePickerService().pickImageFromGallery();
                    onPickImage(image);
                  },
                ),
                buildOptionTile(
                  context,
                  title: "Cancel",
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          // Positioned close button
          Positioned(
            top: -35,
            // right: 10,
            left: MediaQuery.of(context).size.width / 2 - 25,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 25,
              child: IconButton(
                icon: const Icon(Icons.close),
                color: Colors.black54,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      );
    },
  );
}

// Helper method to build each option tile
Widget buildOptionTile(BuildContext context,
    {required String title,
    Color textColor = Colors.black,
    VoidCallback? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: const BoxDecoration(
        border: Border(
            // bottom: BorderSide(color: Colors.grey),
            ),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}
