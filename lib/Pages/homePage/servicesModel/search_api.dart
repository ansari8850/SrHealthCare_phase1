import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sr_health_care/Pages/homePage/servicesModel/search_history_model.dart';
import 'package:sr_health_care/const/sharedference.dart';
import 'package:http/http.dart' as http;


class SearchApi {
  static final SearchApi _instance = SearchApi._internal();

  SearchApi._internal();

  factory SearchApi() => _instance;

  final String baseUrl = 'https://backend.srhealthcarecommunity.com/api';

 Future<SearchHistoryModel?> searchRecentHistory() async {
  final token = await SharedPreferenceHelper().getAccessToken(); // Ensure this returns a Future.
  final url = Uri.parse('$baseUrl/search/history/list');

  try {
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body); // Decode the response body.
      log(response.body);

      // Map the response to the SearchHistoryModel class.
      return SearchHistoryModel.fromJson(jsonResponse);
    } else {
      log('Failed to Fetch Profile: ${response.body}');
    }
  } catch (e) {
    log('Error: $e');
  }

  return null; // Return null if the request fails.
}

Future<void> deleteSearchHistory(BuildContext context) async {
    final token = await SharedPreferenceHelper().getAccessToken(); // Ensure this returns a Future.
    final url = Uri.parse('$baseUrl/search/history/clear');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        log('Response: ${jsonResponse['message']}');
        // Show the message in the snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonResponse['message'] ?? 'Search history cleared successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to clear search history.')),
        );
      }
    } catch (e) {
      log('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred while clearing search history.')),
      );
    }

}
}