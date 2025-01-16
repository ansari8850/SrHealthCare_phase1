import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sr_health_care/Pages/homePage/servicesModel/api_response_model.dart';
import 'package:sr_health_care/Pages/homePage/servicesModel/filter_home_page_model.dart';
import 'package:sr_health_care/Pages/homePage/servicesModel/post_model_class.dart';
import 'package:sr_health_care/const/sharedference.dart';

class PostService {
  final String tokken = SharedPreferenceHelper().getAccessToken().toString();

  static const String apiUrl =
      'https://backend.srhealthcarecommunity.com/api/post/list';

  late final String bearerToken;

  PostService() {
    bearerToken = 'Bearer $tokken';
  }

  Future<(String? error, HomePostListModel?)> fetchPosts({
    String search = '',
    String customDate = '',
    String fromDate = '',
    String toDate = '',
    String type = '',
    String fieldId = '',
    String postType = '',
    String location = '',
    String date = '',
    String status = '',
  }) async {
    try {
      final body = {
        'search': search,
        'custom_date': customDate,
        'fromDate': fromDate,
        'toDate': toDate,
        'type': type,
        'field_id': fieldId,
        'post_type': postType,
        'location': location,
        'date': date,
        'status': status,
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': bearerToken,
        },
        body: json.encode(body),
      );
      final rawJson = jsonDecode(response.body);
      final message = rawJson['message'];
      log(response.body);

      if (response.statusCode == 200) {
        final data = HomePostListModel.fromJson(json.decode(response.body));
        return (null, data);
      } else {
        return (message.toString(), null);
      }
    } catch (e) {
      return ('$e', null);
    }
  }

  Future<PostModel?> fetchPostDetail({required int postid}) async {
    final tokken = SharedPreferenceHelper().getAccessToken();
    final url =
        Uri.parse('https://backend.srhealthcarecommunity.com/api/post/details');
        final UserId = SharedPreferenceHelper().getUserData()?.id;
    try {
      final response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $tokken',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "id": postid,
            "current_user_id": UserId
          }));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        log(response.body);
        return PostModel.fromJson(jsonResponse['result']);
      } else {
        log('Failed to Fetch profile : ${response.body}');
      }
    } catch (e) {
      log('Error: $e');
    }
    return null;
  }


Future<(String? error, FilterHomePageModel?)> fetchAllRecords() async {
  final tokken = SharedPreferenceHelper().getAccessToken();
  final url = Uri.parse('https://backend.srhealthcarecommunity.com/api/post/all/records');

  try {
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $tokken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      log(response.body);
      final data = FilterHomePageModel.fromJson(jsonResponse);
      return (null, data);
    } else {
      final errorResponse = jsonDecode(response.body);
      final message = errorResponse['message'] ?? 'Unknown error';
      log(message);
      return (message.toString(), null);
    }
  } catch (e) {
    log('Error: $e');
    return ('$e', null);
  }
}

}
