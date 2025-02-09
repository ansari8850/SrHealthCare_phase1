import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:sr_health_care/Pages/authPages/login_pages.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/sharedference.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/spalsh/splash2.png',
      'title': 'Connect Through Healthcare',
      'description':
          'Stay informed and engaged with a dedicated platform tailored for healthcare professionals.',
    },
    {
      'image': 'assets/spalsh/splash2.png',
      'title': 'Collaborate With Peers',
      'description':
          'Join groups, share insights, and build a community with like-minded healthcare professionals.',
    },
    {
      'image': 'assets/spalsh/splash3.png',
      'title': 'Access Resources',
      'description':
          'Get access to exclusive healthcare resources to help you in your professional journey.',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Delay for 2 seconds before starting the onboarding process
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _currentPage = 1; // Start onboarding after splash screen
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentPage == 0
          ? const SplashScreen()
          : OnboardingContent(
              currentPage: _currentPage,
              onboardingData: onboardingData,
              onNext: () {
                setState(() {
                  if (_currentPage < onboardingData.length) {
                    _currentPage++;
                  } else {
                    SharedPreferenceHelper().saveOnbaordingView();

                    Get.off(() => const LoginPages());
                  }
                });
              },
              onSkip: () => Get.off(() {
                SharedPreferenceHelper().saveOnbaordingView();

                return const LoginPages();
              }),
            ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: buttonColor,
      child: Center(
        child: Image.asset(
          'assets/spalsh/splash1.png', // Replace with your splash screen image
          fit: BoxFit.fill,
          width: Get.width,
          height: Get.height,
        ),
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final int currentPage;
  final List<Map<String, String>> onboardingData;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingContent({
    super.key,
    required this.currentPage,
    required this.onboardingData,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 6,
          child: Image.asset(
            onboardingData[currentPage - 1]['image']!,
            fit: BoxFit.cover,
            width: Get.width,
          ),
        ),
        Expanded(
          flex: 4,
          child: ColoredBox(
            color: const Color.fromRGBO(34, 95, 80, 1),
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.only(top: 0, right: 20, left: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Title
                  Text(
                    onboardingData[currentPage - 1]['title']!,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xff2D1F99),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // Description
                  Text(
                    onboardingData[currentPage - 1]['description']!,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // Dots Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingData.length,
                      (index) => buildDot(index),
                    ),
                  ),
                  // Buttons
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff2D1F99),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: Size(Get.width, 48),
                        ),
                        onPressed: onNext,
                        child: Text(
                          currentPage == onboardingData.length
                              ? 'Get Started'
                              : 'Next',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xff2D1F99)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: Size(Get.width, 48),
                        ),
                        onPressed: onSkip,
                        child: Text(
                          'Skip',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff2D1F99),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Dot Indicator
  Widget buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 8,
      width: (currentPage - 1) == index ? 16 : 8,
      decoration: BoxDecoration(
        color:
            (currentPage - 1) == index ? const Color(0xff2D1F99) : Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

// class OnboardingContent extends StatelessWidget {
//   final String image;
//   final String title;
//   final String description;

//   const OnboardingContent({
//     Key? key,
//     required this.image,
//     required this.title,
//     required this.description,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Image.asset(image, height: 300),
//         const SizedBox(height: 32),
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.deepPurple,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: 16),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Text(
//             description,
//             style: const TextStyle(
//               fontSize: 16,
//               color: Colors.grey,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       ],
//     );
//   }
// }
