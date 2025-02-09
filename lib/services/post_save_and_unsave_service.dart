import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sr_health_care/Pages/profilePage/modelandservice/bookmarkpostlistmodel.dart';
import 'package:sr_health_care/const/sharedference.dart';
import 'package:http/http.dart' as http;

class PostSaveAndUnsaveService {
  static final PostSaveAndUnsaveService _instance =
      PostSaveAndUnsaveService._internal();

  PostSaveAndUnsaveService._internal();

  factory PostSaveAndUnsaveService() => _instance;

  static const String baseUrl =
      "https://backend.srhealthcarecommunity.com/api/";

  /// Save Post Method
  Future<bool> savePost({
    required String postId,
    required BuildContext context,
  }) async {
    final token = SharedPreferenceHelper().getAccessToken();
    final userId = SharedPreferenceHelper().getUserData()?.id;
    final url = Uri.parse('${baseUrl}post/bookmark/add');
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "user_id": userId.toString(),
          "post_id": postId,
        }),
      );
      if (response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          log('Post saved successfully: ${jsonResponse['message']}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(jsonResponse['message'])),
          );
          return true;
        } else {
          log('Failed to save post: ${response.body}');
        }
      } else {
        log('Error while saving post: ${response.statusCode}');
      }
    } catch (e) {
      log("Error while saving post: $e");
    }
    return false;
  }

  /// Fetch Saved Posts Method
  Future<BookmarkPostListModel?> fetchSavedPosts(
      {required BuildContext context}) async {
    final token = SharedPreferenceHelper().getAccessToken();
    final userId = SharedPreferenceHelper().getUserData()?.id;
    final url = Uri.parse('${baseUrl}post/bookmark/user');
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"user_id": userId.toString()}),
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        log('Fetched saved posts: ${jsonResponse['data']}');

        if (jsonResponse['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Saved posts fetched successfully!'),
              duration: Duration(seconds: 2),
            ),
          );
          return BookmarkPostListModel.fromJson(jsonResponse);
        } else {
          log('Failed to fetch saved posts: ${response.body}');
        }
      } else {
        log('Error while fetching saved posts: ${response.statusCode}');
      }
    } catch (e) {
      log("Error while fetching saved posts: $e");
    }
    return null;
  }

  /// Remove Saved Post Method
  Future<bool> removeSavedPost({
    required String postId,
    required BuildContext context,
  }) async {
    final token = SharedPreferenceHelper().getAccessToken();
    final userId = SharedPreferenceHelper().getUserData()?.id;
    final url = Uri.parse('${baseUrl}post/bookmark/remove');
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "user_id": userId.toString(),
          "post_id": postId,
        }),
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          log('Post removed successfully: ${jsonResponse['message']}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(jsonResponse['message'])),
          );
          return true;
        } else {
          log('Failed to remove post: ${response.body}');
        }
      } else {
        log('Error while removing post: ${response.statusCode}');
      }
    } catch (e) {
      log("Error while removing post: $e");
    }
    return false;
  }

  /// Report Post Method
  Future<bool> reportPost({
    required int userId,
    required String userName,
    required int postId,
    required String postTitle,
    required String reason,
    required String date,
    required BuildContext context,
  }) async {
    final token = SharedPreferenceHelper().getAccessToken();
    final url = Uri.parse('${baseUrl}post/reported');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "user_id": userId,
          "user_name": userName,
          "post_id": postId,
          "post_title": postTitle,
          "reason": reason,
          "date": date,
          "status": "Reported",
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse['success'] == true) {
          log('Post reported successfully: ${jsonResponse['message']}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(jsonResponse['message'])),
          );
          return true;
        } else {
          log('Failed to report post: ${response.body}');
        }
      } else {
        log('Error while reporting post: ${response.statusCode}');
      }
    } catch (e) {
      log("Error while reporting post: $e");
    }

    return false;
  }
}
