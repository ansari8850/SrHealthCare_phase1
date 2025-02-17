// Search Page Widget
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sr_health_care/CustomWidget/app_cache_network_image.dart';
import 'package:sr_health_care/CustomWidget/expandable_text.dart';
import 'package:sr_health_care/CustomWidget/modal_bottom_sheet_home.dart';
import 'package:sr_health_care/CustomWidget/time_ago.dart';
import 'package:sr_health_care/Pages/Form_pages/field_response_model.dart';
import 'package:sr_health_care/Pages/homePage/post_detail_page.dart';
import 'package:sr_health_care/Pages/homePage/servicesModel/post_model_class.dart';
import 'package:sr_health_care/Pages/homePage/servicesModel/search_api.dart';
import 'package:sr_health_care/Pages/homePage/servicesModel/search_history_model.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/sharedference.dart';
import 'package:sr_health_care/const/text.dart';
import 'package:sr_health_care/services/share_plus_service.dart';

import 'servicesModel/home_api_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  List<PostModel> postList = [];
  bool isLoading = false;
  List<SearchModel> _searchHistory = [];
  final deBouncer = Debouncer(delay: const Duration(milliseconds: 200));
  final newDeBouncer = Debouncer(delay: const Duration(milliseconds: 500));
  @override
  void initState() {
    super.initState();
    _fetchSearchHistory();
    // getData();
  }

  // Method to fetch the search history data
  Future<void> _fetchSearchHistory() async {
    final result = await SearchApi().searchRecentHistory();

    if (result != null) {
      setState(() {
        _searchHistory =
            result.data ?? []; // Update the state with the fetched data
      });
    } else {
      log('No data found');
    }
  }

  Future<void> getData(
    String search, {
    String? fieldId,
    String? postType,
    String? date,
    bool fromFilter = false,
  }) async {
    postList.clear();
    if (search.isEmpty && !fromFilter) {
      setState(() {
        isLoading = false;
      });
      return;
    }
    setState(() {
      isLoading = true;
    });
    // _searchHistory.add(SearchModel(searchQuery: search));
    final (error, data) = await PostService().fetchPosts(
      search: search,
      currentPage: 1,
      noOfRec: 10,
      fieldId: fieldId ?? '',
      postType: postType ?? '',
      date: date ?? '',
    );
    if (error?.isNotEmpty == true || data == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error ?? 'Something went wrong')),
      );
    }
    if (searchController.text.isNotEmpty || fromFilter) {
      postList = data?.postList ?? [];
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // App Bar Section
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 23, 7, 168),
                    Color.fromARGB(255, 93, 53, 138)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [
                                Color(0xFFDCFFF6), // Bottom gradient color
                                Color(0xFF18B78E), // Top gradient color
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ).createShader(bounds),
                            child: Text(
                              "${SharedPreferenceHelper().getUserData()?.name} ${SharedPreferenceHelper().getUserData()?.lastName}",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors
                                    .white, // This color serves as a base for the gradient
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '👋',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors
                                  .white, // This color serves as a base for the gradient
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 18, color: Colors.white),
                      const SizedBox(width: 5),
                      Text(
                        "${SharedPreferenceHelper().getUserData()?.address ?? ''}",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: whiteColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextField(
                            controller: searchController,
                            onChanged: (value) {
                              deBouncer(() {
                                getData(value);
                              });
                              newDeBouncer(() {
                                if (value.length > 3) {
                                  _searchHistory
                                      .add(SearchModel(searchQuery: value));
                                }
                                setState(() {});
                              });
                            },
                            decoration: InputDecoration(
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                              hintText: "Search Posts, Categories...",
                              prefixIcon:
                                  const Icon(Icons.search, color: Colors.grey),
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.only(bottom: 5, top: 5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) => SortFilterBottomSheet(
                              onApplyFilter: (selectedFilters) {
                                getData(
                                  fromFilter: true,
                                  searchController.text,
                                  postType: (selectedFilters['Type']
                                          ?.firstOrNull as FieldTypeModel?)
                                      ?.name,
                                  date: selectedFilters['Date']?.firstOrNull !=
                                          null
                                      ? DateFormat('yyyy-MM-dd')
                                          .format(DateTime.now())
                                      : '',
                                  fieldId: (selectedFilters['Field']
                                          ?.firstOrNull as FieldTypeModel?)
                                      ?.id
                                      ?.toString(),
                                );
                              },
                            ),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: whiteColor,
                          child: Image.asset(
                            'assets/homepage/filter.png',
                            height: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          isLoading
              ? SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()))
              : postList.isEmpty
                  ?
                  //Previous Searches Section
                  SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, right: 10, left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CustomText(
                                    text: 'Previous searches',
                                    size: 14,
                                    color: Colors.black,
                                    weight: FontWeight.w500),
                                GestureDetector(
                                  onTap: () {
                                    SearchApi().deleteSearchHistory(context);
                                    setState(() {
                                      _fetchSearchHistory();
                                    });
                                  }, // Clear action
                                  child: Text(
                                    'Clear all',
                                    style: GoogleFonts.poppins(
                                        color: const Color(0xff6656E0),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // Display the list of recent searches in a Wrap widget
                          Wrap(
                            runAlignment: WrapAlignment.start,
                            spacing: 10, // Horizontal space between items
                            runSpacing: 10, // Vertical space between lines
                            children: _searchHistory.map((search) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: buttonColor.withValues(alpha: .1),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.grey.withValues(alpha: .4),
                                    width: .6,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize
                                      .min, // To prevent it from stretching
                                  children: [
                                    Image.asset(
                                      'assets/homepage/tag.png',
                                      height: 12,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(
                                      text: search.searchQuery ?? '',
                                      size: 13,
                                      color: Colors.black,
                                      weight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    )
                  // Main Content Section
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final post = postList[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(PostDetailPage(post: post));
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
                                          child: AppCacheNetworkImage(
                                            borderRadius: 50,
                                            imageUrl:
                                                post.user?.photo?.url ?? '',
                                            height: 100,
                                            width: Get.width,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                post.user?.name ?? '',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                post.user?.department ?? '',
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
                                              height: 12,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            TimeAgoCustomWidget(
                                              createdAt:
                                                  post.createdAt?.toString() ??
                                                      ' ',
                                              size: 10,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: AppCacheNetworkImage(
                                        imageUrl: post.thumbnail ?? '',
                                        fit: BoxFit.cover,
                                        height: 180,
                                        width: double.infinity,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ExpandableText(
                                      text: post.description ??
                                          '', // Pass the description here
                                      trimLength:
                                          100, // Optional: Adjust how many characters to display before truncating
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: _buildChip(
                                          post.postType?.fieldName ?? ''),
                                    ),
                                    const SizedBox(height: 10),
                                    Divider(
                                      thickness: .5,
                                      color: Colors.grey.withValues(alpha: .2),
                                    ),
                                    Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Obx(() {
                                        //   // Use the isPostSaved method to check if the post is saved
                                        //   bool isSaved = savepostController
                                        //       .isPostSaved(post.id ?? -1) as bool;

                                        //   return SaveButton(
                                        //     postId: post.id ?? -1,
                                        //     isSaved: isSaved,
                                        //   );
                                        // }),
                                        // SaveButton(isSaved:  post.isSaved  ?? true, postId: post.id??0),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            ShareService().shareText('text');
                                          },
                                          child: _buildAction(
                                              'assets/homepage/share.png',
                                              "Share"),
                                        ),
                                        // const Spacer(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: postList.length,
                      ),
                    ),
        ],
      ),
    );
  }

  Widget _buildChip(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.purple.withValues(alpha: .03),
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
            backgroundColor: const Color(0xffBAF0F4).withValues(alpha: .4),
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
