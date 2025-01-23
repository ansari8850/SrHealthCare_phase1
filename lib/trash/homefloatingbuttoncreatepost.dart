import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sr_health_care/Pages/Form_pages/create_post_form.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/text.dart';

class HomeFloatingButtonCreatePost extends StatelessWidget {
  const HomeFloatingButtonCreatePost({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2.5,
      // decoration: BoxDecoration(color: buttonColor),
      child: FloatingActionButton(
        backgroundColor: const Color(0xff402CD8),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () {
          Get.to(const CreatePostPage());
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.add,
              color: Colors.white,
            ),
            const SizedBox(
              width: 5,
            ),
            CustomText(
                text: 'Create Post',
                size: 14,
                color: whiteColor,
                weight: FontWeight.w400)
          ],
        ),
      ),
    );
  }
}
