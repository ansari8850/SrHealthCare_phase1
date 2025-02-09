import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sr_health_care/Controller/save_post_controller.dart';
import 'package:sr_health_care/CustomWidget/app_cache_network_image.dart';
import 'package:sr_health_care/CustomWidget/dotted_divider.dart';
import 'package:sr_health_care/CustomWidget/follow_button.dart';
import 'package:sr_health_care/CustomWidget/save_unsaved_button.dart';
import 'package:sr_health_care/CustomWidget/time_ago.dart';
import 'package:sr_health_care/Pages/detailPost/report_post.dart';
import 'package:sr_health_care/Pages/followers/follower_profile.dart';
import 'package:sr_health_care/Pages/homePage/servicesModel/home_api_service.dart';
import 'package:sr_health_care/Pages/homePage/servicesModel/post_model_class.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/sharedference.dart';
import 'package:sr_health_care/services/share_plus_service.dart';
import 'package:sr_health_care/services/whatsapp_service.dart';

class PostDetailPage extends StatefulWidget {
  final PostModel post;

  const PostDetailPage({super.key, required this.post});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  bool isLoading = true;
  PostModel? _postDetail;

  @override
  void initState() {
    super.initState();
    _fetchPostDetail();
  }

  Future<void> _fetchPostDetail() async {
    setState(() {
      isLoading = true; // Start loading
    });

    try {
      _postDetail =
          await PostService().fetchPostDetail(postid: widget.post.id ?? -1);
    } catch (e) {
      debugPrint("Error fetching post details: $e");
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Loading indicator
          : CustomScrollView(
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
                        height: 350,
                        width: MediaQuery.of(context).size.width,
                        child: AppCacheNetworkImage(
                          imageUrl: _postDetail?.thumbnail ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
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
                              topRight: Radius.circular(100),
                            ),
                          ),
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
                      ),
                    ),
                    onPressed: () => Get.back(),
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
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Top Padding
                        const SizedBox(height: 16),

                        // Action Buttons
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                ShareService().shareText(
                                    'Sr HealthCare Community ${_postDetail?.title ?? ''}');
                              },
                              child: _buildActionIcon(
                                  'assets/detailpost/share.png', "Share"),
                            ),
                            const SizedBox(width: 20),
                            Obx(() {
                              final savepostController =
                                  Get.find<SavePostController>();
                              final isSaved = savepostController
                                  .isPostSaved(widget.post.id ?? -1);
                              return SaveButton(
                                postId: widget.post.id ?? -1,
                                layoutType: LayoutType.vertical,
                              );
                            }),
                            const SizedBox(width: 20),
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
                                    return ReportPost(
                                      postId: _postDetail?.id ?? -1,
                                      postTitle:
                                          _postDetail?.postType?.fieldName ??
                                              '',
                                      userId: _postDetail?.user?.id ?? 0,
                                      userName:
                                          "${_postDetail?.user?.name ?? ''} ${_postDetail?.user?.lastName}",
                                    );
                                  },
                                );
                              },
                              child: _buildActionIcon(
                                  'assets/detailpost/report.png', "Report"),
                            ),
                            const Spacer(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/homepage/clock.png',
                                  height: 12,
                                ),
                                const SizedBox(width: 5),
                                TimeAgoCustomWidget(
                                  createdAt:
                                      _postDetail?.createdAt.toString() ?? '',
                                  size: 10,
                                ),
                              ],
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: MySeparator(
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
                                    isSaved: widget.post.isSaved ?? 0,
                                    isAboveFollowing:
                                        _postDetail?.user?.isFollowing,
                                    postUsedId:
                                        _postDetail?.userId.toString() ?? '',
                                  ));
                                },
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  radius: 21,
                                  backgroundColor: buttonColor,
                                  child: CircleAvatar(
                                    radius: 20,
                                    child: AppCacheNetworkImage(
                                      imageUrl:
                                          _postDetail?.user?.photo?.url ?? '',
                                      fit: BoxFit.cover,
                                      borderRadius: 50,
                                      width: Get.width,
                                      height: Get.height,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  _postDetail?.userName ?? '',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                                subtitle: Text(
                                  _postDetail?.user?.department ?? '',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                            if (_postDetail?.user != null &&
                                SharedPreferenceHelper().getUserData()?.id !=
                                    _postDetail?.user?.id)
                              FollowButton(
                                user: _postDetail!.user!,
                                onFollowStatusChange: () {
                                  setState(() {
                                    _fetchPostDetail();
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
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: buttonColor,
                              ),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              _postDetail?.description ?? '',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: buttonColor.withOpacity(.1),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    'assets/homepage/tag.png',
                                    height: 12,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    _postDetail?.user?.fieldName ?? '',
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: blackColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

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
            color: buttonColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              'Contact Now',
              style: GoogleFonts.poppins(
                color: whiteColor,
                fontSize: 14,
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
          height: 18,
          width: 18,
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

// Build event info details
Widget _buildEventInfo(String text, String icon) {
  return Column(
    children: [
      Image.asset(
        icon,
        width: 18,
        height: 18,
      ),
      const SizedBox(height: 4),
      Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 8,
          color: const Color(0xff0A4D3C),
        ),
      ),
    ],
  );
}

Widget _buildEventInfoDate(String createdAt, String iconAsset) {
  try {
    DateTime dateTime = DateTime.parse(createdAt);
    String formattedDate = DateFormat('MMMM d, y').format(dateTime);
    String postedTime = DateFormat('h:mm a').format(dateTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          iconAsset,
          width: 18,
          height: 18,
          fit: BoxFit.contain,
        ),
        Text(
          formattedDate,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w400,
            color: Color(0xff0A4D3C),
          ),
        ),
        Text(
          postedTime,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w400,
            color: Color(0xff0A4D3C),
          ),
        ),
      ],
    );
  } catch (e) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          iconAsset,
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 6),
        const Text(
          "Posted recently",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Color(0xff0A4D3C),
          ),
        ),
      ],
    );
  }
}
