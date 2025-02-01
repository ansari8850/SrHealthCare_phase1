import 'dart:convert';
import 'dart:developer';

import 'package:sr_health_care/Pages/Form_pages/field_response_model.dart';
import 'package:sr_health_care/const/sharedference.dart';
import 'package:http/http.dart' as http;

class CreatePostService {
  final String baseUrl = 'https://backend.srhealthcarecommunity.com/api';
  Future<String?> createPost({
    String? title,
    String? description,
    int? fieldId,
    String? location,
    String? date,
    String? autodeletedate,
    String? thumbnail,
    String? postType,
    int? postId,
  }) async {
    final token = SharedPreferenceHelper().getAccessToken();
    final userId = SharedPreferenceHelper().getUserData()?.id;
    final username = SharedPreferenceHelper().getUserData()?.name;
    final url = Uri.parse('$baseUrl/post/create/update');
    String message = '';
    try {
      final response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "user_id": userId,
            "user_name": username,
            "field_id": fieldId,
            "post_type": postType,
            "location": location,
            "date": date,
            "description": description,
            "thumbnail": thumbnail,
            "auto_delete_date": autodeletedate,
            "status": 'Pending',
            "title" :title,
            "post_id" :postId
          }));
      final jsonResponse = jsonDecode(response.body);
      log(response.body);
      if (response.statusCode == 200 && jsonResponse['status'] == 200) {
        // final data = CreatePostModel.fromJson(jsonResponse);

        return (jsonResponse['message']);
      } else {
        log('Failded to load ${response.body}');
        message = jsonResponse['message'];
      }
    } catch (e) {
      log("$e");
      message = e.toString();
    }
    return (message);
  }

Future<FiledResponseModel?> fethInitialData(
    String type,
  ) async {
    final token = SharedPreferenceHelper().getAccessToken();
    final url = Uri.parse(
 "https://backend.srhealthcarecommunity.com/api/master/list?fy=2024&noofrec=10&currentpage=1&type=$type", 
   );
    
    String message = '';
    try {
      final response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          );
      final jsonResponse = jsonDecode(response.body);
      log(response.body);
      if (response.statusCode == 200 ) {
        final data = FiledResponseModel.fromJson(jsonResponse);

        return data;
      } else {
        log('Failded to load ${response.body}');
        message = jsonResponse['message'];
      }
    } catch (e) {
      log("$e");
      message = e.toString();
    }
    return (null);
  }
 
  /// **Delete Post Service**
  Future<String?> deletePost(int id) async {
    final token = SharedPreferenceHelper().getAccessToken();
    final url = Uri.parse('$baseUrl/post/delete');
    String message = '';
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "id": id,
        }),
      );
      final jsonResponse = jsonDecode(response.body);
      log(response.body);
      if (response.statusCode == 200 && jsonResponse['status'] == 200) {
        message = jsonResponse['message'];
      } else {
        log('Failed to delete post: ${response.body}');
        message = jsonResponse['message'] ?? 'Failed to delete post';
      }
    } catch (e) {
      log("$e");
      message = e.toString();
    }
    return message;
  }
}
