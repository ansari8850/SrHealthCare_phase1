import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sr_health_care/Controller/follow_unfollow_controller.dart';
import 'package:sr_health_care/Controller/save_post_controller.dart';
import 'package:sr_health_care/Pages/authPages/login_pages.dart';
import 'package:sr_health_care/Pages/splash/screen1.dart';
import 'package:sr_health_care/const/sharedference.dart';
import 'package:sr_health_care/firebase_options.dart';
import 'Global/bottom_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await SharedPreferenceHelper().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    Get.put(FollowController());
    Get.put(SavePostController());
    

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sr HealthCare Community',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SharedPreferenceHelper().getAccessToken() != null
          ? const BottomNavPage()
          : SharedPreferenceHelper().getOnboardingView()
              ? const LoginPages()
              : const OnboardingScreens(),
    );
  }
}
