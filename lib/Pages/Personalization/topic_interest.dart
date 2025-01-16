import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/Pages/homePage/main_home_page.dart';

class TopicInterest extends StatefulWidget {
  const TopicInterest({super.key});

  @override
  State<TopicInterest> createState() => _TopicInterestState();
}

class _TopicInterestState extends State<TopicInterest> {
  int _currentPage = 0; // Track current page index
  final PageController _pageController = PageController();

  // Selection State
  final List<bool> _selectedTopics = List.generate(6, (index) => false);
  final List<bool> _selectedEvents = List.generate(5, (index) => false);
  final List<bool> _selectedPosts = List.generate(3, (index) => false);
  final List<bool> _selectedContent = List.generate(3, (index) => false);

  // Topics & Icons
  final List<String> topics = [
    "Wellness & Fitness",
    "Pharmaceuticals",
    "Nutrition & Diet",
    "Medical Equipment",
    "Disease Awareness",
    "Ayurveda",
  ];

  final List<String> topicImage = [
    'assets/personalize/img9.png',
    'assets/personalize/img5.png',
    'assets/personalize/img4.png',
    'assets/personalize/img2.png',
    'assets/personalize/img3.png',
    'assets/personalize/img1.png',
  ];

  final List<String> events = [
    "Webinars",
    "Conferences",
    "Health Camps",
    "Workshops",
    "Fundraisers",
  ];

  final List<String> eventImageData = [
    'assets/personalize/img6.png',
    'assets/personalize/img7.png',
    'assets/personalize/img12.png',
    'assets/personalize/img11.png',
    'assets/personalize/img3.png',
  ];
  final List<String> post = [
    "Events",
    "Job Openings",
    "Healthcare Products",
  ];

  final List<String> postType = [
    'assets/personalize/img7.png',
    'assets/personalize/img8.png',
    'assets/personalize/img3.png',
  ];
  final List<String> content = [
    "Daily",
    "Weekly",
    "Monthly",
  ];

  // Continue Button Logic
  bool get isButtonEnabled {
    if (_currentPage == 0) {
      return _selectedTopics.contains(true);
    } else if (_currentPage == 1) {
      return _selectedEvents.contains(true);
    } else {
      return true; // Enable button on other pages
    }
  }

  void _onContinuePressed() {
    if (_currentPage < 3) {
      setState(() {
        _currentPage++;
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    } else {
      print("Final Selection Complete!");
      // Final action or submission logic
    }
  }

  void _onBackPressed() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
        _pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  Widget _buildPaginationIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          height: 4,
          width: 80,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? const Color(0xff7F72E5)
                : const Color(0xff402CD8).withOpacity(.1),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildPostGrid(
      List<String> items, List<String> imageData, List<bool> selectedState) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200, // Adjust this to control item width
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 3 / 1, // Adjust the aspect ratio if needed
      ),
      itemBuilder: (context, index) {
        final bool isSelected = selectedState[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedState[index] = !selectedState[index];
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: isSelected
                    ? Colors.deepPurpleAccent
                    : Colors.grey.withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(imageData[index], height: 30),
                const SizedBox(width: 10),
                Flexible(
                  // flex: 1,
                  child: Text(
                    items[index],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color:
                          isSelected ? const Color(0xFF731E9E) : Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _newContent(List<String> items, List<bool> selectedState) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200, // Adjust this to control item width
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 3 / 0.9, // Adjust the aspect ratio if needed
      ),
      itemBuilder: (context, index) {
        final bool isSelected = selectedState[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedState[index] = !selectedState[index];
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: isSelected
                    ? Colors.deepPurpleAccent
                    : Colors.grey.withOpacity(0.3),
              ),
            ),
            child: Text(
              items[index],
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isSelected ? const Color(0xFF731E9E) : Colors.black87,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopicGrid(
      List<String> items, List<String> imageData, List<bool> selectedState) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 3 / 2,
      ),
      itemBuilder: (context, index) {
        final bool isSelected = selectedState[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedState[index] = !selectedState[index];
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: isSelected
                    ? Colors.deepPurpleAccent
                    : Colors.grey.withOpacity(0.3),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(imageData[index], height: 30),
                    const SizedBox(height: 5),
                    Text(
                      items[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? const Color(0xFF731E9E)
                            : Colors.black87,
                      ),
                    ),
                  ],
                ),
                Positioned(
                    right: 0,
                    top: 0,
                    child: Checkbox(
                      side: BorderSide(color: Colors.grey.withOpacity(.3)),
                      value: isSelected,
                      onChanged: (value) {
                        setState(() {
                          selectedState[index] = value!;
                        });
                      },
                      activeColor: const Color.fromARGB(255, 115, 30, 158),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEventsGrid() {
    return _buildTopicGrid(events, eventImageData, _selectedEvents);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Let Us Get To Know You Better!',
            style: GoogleFonts.inter(
              fontSize: 20,
              color: const Color(0xFF252525),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          _buildPaginationIndicator(),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // First Page Content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "What Topics Interest You The Most\nIn Healthcare?",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_currentPage < 1) {
                                setState(() {
                                  _currentPage++;
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                });
                              } else {
                                print("Skip: Final Submission Logic Here");
                              }
                            },
                            child: Text(
                              'Skip',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.withOpacity(.8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildTopicGrid(topics, topicImage, _selectedTopics),
                    ],
                  ),
                ),
                // Second Page Content
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "What Type Of Events Would You Like\nTo Explore?",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_currentPage < 2) {
                                setState(() {
                                  _currentPage++;
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                });
                              } else {
                                print("Skip: Final Submission Logic Here");
                              }
                            },
                            child: Text(
                              'Skip',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.withOpacity(.8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildEventsGrid(),
                    ],
                  ),
                ),
                // Third Page (From Screenshot)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "What Type Of Posts Interest You\nThe Most?",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_currentPage < 3) {
                                setState(() {
                                  _currentPage++;
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                });
                              } else {
                                print("Skip: Final Submission Logic Here");
                              }
                            },
                            child: Text(
                              'Skip',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.withOpacity(.8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _buildPostGrid(post, postType, _selectedPosts),
                    ],
                  ),
                ),

                // Fourth Page (From Screenshot)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "How Often Do You Want To See New\nContent?",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigate to homepage directly when Skip is clicked
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) =>
                              //         const MainHomePage(), // Replace with your homepage widget
                              //   ),
                              // );
                            },
                            child: Text(
                              'Skip',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.withOpacity(.8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _newContent(content, _selectedContent)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                if (_currentPage > 0)
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (_currentPage > 0) {
                          // Move to the previous page
                          setState(() {
                            _currentPage--;
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          });
                        }
                      },
                      child: const Text(
                        "Back",
                        style: TextStyle(color: Colors.black87),
                      ),
                    ),
                  ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isButtonEnabled
                          ? Colors.deepPurpleAccent
                          : Colors.grey.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      if (_currentPage < 3) {
                        // Move to the next page
                        setState(() {
                          _currentPage++;
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        });
                      } else {
                        // Navigate to the homepage if it's the last page
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //         const MainHomePage(), // Replace with your homepage widget
                        //   ),
                        // );
                      }
                    },
                    child: const Text(
                      "Continue",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
