import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sr_health_care/services/post_save_and_unsave_service.dart';

class SavePostController extends GetxController {
  static final instance = Get.find<SavePostController>();
  var savedPosts = <int, bool>{}.obs; // Map to hold postId and its save status

  final savedPostID = <int>[].obs;
  final follwingIdList = <int>[].obs;

  // Fetch saved posts and initialize the savedPosts map
  Future<void> fetchSavedPosts(BuildContext context) async {
    final bookmarkPostListModel = await PostSaveAndUnsaveService().fetchSavedPosts(context: context);
    if (bookmarkPostListModel != null) {
      // Assuming bookmarkPostListModel has a list of saved post IDs
      savedPostID.assignAll(bookmarkPostListModel.data!.map((post) => post.id ?? -1)); // Adjust according to your model
      for (var postId in savedPostID) {
        savedPosts[postId] = true; // Mark as saved
        await _savePostState(postId, true); // Save to shared preferences
      }
    }
  }

  // Toggle save state for a post
  Future<void> toggleSave(int postId, {required bool isSaved, required Function onStateChange}) async {
    if (isSaved) {
      // Call API or service to unsave the post
      final result = await PostSaveAndUnsaveService().removeSavedPost(postId: postId.toString(), context: Get.context!);
      if (result) {
        savedPosts[postId] = false;
        await _savePostState(postId, false); // Update shared preferences
        onStateChange();
      }
    } else {
      // Call API or service to save the post
      final result = await PostSaveAndUnsaveService().savePost(postId: postId.toString(), context: Get.context!);
      if (result) {
        savedPosts[postId] = true;
        await _savePostState(postId, true); // Update shared preferences
        onStateChange();
      }
    }
  }

  // Get the saved state of a post
  bool isPostSaved(int postId) {
    return savedPosts[postId] ?? false;
  }

  // Save the state of a post to shared preferences
  Future<void> _savePostState(int postId, bool isSaved) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(postId.toString(), isSaved);
  }

  // Load the saved state of posts from shared preferences
  Future<void> loadSavedPostStates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var postId in savedPostID) {
      bool isSaved = prefs.getBool(postId.toString()) ?? false; // Default to false if not found
      savedPosts[postId] = isSaved; // Update the savedPosts map
    }
  }
}