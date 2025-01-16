import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:sr_health_care/Pages/authPages/modelandclasses/login_model.dart';
import 'package:sr_health_care/const/sharedference.dart';

class ApiService {
  // Base URL for API requests
  static const String baseUrl = "https://backend.srhealthcarecommunity.com/api/";

  // Method for login
  Future<(String? error, LoginModelClass?)?> login(
      String email, String password) async {
    final url = Uri.parse("${baseUrl}mobile_login");

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      log("Login Response:: ${response.body}");
      final rawJson = jsonDecode(response.body);

      final error = rawJson['error'];
      final message = rawJson['message'];

      if (response.statusCode == 200 && (error is bool && error == false)) {
        try {
          final data = LoginModelClass.fromJson(jsonDecode(response.body));
          return (null, data);
        } catch (e) {
          return ("$e", null);
        }

        // Check if there is an error
        // if (data.error == false) {
        //   return {
        //     "success": true,
        //     "data": data,
        //   }; // Success response
        // } else {
        //   return {
        //     "success": false,
        //     "message": data['message'],
        //   }; // Error message from server
        // }
      } else {
        return (message.toString(), null);
        // return {
        //   "success": false,
        //   "message": "Invalid credentials or server error",
        // }; // Generic error message for non-200 response
      }
    } catch (e) {
      return ("$e", null);
      // return {
      //   "success": false,
      //   "message": "Network error: ${e.toString()}",
      // }; // Catch any network or parsing errors
    }
  }

  // Logout function
  Future<void> logout() async {
    // Clear shared preferences data
    await SharedPreferenceHelper().clearUserData();
  }

  //Method to send OTP
  Future<Map<String, dynamic>> sendOtp(String email) async {
    final url = Uri.parse('${baseUrl}mobile_email_get_otp');
    try {
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "email": email,
          }));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        return {
          'sucess': false,
          "message": "Failed to send OTP .Please try again"
        };
      }
    } catch (e) {
      return {"sucess": false, "message": "An error occured : ${e.toString()}"};
    }
  }

//Method to validateOtp
  Future<Map<String, dynamic>> validateOtp(String email, String otp) async {
    final url = Uri.parse(
        '$baseUrl/mobile_validate_otp'); // Endpoint for OTP validation

    try {
      // Making the POST request
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'otp': otp,
        }),
      );

      // Handling the response
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the data
        return json.decode(response.body);
      } else {
        // If the server returns an error, handle it here
        return {
          "error": true,
          "message": "Failed to validate OTP. Please try again."
        };
      }
    } catch (e) {
      // Catching any errors during the request
      return {"error": true, "message": "An error occurred. Please try again."};
    }
  }

//Mehtod to Get New Password On Whatsapp Number

Future<Map<String, dynamic>> sendPasswordResetToWhatsapp(String mobileNo) async {
    final url = Uri.parse('${baseUrl}mobile_forgot_password');
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          // "Authorization": "Bearer $token", // Add the Bearer token here
        },
        body: jsonEncode({
          "mobile_no": mobileNo, // Pass the mobile number in the body
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          "error": true,
          "message": "Failed to send the password reset request."
        };
      }
    } catch (e) {
      return {"error": true, "message": "An error occurred: $e"};
    }
  }
}
