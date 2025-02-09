import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/Controller/save_post_controller.dart';
import 'package:sr_health_care/const/colors.dart';

enum LayoutType { horizontal, vertical }

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
    required this.postId,
    this.layoutType = LayoutType.horizontal, // Default to horizontal
  });

  final int postId;
  final LayoutType layoutType;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SavePostController>();

    return Obx(() {
      final isSaved = controller.isPostSaved(postId);

      // Decide the layout based on the layoutType parameter
      if (layoutType == LayoutType.horizontal) {
        return InkWell(
          onTap: () => controller.toggleSave(postId, currentState: isSaved),
          child: Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor: const Color(0xffBAF0F4).withOpacity(.4),
                child: Image.asset(
                  isSaved
                      ? 'assets/myfeed/save.png'
                      : 'assets/homepage/save.png',
                  height: 15,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                isSaved ? 'Unsave' : 'Save',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff6656E0),
                ),
              ),
            ],
          ),
        );
      } else {
        // Vertical layout
        return InkWell(
          onTap: () => controller.toggleSave(postId, currentState: isSaved),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                isSaved ? 'assets/myfeed/save.png' : 'assets/homepage/save.png',
                height: 15,
              ),
              const SizedBox(height: 8),
              Text(
                isSaved ? 'Unsave' : 'Save',
                style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: blackColor),
              ),
            ],
          ),
        );
      }
    });
  }
}
