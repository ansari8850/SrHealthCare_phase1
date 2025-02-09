import 'package:get/get.dart';
import 'package:sr_health_care/Pages/homePage/servicesModel/home_api_service.dart';
import 'package:sr_health_care/services/post_save_and_unsave_service.dart';

class SavePostController extends GetxController {
  static final instance = Get.find<SavePostController>();
  final savedPosts =
      <int, int>{}.obs; // Key: postId, Value: 1(saved) or 0(unsaved)

  @override
  void onInit() {
    loadSavedPosts();
    super.onInit();
  }

  // Load initial saved posts from API
  Future<void> loadSavedPosts() async {
    final (error, postListModel) = await PostService().fetchPosts(
      currentPage: 1,
      noOfRec: 20,
    );

    if (postListModel != null) {
      for (var post in postListModel.postList ?? []) {
        savedPosts[post.id ?? -1] = post.isSaved ?? 0;
      }
    }
  }

  // Toggle save state
  Future<void> toggleSave(int postId, {required bool currentState}) async {
    try {
      final newState = currentState ? 0 : 1;

      // Update local state first
      savedPosts[postId] = newState;

      // Call API
      final success = currentState
          ? await PostSaveAndUnsaveService().removeSavedPost(
              postId: postId.toString(),
              context: Get.context!,
            )
          : await PostSaveAndUnsaveService().savePost(
              postId: postId.toString(),
              context: Get.context!,
            );

      if (!success) {
        // Revert if API call fails
        savedPosts[postId] = currentState ? 1 : 0;
      }
    } catch (e) {
      savedPosts[postId] = currentState ? 1 : 0;
      rethrow;
    }
  }

  bool isPostSaved(int postId) => savedPosts[postId] == 1;
}
