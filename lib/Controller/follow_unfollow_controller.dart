import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sr_health_care/Pages/homePage/servicesModel/follow_unfollow_api.dart';

class FollowController extends GetxController {
  static final instance = Get.find<FollowController>();
  var followingUsers = <String, bool>{}.obs; // User ID and follow status map
  final UserId = <int>[].obs;


  // Load saved follow status from SharedPreferences
  @override
  void onInit() {
    super.onInit();
    _loadFollowStatus();
  }

  // Load follow status from SharedPreferences
  Future<void> _loadFollowStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, bool> storedFollowingStatus = {};
    final keys = prefs.getKeys();

    for (var key in keys) {
      final isFollowing = prefs.getBool(key) ?? false;
      storedFollowingStatus[key] = isFollowing;
    }

    followingUsers.addAll(storedFollowingStatus);
  }

  /// Toggles follow state for a user and saves to SharedPreferences
  Future<void> toggleFollow(String userId, {required bool isFollowing}) async {
    if (isFollowing) {
      // API call to unfollow the user
      final result = await FollowUnfollowApi().UnfollowUser(userId);
      if (result.$1) {
        followingUsers[userId] = false;
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Success: Unfollowed successfully')),
        );
        // Save to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool(userId, false);
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Error: Failed to unfollow')),
        );
      }
    } else {
      // API call to follow the user
      final result = await FollowUnfollowApi().followUser(userId);
      if (result.$1) {
        followingUsers[userId] = true;
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Success: Followed successfully')),
        );
        // Save to SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool(userId, true);
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Error: Failed to follow')),
        );
      }
    }
  }

  /// Check if a user is being followed
  bool isFollowing(String userId) {
    return followingUsers[userId] ?? false;
  }
}
