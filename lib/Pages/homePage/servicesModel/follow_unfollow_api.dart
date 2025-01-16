import 'dart:convert';
import 'dart:developer';

import 'package:sr_health_care/const/sharedference.dart';
import 'package:http/http.dart' as http;

class FollowUnfollowApi {
  static final FollowUnfollowApi _instance = FollowUnfollowApi._internal();

  FollowUnfollowApi._internal();

  factory FollowUnfollowApi() => _instance;

  final String baseUrl = 'https://backend.srhealthcarecommunity.com/api';

  Future<(bool, String)> followUser(
    String? followerID,
    // String? UserId,
  ) async {
    final token = SharedPreferenceHelper().getAccessToken();
    final userId = SharedPreferenceHelper().getUserData()?.id;
    final url = Uri.parse('$baseUrl/user/follow');
    String message = '';
    try {
      final response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            // "follower_id": userId,
            "follower_id": followerID,
            "user_id" : userId

          }));
          if(response.statusCode == 200){
            log(response.body);
          };
      log(response.body);
      message = jsonDecode(response.body)?['message'];
      if (message.contains('Successfully')) {
        return (true, message);
      } else {
        log('Failed to follow user: ${response.body}');
      }
    } catch (e) {
      log(message);
      message = 'Error: $e';
    }
    return (false, message);
  }

  Future<(bool, String)> UnfollowUser(
    String? followerID,
    // String? UserId,
  ) async {
    final token = SharedPreferenceHelper().getAccessToken();
    final userId = SharedPreferenceHelper().getUserData()?.id;
    final url = Uri.parse('$baseUrl/user/unfollow');
    String message = '';
    try {
      final response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "follower_id": followerID,
            "user_id": userId,

          }));
      log(response.body);
      message = jsonDecode(response.body)?['message'];
      if (message.contains('Successfully')) {
        return (true, message);
      } else {
        log('Failed to follow user: ${response.body}');
      }
    } catch (e) {
      log(message);
      message = 'Error: $e';
    }
    return (false, message);
  }
}
