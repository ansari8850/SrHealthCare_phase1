import 'package:sr_health_care/Pages/homePage/servicesModel/post_model_class.dart';

class SavedPostManager {
  static final SavedPostManager _instance = SavedPostManager._internal();
  factory SavedPostManager() => _instance;

  SavedPostManager._internal();

  final List<PostModel> _savedPosts = [];

  void savePost(PostModel post) {
    if (!_savedPosts.contains(post)) {
      _savedPosts.add(post);
    }
  }

  List<PostModel> get savedPosts => _savedPosts;
}
