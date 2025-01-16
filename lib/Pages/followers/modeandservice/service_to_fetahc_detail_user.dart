import 'dart:convert';
import 'dart:developer';

import 'package:sr_health_care/Pages/followers/modeandservice/singleuserprofiledetail.dart';
import 'package:sr_health_care/const/sharedference.dart';
import 'package:http/http.dart' as http;

class ServiceToFetahcDetailUser {
  static final ServiceToFetahcDetailUser _instance =
      ServiceToFetahcDetailUser._internal();

  ServiceToFetahcDetailUser._internal();

  factory ServiceToFetahcDetailUser() => _instance;

  static const String baseUrl = "https://backend.srhealthcarecommunity.com/api/";

  Future<SingleUserPostDetail?> fetchPostUserDetail({
    String? postUsedId,
  }) async {
    final token = SharedPreferenceHelper().getAccessToken();
    final userId = SharedPreferenceHelper().getUserData()?.id;
    final url = Uri.parse('${baseUrl}post/details/user');

    try {
      final response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({"user_id": postUsedId}));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          return SingleUserPostDetail.fromJson(jsonResponse);
        } else {
          log('Failed to fetch saved posts: ${response.body}');
        }
      }
    } catch (e) {}
    return null;
  }
}
