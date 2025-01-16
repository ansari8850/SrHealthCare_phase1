import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
  }

  void _fetchUserProfile() async {
    _userProfile = await UserProfileApiService().fetchUserProfile();

    _fullNameController.text = _userProfile?.name ?? '';
    _emailController.text = _userProfile?.email ?? '';
    _mobileController.text = _userProfile?.mobileNo ?? '';
    setState(() {});
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
        title: CustomText(text: 'My Profile', size: 20, color: blackColor, weight: FontWeight.w500),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: (){
                Get.to(ProfileEdit());
              },
              child: Icon(Icons.edit , color:buttonColor ,)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                      )),
                      SizedBox(height: 8,),
                  CustomText(
                      text: "${_userProfile?.name ?? ''} ${_userProfile?.lastName}",
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
                    padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: 'Mobile Number',
                            size: 12,
                            color: Colors.grey,
                            weight: FontWeight.w400),
                        CustomText(
                            text: "+91 ${_userProfile?.mobileNo ??''}",
                            size: 12,
                            color: blackColor,
                            weight: FontWeight.w400)
                      ],
                    ),
                  ),
                  // SizedBox(height: 10,),
                   Padding(
                     padding: const EdgeInsets.only(left: 20 , bottom: 10 , right: 20),
                     child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: 'Display Name',
                            size: 12,
                            color: Colors.grey,
                            weight: FontWeight.w400),
                        CustomText(
                            text: " ${_userProfile?.displayName ??''}",
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
            CustomText(text: 'Bio', size: 14, color: blackColor, weight: FontWeight.w500),
            CustomText(text: _userProfile?.bio ??'', size: 12, color: Colors.grey, weight: FontWeight.w400) , 
            SizedBox(height: 20,),
                        CustomText(text: 'Saved Address', size: 14, color: blackColor, weight: FontWeight.w500),
                                    CustomText(text: '${_userProfile?.street1} ${_userProfile?.street2} ${_userProfile?.zipCode}   ', size: 12, color: Colors.grey, weight: FontWeight.w400),



            // Stack(
            //   clipBehavior: Clip.none,
            //   children: [
            //     Container(
            //       decoration: const BoxDecoration(),
            //       child: Image.asset(
            //         'assets/myfeed/profile.png',
            //         height: 200,
            //         fit: BoxFit.fill,
            //       ),
            //     ),
            //     Positioned(
            //         // width: Get.width,
            //         top: 50,
            //         left: 20,
            //         child: Row(
            //           // mainAxisSize: MainAxisSize.min,
            //           children: [
            //             GestureDetector(
            //               onTap: () {
            //                 Navigator.pop(context);
            //               },
            //               child: CircleAvatar(
            //                 backgroundColor: Colors.white.withOpacity(.2),
            //                 child: Icon(
            //                   Icons.arrow_back,
            //                   color: whiteColor.withOpacity(.8),
            //                 ),
            //               ),
            //             ),
            //             const SizedBox(
            //               width: 10,
            //             ),
            //             CustomText(
            //                 text: 'My Profile',
            //                 size: 20,
            //                 color: whiteColor,
            //                 weight: FontWeight.w500)
            //           ],
            //         )),
            //     Positioned(
            //       bottom: -3,
            //       left: 0,
            //       right: 0,
            //       child: Container(
            //         height: 10,
            //         alignment: Alignment.bottomCenter,
            //         decoration: const BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.only(
            //                 topLeft: Radius.circular(100),
            //                 topRight: Radius.circular(100))),
            //         padding: const EdgeInsets.symmetric(horizontal: 30),
            //       ),
            //     ),
            //     Positioned(
            //         left: 10,
            //         bottom: -40,
            //         child: CircleAvatar(
            //           backgroundColor: Colors.black,
            //           radius: 50,
            //           // backgroundImage: AssetImage('assets/homepage/dr1.jpg'),
            //           child: _image != null
            //               ? ClipRRect(
            //                   borderRadius: BorderRadius.circular(50),
            //                   child: Image.file(
            //                     _image!,
            //                     fit: BoxFit.cover,
            //                     height: 100,
            //                     width: 100,
            //                   ))
            //               : CircleAvatar(
            //                 radius: 51,
            //                 backgroundColor: buttonColor,
            //                 child: CircleAvatar(
            //                   radius: 49,
            //                   // backgroundColor: buttonColor,
            //                   child: AppCacheNetworkImage(
            //                       imageUrl: _userProfile?.photo?.url ?? "",
            //                       fit: BoxFit.cover,
            //                       borderRadius: 50,
            //                     ),
            //                 ),
            //               ),
            //         )),
            //     Positioned(
            //       bottom: -30,
            //       left: MediaQuery.of(context).size.width / 2 - 70,
            //       child: ElevatedButton(
            //         style: const ButtonStyle(
            //             elevation: WidgetStatePropertyAll(0),
            //             backgroundColor:
            //                 WidgetStatePropertyAll(Colors.transparent)),
            //         onPressed: () {
            //           print('object');
            //           showCustomBottomSheet(context, (image) {
            //             _image = image;
            //             setState(() {});
            //           });
            //         },
            //         child: Text(
            //           'CHANGE IMAGE',
            //           style: GoogleFonts.poppins(
            //             fontSize: 12,
            //             fontWeight: FontWeight.w400,
            //             color: Colors
            //                 .blueAccent, // Use buttonColor or your custom color
            //             decoration: TextDecoration.underline,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          
            // const SizedBox(
            //   height: 40,
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            //   child: Column(
            //     children: [
            //       _buildTextFiledProfile(
            //           'Full Name', _userProfile?.name ?? '', _fullNameController),
            //       const SizedBox(
            //         height: 10,
            //       ),
            //       _buildTextFiledProfile(
            //           'Email', _userProfile?.email ?? '', _emailController),
            //       const SizedBox(
            //         height: 10,
            //       ),
            //       _buildTextFiledProfile('Mobile Number',
            //           _userProfile?.mobileNo ?? '', _mobileController),
            //     ],
            //   ),
            // )
          ]),
        ),
      ),
      // bottomNavigationBar: InkWell(
      //   splashColor: Colors.transparent,
      //   onTap: () {
      //     UserProfileApiService().updateProfile(
      //         image: _image,
      //         email: _emailController.text,
      //         name: _fullNameController.text,
      //         mobileNumber: _mobileController.text);
      //   },
      //   child: Container(
      //     margin: const EdgeInsets.all(10),
      //     height: 50,
      //     // width: Get.width / 2,
      //     // color: Colors.yellow,
      //     decoration: BoxDecoration(
      //         color: buttonColor, borderRadius: BorderRadius.circular(15)),
      //     child: Center(
      //       child: CustomText(
      //           text: 'Update Now',
      //           size: 16,
      //           color: whiteColor,
      //           weight: FontWeight.w500),
      //     ),
      //   ),
      // ),
    
    );
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
              border: Border.all(color: Colors.grey.withOpacity(.3)),
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
