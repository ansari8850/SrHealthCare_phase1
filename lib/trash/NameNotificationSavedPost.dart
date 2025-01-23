import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/Pages/notification/notification.dart';
import 'package:sr_health_care/Pages/profilePage/save_post.dart';
import 'package:sr_health_care/const/colors.dart';

class NameNotificationSavedPost extends StatelessWidget {
  String name;
   NameNotificationSavedPost({
    super.key,
    required this.name
  });

  @override
  Widget build(BuildContext context) {
    return Row(
     mainAxisAlignment: MainAxisAlignment.spaceBetween,
     children: [
       Row(
         children: [
           ShaderMask(
             shaderCallback: (bounds) => const LinearGradient(
               colors: [
                 Color(0xFFDCFFF6),
                 Color(0xFF18B78E),
               ],
               begin: Alignment.topCenter,
               end: Alignment.bottomCenter,
             ).createShader(bounds),
             child: Text(
               name,
               style: GoogleFonts.poppins(
                 fontSize: 20,
                 fontWeight: FontWeight.w700,
                 color: Colors.white,
               ),
             ),
           ),
           const SizedBox(
             width: 5,
           ),
           Text(
             '👋',
             style: GoogleFonts.poppins(
               fontSize: 20,
               fontWeight: FontWeight.w600,
               color: Colors.white,
             ),
           )
         ],
       ),
       Row(
         children: [
           CircleAvatar(
             backgroundColor: Colors.white.withOpacity(.2),
             child: Stack(
               clipBehavior: Clip.none,
               children: [
                 InkWell(
                   onTap: () {
                     Get.to(const NotificationPage());
                   },
                   child: const Icon(
                       Icons.notifications_none_outlined,
                       color: Colors.white),
                 ),
                 Positioned(
                     right: -3,
                     top: -2,
                     child: Container(
                         padding: const EdgeInsets.symmetric(
                             vertical: 2, horizontal: 5),
                         decoration: BoxDecoration(
                             color: const Color(0xffB3261E),
                             borderRadius:
                                 BorderRadius.circular(100)),
                         child: Text(
                           '2',
                           style: GoogleFonts.poppins(
                               color: whiteColor,
                               fontSize: 8,
                               fontWeight: FontWeight.w600),
                         )))
               ],
             ),
           ),
           const SizedBox(width: 10),
           GestureDetector(
             onTap: () {
               Get.to(SavedPostsPage());
             },
             child: CircleAvatar(
               backgroundColor: Colors.white.withOpacity(0.2),
               child: const Icon(Icons.bookmark_border_outlined,
                   color: Colors.white),
             ),
           ),
         ],
       ),
     ],
                        );
  }
}