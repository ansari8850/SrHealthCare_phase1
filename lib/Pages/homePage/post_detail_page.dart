import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sr_health_care/CustomWidget/app_cache_network_image.dart';
import 'package:sr_health_care/CustomWidget/dotted_divider.dart';
import 'package:sr_health_care/CustomWidget/follow_button.dart';
import 'package:sr_health_care/CustomWidget/time_ago.dart';
import 'package:sr_health_care/Pages/detailPost/report_post.dart';
import 'package:sr_health_care/Pages/followers/follower_profile.dart';
import 'package:sr_health_care/Pages/homePage/main_home_page.dart';
import 'package:sr_health_care/Pages/homePage/servicesModel/home_api_service.dart';
import 'package:sr_health_care/Pages/homePage/servicesModel/post_model_class.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/sharedference.dart';
import 'package:sr_health_care/services/post_save_and_unsave_service.dart';
import 'package:sr_health_care/services/share_plus_service.dart';
import 'package:sr_health_care/services/whatsapp_service.dart';

class PostDetailPage extends StatefulWidget {
  final PostModel post;

  const PostDetailPage({super.key, required this.post});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  bool isFollowing = false;
  bool isLoading = true;
  PostModel? _postDetail;
  final bool _isSaved = false;

  void _fetchUserDetail() async {
    setState(() {
      isLoading = true; // Start loading
    });

    try {
      _postDetail =
          await PostService().fetchPostDetail(postid: widget.post?.id ?? -1);
    } catch (e) {
      debugPrint("Error fetching post details: $e");
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserDetail();
    
  }

  bool isPostSaved = false;

  Future<void> savePost() async {
    final bool success = await PostSaveAndUnsaveService().savePost(
      postId: _postDetail!.id.toString(),
      context: context,
    );

    if (success) {
      setState(() {
        isPostSaved = !isPostSaved; // Toggle the saved status
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isPostSaved
              ? 'Post saved successfully!'
              : 'Post unsaved successfully!'),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to save the post. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // SliverAppBar with image
          SliverAppBar(
            stretch: false,
            scrolledUnderElevation: 100,
            automaticallyImplyLeading: false,
            expandedHeight: MediaQuery.of(context).size.height / 2.5,
            flexibleSpace: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                    // height: MediaQuery.of(context).size.height / 2,
                    height: 350,
                    width: MediaQuery.of(context).size.width,
                    child: AppCacheNetworkImage(
                      imageUrl: _postDetail?.thumbnail ?? '',
                      fit: BoxFit.cover,
                    )),
                Positioned(
                  bottom: -3,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 10,
                    alignment: Alignment.bottomCenter,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(100),
                            topRight: Radius.circular(100))),
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                  ),
                ),
              ],
            ),
            leading: IconButton(
              color: Colors.white,
              icon: CircleAvatar(
                  radius: 15,
                  backgroundColor: whiteColor,
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.green,
                    size: 17,
                  )),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Padding
                  const SizedBox(height: 16),

                  // Action Buttons
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,/
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            ShareService().shareText(
                                'Sr HealthCare Community ${_postDetail?.title ?? ''}');
                          },
                          child: _buildActionIcon(
                              'assets/detailpost/share.png', "Share")),
                      const SizedBox(
                        width: 20,
                      ),
                    SaveButton(isSaved:_postDetail?.isSaved == -1, postId: _postDetail!.id ?? -1, layoutType: Axis.vertical,),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16)),
                            ),
                            builder: (BuildContext context) {
                              return const ReportPost();
                            },
                          );
                        },
                        child: _buildActionIcon(
                            'assets/detailpost/report.png', "Report"),
                      ),
                      const Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Image.asset(
                            'assets/homepage/clock.png',
                            height: 15,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          TimeAgoCustomWidget(
                            createdAt: _postDetail?.createdAt.toString() ?? '',
                            size: 12,
                          ),
                        ],
                      )
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: MySeparator(
                      // height: 10,
                      color: Colors.grey.withOpacity(.3),
                    ),
                  ),

                  // Profile Details
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ListTile(
                          onTap: () {
                            Get.to(FollowerProfile(
                              postUsedId: _postDetail?.userId.toString() ?? '',
                            ));
                            
                          },
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            radius: 21,
                            backgroundColor: buttonColor,
                            child: CircleAvatar(
                              radius: 20,
                              // backgroundImage: AssetImage(post.user?.photo ?? ''),
                              child: AppCacheNetworkImage(
                                imageUrl: _postDetail?.user?.photo?.url ?? '',
                                fit: BoxFit.cover,
                                borderRadius: 50,
                                width: Get.width,
                                height: Get.height,
                              ),
                            ),
                          ),
                          title: Text(
                            '${_postDetail?.userName ?? ''}',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                          //TODO: Change the subtitle to the user's position
                          subtitle: Text(_postDetail?.user?.department ?? '',
                              style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                              )),
                        ),
                      ),
                      if (_postDetail?.user != null && SharedPreferenceHelper().getUserData()?.id != _postDetail?.user?.id )
                        FollowButton(
                          user: _postDetail!.user!,
                          onFollowStatusChange: (){
                            setState(() {
                              _fetchUserDetail();
                            });
                          },
                        ),
                    ],
                  ),

                  // Position and Description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _postDetail?.title ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: buttonColor,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        _postDetail?.description ?? '',
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        // width: MediaQuery.of(context).size.width / 2,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: buttonColor.withOpacity(.1)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/homepage/tag.png',
                              height: 13,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              _postDetail?.user?.fieldName ?? '',
                              style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: blackColor),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  const Divider(
                    thickness: .1,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10),

                  // Event Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildEventInfo(_postDetail?.location ?? '',
                          'assets/detailpost/location.png'),
                      _buildEventInfoDate(
                        _postDetail?.createdAt.toString() ?? '',
                        // '${DateFormat.yMMMMEEEEd().format(_postDetail?.createdAt ?? DateTime.now())}\n${DateFormat("h:mm a").format(_postDetail?.createdAt ?? DateTime.now())}',
                        'assets/detailpost/cal.png',
                      ),
                      _buildEventInfo(_postDetail?.user?.fieldName ?? '',
                          'assets/detailpost/ayur.png'),
                      _buildEventInfo(_postDetail?.postType?.name ?? '',
                          'assets/detailpost/job.png'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    thickness: .1,
                    color: Colors.grey,
                  ),
                  // const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          WhatsAppService().launchWhatsAppCall(
              phoneNumber: _postDetail?.user?.mobileNo ?? '', context: context);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          height: 50,
          decoration: BoxDecoration(
              color: buttonColor, borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Text(
              'Contact Now',
              style: GoogleFonts.poppins(
                color: whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to build the share icon
  Widget _buildActionIcon(String assetPath, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          assetPath,
          height: 24,
          width: 24,
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

// Build action buttons
Widget _buildActionIcon(String icon, String label) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: Colors.grey.withOpacity(.3),
            )),
        child: Image.asset(
          icon,
          height: 15,
        ),
      ),
      const SizedBox(height: 4),
      Text(label,
          style: GoogleFonts.poppins(
              fontSize: 12,
              color: const Color(0xff0D654E),
              fontWeight: FontWeight.w400)),
    ],
  );
}

// Build event info details
Widget _buildEventInfo(String text, String icon) {
  return Column(
    children: [
      Image.asset(
        icon,
        width: 24,
        height: 24,
      ),
      const SizedBox(height: 4),
      Text(text,
          style: GoogleFonts.poppins(
              fontSize: 10, color: const Color(0xff0A4D3C))),
    ],
  );
}

Widget _buildEventInfoDate(String createdAt, String iconAsset) {
  try {
    // Ensure the string ends with a valid ISO format
    // String sanitizedDate = '${createdAt.split('.').first}Z';

    // Parse the sanitized date
    DateTime dateTime = DateTime.tryParse(createdAt) ?? DateTime.now();

    // Format the date and time
    String formattedDate = DateFormat('MMMM d, y').format(dateTime);
    String startTime = DateFormat('h:mm a').format(dateTime);

    // Define the end time (example: 6 hours later)
    DateTime endDateTime = dateTime.add(const Duration(hours: 6));
    String endTime = DateFormat('h:mm a').format(endDateTime);

    // Combine formatted strings for display
    String eventInfo = "$formattedDate\n$startTime - $endTime";

    // Return widget with icon and event info
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          iconAsset,
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 8),
        Text(
          eventInfo,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.black,
          ),
        ),
      ],
    );
  } catch (e) {
    // Handle invalid date
    return Column(
      children: [
        Image.asset(
          iconAsset,
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 8),
        const Text(
          "Invalid Date",
          style: TextStyle(fontSize: 14, color: Colors.red),
        ),
      ],
    );
  }
}
