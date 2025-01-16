import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sr_health_care/Pages/detailPost/modelandservices/post_detail_model.dart';

class PostService {
  final String _baseUrl =
      "https://backend.srhealthcarecommunity.com/api/post/details";
  final String _bearerToken =
      "Aj8Us2lVm13DXw4mSRbOMEKdzBf2hUXrw8LVGLKP815f690c";

  // Method to fetch post details
  Future<PostDetail> fetchPostDetails(int postId) async {
    final url = Uri.parse(_baseUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $_bearerToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'id': postId.toString(),
        }), // Send the postId in the body as a JSON object
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return PostDetail.fromJson(responseData);
      } else {
        throw Exception('Failed to load post details');
      }
    } catch (error) {
      throw Exception('Error fetching post details: $error');
    }
  }
}
