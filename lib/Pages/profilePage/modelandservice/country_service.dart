import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sr_health_care/Pages/profilePage/modelandservice/city_model.dart';
import 'package:sr_health_care/Pages/profilePage/modelandservice/state_data_model.dart';
import 'country_data_model.dart'; // Import the model file

class CountryService {
  // Base URL of the API
  final String _baseUrl = "https://backend.srhealthcarecommunity.com/api"; // Replace with your actual base URL

  /// Fetch country data from the /getcountry endpoint
  Future<(String? error ,CountryDataModel?)> getCountryData() async {
    final url = Uri.parse("$_baseUrl/getcountry");

    try {
      // Send GET request
      final response = await http.post(url);
      final rawJson = jsonDecode(response.body);
      final message = rawJson['message'];

      // Check if the response status code is successful
      if (response.statusCode == 200) {
        // Parse the response body
        final data = CountryDataModel.fromJson(json.decode(response.body));
        return (null , data);
      } else {
        // Log or throw an error for unsuccessful responses
        log("Failed to fetch data: ${response.statusCode}");
        return (message.toString() , null);
      }
    } catch (e) {
      // Handle errors during the request
      log("Error occurred while fetching data: $e");
      return ("$e" , null);
    }
  }

  Future<(String? error, BasedOnCountryModel?)> getStateData(int countryId) async {
    final url = Uri.parse("$_baseUrl/getstate?country_id=$countryId");

    try {
      // Send GET request
      final response = await http.post(url);
      final rawJson = jsonDecode(response.body);
      final message = rawJson['message'];

      // Check if the response status code is successful
      if (response.statusCode == 200) {
        // Parse the response body
        final data = BasedOnCountryModel.fromJson(json.decode(response.body));
        return (null, data);
      } else {
        // Log or throw an error for unsuccessful responses
        log("Failed to fetch states: ${response.statusCode}");
        return (message.toString(), null);
      }
    } catch (e) {
      // Handle errors during the request
      log("Error occurred while fetching states: $e");
      return ("$e", null);
    }
}

 Future<(String?, CityResponseModel?)> getCityData(int stateId) async {
  final url = Uri.parse("$_baseUrl/getcity?state_id=$stateId");

  try {
    // Send POST request with the state ID as part of the body
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json", // Specify JSON content type
      },
      body: jsonEncode({"state_id": stateId}), // Pass state_id in the body
    );

    final rawJson = jsonDecode(response.body);
    final message = rawJson['message'];

    // Check if the response is successful
    if (response.statusCode == 200) {
      final data = CityResponseModel.fromJson(rawJson);
      return (null, data);
    } else {
      log("Failed to fetch cities: ${response.statusCode}");
      return (message.toString(), null);
    }
  } catch (e) {
    log("Error occurred while fetching cities: $e");
    return ("$e", null);
  }
}

}

