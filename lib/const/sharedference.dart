import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sr_health_care/Pages/authPages/modelandclasses/login_model.dart';

class SharedPreferenceHelper {
  static final SharedPreferenceHelper _instance =
      SharedPreferenceHelper._internal();

  SharedPreferences? _prefs;

  SharedPreferenceHelper._internal();

  factory SharedPreferenceHelper() => _instance;

  // Initialize SharedPreferences instance
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static const String _accessTokenKey = "access_token";
  static const String _userData = "user_data";
  static const String onBoardingView = 'onboarding_view';

  // Save login data
  Future<void> saveLoginData(String accessToken, UserModel userData) async {
    await _prefs!.setString(_accessTokenKey, accessToken);
    await _prefs!.setString(_userData, jsonEncode(userData.toJson()));
  }

  // Get access token
  String? getAccessToken() {
    return _prefs!.getString(_accessTokenKey);
  }

  //Onboarding View
  Future<void> saveOnbaordingView() async {
    await _prefs!.setBool(onBoardingView, true);
  }

  // Get OnboardingView
  bool getOnboardingView() {
    return _prefs!.getBool(onBoardingView) ?? false;
  }

  // Get username
  UserModel? getUserData() {
    return _prefs!.getString(_userData) != null
        ? UserModel.fromJson(jsonDecode(_prefs!.getString(_userData)!))
        : null;
  }

  // Clear user data (Logout)
  Future<void> clearUserData() async {
    await _prefs!.remove(_accessTokenKey);
    await _prefs!.remove(_userData);
  }
}
