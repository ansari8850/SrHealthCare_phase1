import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/Controller/save_post_controller.dart';
import 'package:sr_health_care/CustomWidget/app_cache_network_image.dart';
import 'package:sr_health_care/CustomWidget/expandable_text.dart';
import 'package:sr_health_care/CustomWidget/save_unsaved_button.dart';
import 'package:sr_health_care/CustomWidget/time_ago.dart';
import 'package:sr_health_care/Pages/homePage/post_detail_page.dart';

import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/sharedference.dart';
import 'package:sr_health_care/services/share_plus_service.dart';
import 'package:sr_health_care/trash/NameNotificationSavedPost.dart';
import 'package:sr_health_care/trash/drop_down_homepage.dart';
import 'package:sr_health_care/trash/homefloatingbuttoncreatepost.dart';
import 'package:sr_health_care/trash/searchandfilterpage.dart';

import '../Pages/homePage/servicesModel/home_api_service.dart';
import '../Pages/homePage/servicesModel/post_model_class.dart';

final savepostController = SavePostController.instance;

class UniqueHomePage extends StatefulWidget {
  const UniqueHomePage({super.key});

  @override
  State<UniqueHomePage> createState() => _UniqueHomePageState();
}

class _UniqueHomePageState extends State<UniqueHomePage> {
  List<String> postTypes = [];
  String selectedTab = "All"; // Default tab
  String? selectedLocation;
  List<PostModel> postList = []; // List to hold posts
  bool isLoading = false; // Loading state
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  int noOfRef = 10;
  bool isPaginationLoading = false;
  String userName =
      "${SharedPreferenceHelper().getUserData()?.name} ${SharedPreferenceHelper().getUserData()?.lastName}";

  @override
  void initState() {
    super.initState();
    fetchPostTypeList(); // Fetch post types on init
    // getData(); // Initially fetch posts for "All"
    _scrollController.addListener(() {
      if (_scrollController.hasClients) {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          // Load more data if the user reaches the bottom
          getData(isLoadMore: true);
        }
      }
    });
  }

  // Fetch and display posts based on the selected tab
  Future<void> getData({bool isLoadMore = false}) async {
    if (isPaginationLoading) {
      return;
    }
    if (!isLoadMore) {
      currentPage = 1;
    }
    setState(() {
      if (!isLoadMore) {
        isLoading = true;
      } else {
        isPaginationLoading = true;
        currentPage++;
      }
    });

    try {
      // Use the selected location for filtering
      final locationFilter =
          (selectedLocation == "All" || selectedLocation == null)
              ? ''
              : selectedLocation;

      // Fetch posts from the service
      final (error, data) = await PostService().fetchPosts(
        location: locationFilter ?? '',
        currentPage: currentPage,
        noOfRec: noOfRef,
      );

      if (error?.isNotEmpty == true || data == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error ?? 'Something went wrong')),
        );
      } else {
        final allPosts = data.postList
                ?.where((element) => element.status == 'Approved')
                .toList() ??
            [];

        setState(() {
          if (!isLoadMore) {
            // Reset the post list if not loading more
            postList = allPosts;
          } else {
            // Filter out duplicates and append new posts
            postList.addAll(allPosts
                .where((post) =>
                    !postList.any((existingPost) => existingPost.id == post.id))
                .toList());
          }

          // Filter posts based on the selected tab
          if (selectedTab != "All") {
            postList = postList
                .where((post) => post.postType?.name == selectedTab)
                .toList();
          }
          // currentPage++;

          // if (data.postList?.isNotEmpty == true) {
          //   currentPage++;
          // }
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        isPaginationLoading = false;
        isLoading = false;
      });
    }
  }

// Fetch post type list and set the selected tab
  Future<void> fetchPostTypeList() async {
    // setState(() {
    //   isLoading = true; // Show loading indicator while fetching
    // });

    final fetchedPostTypes = await PostService().fetchPostTypeList();

    setState(() {
      isLoading = false; // Hide loading indicator after fetching

      // Add default "All" to the fetched list and remove duplicates
      postTypes = ["All"] + fetchedPostTypes.toSet().toList();

      // Set the default tab to the first post type, or "All" if no post types are available
      if (postTypes.isNotEmpty) {
        selectedTab = postTypes.first;
      }
    });

    // Fetch posts when the post types list is updated
    getData();
  }

// Tab click handler to update the selected tab and fetch sorted posts
  Widget _buildTab(String title, bool isActive) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = title; // Update the selected tab
          currentPage = 1;
        });
        getData(); // Fetch posts based on the selected tab
      },
      child: Container(
        alignment: Alignment.center,
        width: 100,
        height: 40,
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: isActive ? buttonColor : buttonColor.withOpacity(.03),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          title,
          style: GoogleFonts.poppins(
            color: isActive ? Colors.white : Colors.black87,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  // Build list of posts with UI as per provided code
  Widget _buildPostList() {
    if (isLoading) {
      return SliverToBoxAdapter(
          child: const Center(child: CircularProgressIndicator()));
    }
    if (postList.isEmpty) {
      return SliverToBoxAdapter(
        child: const Center(
          child: Text(
            "No posts available",
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }
    return SliverList.builder(
      itemCount: postList.length,
      itemBuilder: (context, index) {
        final post = postList[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: GestureDetector(
            onTap: () async {
              log('message');
              final value = await Get.to(() => PostDetailPage(
                    post: post,
                  ));
              log(value);
              if (value == true) {
                setState(() {
                  getData();
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 26,
                        backgroundColor: buttonColor,
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: buttonColor,
                          child: AppCacheNetworkImage(
                            width: Get.width,
                            borderRadius: 50,
                            imageUrl: post?.user?.photo?.url ?? '',
                            height: Get.height,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post?.userName ?? '',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              post?.user?.department ?? '',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/homepage/clock.png',
                            height: 15,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          TimeAgoCustomWidget(
                            createdAt: post.createdAt.toString(),
                            size: 10,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: AppCacheNetworkImage(
                      imageUrl: post?.thumbnail ?? '',
                      fit: BoxFit.cover,
                      height: 180,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ExpandableText(
                    text: post?.description ?? '',
                    trimLength: 100,
                  ),
                  const SizedBox(height: 10),
                  if (post?.fieldName != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _buildChip(post?.fieldName ?? ''),
                    ),
                  const SizedBox(height: 10),
                  Divider(
                    thickness: .5,
                    color: Colors.grey.withOpacity(.2),
                  ),
                  Row(
                    children: [
                      // In your post list item:
                      Obx(() {
                        final isSaved =
                            savepostController.isPostSaved(post.id ?? -1);
                        return SaveButton(postId: post.id ?? -1);
                      }),
                      const SizedBox(
                        width: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          ShareService().shareText(
                              'Hello This Is My Post on Sr HealthCare ${post?.thumbnail}');
                        },
                        child:
                            _buildAction('assets/homepage/share.png', "Share"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: Get.height / 4.2,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(255, 23, 7, 168),
                const Color.fromARGB(255, 93, 53, 138)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                  child: NameNotificationSavedPost(name: userName),
                ),
                DropdownExample(
                  onLocationSelected: (selectedLocation) {
                    setState(() {
                      this.selectedLocation = selectedLocation;
                    });
                    getData();
                  },
                ),
                const SearchAndFilterWidget(),
              ],
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: postTypes.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: postTypes.map((type) {
                        return _buildTab(type, selectedTab == type);
                      }).toList(),
                    ),
                  ),
          ),
          _buildPostList(),
          if (isPaginationLoading)
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              sliver: SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator())),
            ),
        ],
      ),
      floatingActionButton: HomeFloatingButtonCreatePost(),
    );
  }

  Widget _buildChip(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(.03),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/homepage/tag.png',
            height: 15,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAction(String image, String label) {
    return Row(
      children: [
        CircleAvatar(
            radius: 15,
            backgroundColor: const Color(0xffBAF0F4).withOpacity(.4),
            child: Image.asset(
              image,
              height: 15,
            )),
        const SizedBox(width: 5),
        Text(
          label,
          style: GoogleFonts.poppins(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: const Color(0xff6656E0)),
        ),
      ],
    );
  }
}
