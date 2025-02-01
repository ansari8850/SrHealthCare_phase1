import 'dart:convert';
import 'package:http/http.dart' as http;

class PostService {
  static const String apiUrl =
      'https://backend.srhealthcarecommunity.com/api/post/list';
  static const String bearerToken =
      'Aj8Us2lVm13DXw4mSRbOMEKdzBf2hUXrw8LVGLKP815f690c'; // Your Bearer token

  // Method to fetch posts with the Bearer token in headers
  Future<Map<String, dynamic>> fetchPosts({
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
      // Construct the body of the request
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

      // Send the POST request with Bearer token in headers
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $bearerToken', // Adding Bearer token
        },
        body: json.encode(body),
      );

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Parse the JSON response
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
