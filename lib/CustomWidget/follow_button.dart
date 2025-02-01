import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sr_health_care/Controller/follow_unfollow_controller.dart';
import 'package:sr_health_care/const/colors.dart';

import '../Pages/homePage/servicesModel/post_model_class.dart';
final followUnfollow = FollowController.instance;



class FollowButton extends StatelessWidget {
  final User user; // Replace with your actual user model
  final VoidCallback onFollowStatusChange;

  FollowButton({required this.user, required this.onFollowStatusChange});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FollowController>();

    return Obx(() {
      print(controller.UserId);
      final isFollowing = user.isFollowing ?? false;

      return GestureDetector(
        onTap: () async {
          await controller.toggleFollow(user.id.toString(), isFollowing: isFollowing);
          onFollowStatusChange();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 7 , horizontal: 10),
          decoration: BoxDecoration(
            color: isFollowing ? Colors.green : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isFollowing ? Colors.green : buttonColor,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isFollowing) ...[
                Icon(Icons.check, color: Colors.white, size: 14),
                const SizedBox(width: 5),
                Text(
                  'Following',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ] else ...[
                Icon(Icons.add, color: buttonColor, size: 14),
                const SizedBox(width: 5),
                Text(
                  'Follow',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: buttonColor,
                  ),
                ),
              ],
            ],
          ),
        ),
      );
    });
  }
}
