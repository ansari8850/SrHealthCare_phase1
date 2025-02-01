import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:sr_health_care/Pages/homePage/servicesModel/post_model_class.dart';
import 'package:sr_health_care/Pages/profilePage/modelandservice/following_model.dart';
import 'package:sr_health_care/Pages/profilePage/modelandservice/login_user_profile.dart';
import 'package:sr_health_care/const/sharedference.dart';
import 'package:sr_health_care/services/firebase_storage.dart';

class UserProfileApiService {
  static final UserProfileApiService _instance =
      UserProfileApiService._internal();

  UserProfileApiService._internal();

  factory UserProfileApiService() => _instance;

  final String baseUrl = 'https://backend.srhealthcarecommunity.com/api';

  Future<LoginUserProfile?> fetchUserProfile() async {
    final token = SharedPreferenceHelper().getAccessToken();
    final userId = SharedPreferenceHelper().getUserData()?.id;
    final url = Uri.parse('$baseUrl/mobile_user_profile');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "id": userId,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        log(response.body);
        return LoginUserProfile.fromJson(jsonResponse['result']);
      } else {
        log('Failed to fetch profile: ${response.body}');
      }
    } catch (e) {
      log('Error: $e');
    }
    return null;
  }

  Future<String?> updateProfile({
    File? image,
    String? email,
    String? name,
    String? lastname,
    String? mobileNumber,
    String? emrMobileNumber,
    String? displayName,
    String? address,
    dynamic zipCode,
    String? bio,
    String? street1,
    String? street2,
  }) async {
    final token = SharedPreferenceHelper().getAccessToken();
    final userId = SharedPreferenceHelper().getUserData()?.id;
    String? imageUrl;
    if(image != null){
    imageUrl=await  FirebaseStorageService().uploadFile(image);
    }

    final url = Uri.parse('$baseUrl/mobile_update_profile');
    final payLoad = {};
     payLoad['id'] = userId;
    if (email != null) {
      payLoad['email'] = email;
    }
    if (name != null) {
      payLoad['name'] = name;
    }
    if (mobileNumber != null) {
      payLoad['last_name'] = lastname;
    }
    if (displayName != null) {
      payLoad['display_name'] = displayName;
    }
    if (bio != null) {
      payLoad['bio'] = bio;
    }
    if (street1 != null) {
      payLoad['street1'] = street1;
    }
    if (street2 != null) {
      payLoad['street2'] = street2;
    }
    if (zipCode != null) {
      payLoad['zip_code'] = zipCode;
    }
    if (address != null) {
      payLoad['address'] = address;
    }
    if (mobileNumber != null) {
      payLoad['mobile_no'] = mobileNumber;
    }
    if (emrMobileNumber != null) {
      payLoad['emr_mobile_no'] = emrMobileNumber;
    }
    if(imageUrl != null){
      payLoad['photo'] = PhotoModel(url: imageUrl,name: name).toJson();
    }

    try {
      final response = await http.post(url,
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
          body: jsonEncode(payLoad));
      log(response.body);
      final message = jsonDecode(response.body)?['message'];
      if (message is String && message.contains('success')) {
        var data = SharedPreferenceHelper().getUserData()?.copyWith(
              id: userId,
              email: email,
              name: name,
              lastName: lastname,
              mobileNo: mobileNumber,
              emrMobileNo: emrMobileNumber,
            );
            if(imageUrl != null){
            data = data?.copyWith(photo: PhotoModel(url: imageUrl,name: name));
            } 

        SharedPreferenceHelper().saveLoginData(token!, data!);
      }
      log(message);
      return message;
    } catch (e) {
      log('Error: $e');
    }
    return null;
  }

  Future<UserFollowing> fetchFollowing() async {
    final token = SharedPreferenceHelper().getAccessToken();
    final userId = SharedPreferenceHelper().getUserData()?.id;
    final url = Uri.parse('$baseUrl/user/web/following');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "user_id": userId,
          // "search": " ",
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        log(response.body);
        return UserFollowing.fromJson(jsonResponse);
      } else {
        log('Failed to fetch profile: ${response.body}');
      }
    } catch (e) {
      log('Error: $e');
    }
    return UserFollowing(success: false, totalCount: 0, followings: []);
  }

  Future<UserFollowing> fetchFollowers() async {
    final token = SharedPreferenceHelper().getAccessToken();
    final userId = SharedPreferenceHelper().getUserData()?.id;
    final url = Uri.parse('$baseUrl/user/web/followers');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "user_id": userId,
          // "search": " ",
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        log(response.body);
        return UserFollowing.fromJson(jsonResponse);
      } else {
        log('Failed to fetch profile: ${response.body}');
      }
    } catch (e) {
      log('Error: $e');
    }
    return UserFollowing(success: false, totalCount: 0, followers: []);
  }
}
