import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sr_health_care/Pages/detailPost/modelandservices/report_post_model.dart';

class PostReportService {
  final String _baseUrl =
      "https://hrms.dragnilifecare.in/public/api/post/reported";
  final String _bearerToken =
      "Aj8Us2lVm13DXw4mSRbOMEKdzBf2hUXrw8LVGLKP815f690c";

  // Method to report a post
  Future<PostReported?> reportPost(
    int userId,
    String userName,
    int postId,
    String postTitle,
    String reason,
    String date,
    String status,
    BuildContext context,
  ) async {
    final url = Uri.parse(_baseUrl);

    // Show loading indicator while the API request is being made
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $_bearerToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'user_id': userId,
          'user_name': userName,
          'post_id': postId,
          'post_title': postTitle,
          'reason': reason,
          'date': date,
          'status': status,
        }),
      );

      // Close the loading indicator
      Navigator.of(context).pop();

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return PostReported.fromJson(responseData['post_reported']);
      } else {
        throw Exception('Failed to report post: ${response.body}');
      }
    } catch (error) {
      // Close the loading indicator
      Navigator.of(context).pop();
      throw Exception('Error reporting post: $error');
    }
  }
}
