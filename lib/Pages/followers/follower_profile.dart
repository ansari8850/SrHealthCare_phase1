import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/Controller/follow_unfollow_controller.dart';
import 'package:sr_health_care/CustomWidget/app_cache_network_image.dart';
import 'package:sr_health_care/CustomWidget/expandable_text.dart';
import 'package:sr_health_care/CustomWidget/save_unsaved_button.dart';
import 'package:sr_health_care/CustomWidget/time_ago.dart';
import 'package:sr_health_care/Pages/detailPost/report_post.dart';
import 'package:sr_health_care/Pages/followers/about_profile.dart';
import 'package:sr_health_care/Pages/followers/modeandservice/service_to_fetahc_detail_user.dart';
import 'package:sr_health_care/Pages/followers/modeandservice/singleuserprofiledetail.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/sharedference.dart';
import 'package:sr_health_care/const/text.dart';
import 'package:sr_health_care/services/share_plus_service.dart';
import 'package:sr_health_care/services/whatsapp_service.dart';

class FollowerProfile extends StatefulWidget {
  String postUsedId;
  bool? isAboveFollowing;
  FollowerProfile({super.key, required this.postUsedId, this.isAboveFollowing});

  @override
  State<FollowerProfile> createState() => _FollowerProfileState();
}

class _FollowerProfileState extends State<FollowerProfile> {
  bool _isExpanded = false;
  SingleUserPostDetail? userDetailPost;
  bool isFollowing = false;
  int _currentUserID = SharedPreferenceHelper().getUserData()?.id ?? 0;

  @override
  void initState() {
    super.initState();
    fetchUserDetail();
    isFollowing = widget.isAboveFollowing ??
        userDetailPost?.result?.firstOrNull?.user?.isFollowing ??
        isFollowing;
  }

  Future<void> fetchUserDetail() async {
    final userDetail = await ServiceToFetahcDetailUser().fetchPostUserDetail(
      postUsedId: widget.postUsedId,
    );

    if (userDetail != null) {
      setState(() {
        // Assuming `status` is the field indicating post approval, filter out unapproved posts.
        userDetailPost = userDetail;

        // Check if the post is approved (assuming status == 'approved' means the post is approved)
        var approvedPosts = userDetail.result
            ?.where((post) => post.status == 'Approved')
            .toList();

        if (approvedPosts?.isNotEmpty ?? false) {
          // Set the first approved post if available
          userDetailPost?.result = approvedPosts;

          // Handle the isFollowing logic as before
          isFollowing = widget.isAboveFollowing ??
              userDetailPost?.result?.firstOrNull?.user?.isFollowing ??
              false;
        } else {
          // If no approved posts are found, you can handle this case (e.g., show a message)
          print("No approved posts available.");
        }
      });
    }
  }

  // Function to show the modal bottom sheet for unfollow confirmation
  void _showUnfollowConfirmation(
      BuildContext context, String username, void Function() onUnfollow) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding:
              const EdgeInsets.only(right: 10, left: 10, bottom: 10, top: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Unfollow $username',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Are you sure you want to unfollow Dr. Manish Rajput? You’ll no longer see updates or posts from this creator in your feed.',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Material(
                        color: Colors.transparent,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: blackColor)),
                          child: Ink(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text(
                              textAlign: TextAlign.center,
                              'Cancel',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: buttonColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: onUnfollow,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: blackColor)),
                        child: Text(
                          textAlign: TextAlign.center,
                          'Unfollow',
                          style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: whiteColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: const BoxDecoration(),
                  child: Image.asset(
                    'assets/myfeed/profile.png',
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.green,
                      ),
                    ),
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
                            topRight: Radius.circular(100))),
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: -40,
                  child: CircleAvatar(
                    // backgroundColor: Colors.red,
                    radius: 50,
                    // backgroundImage: AssetImage('assets/homepage/dr1.jpg'),
                    child: AppCacheNetworkImage(
                        height: 100,
                        width: Get.width,
                        borderRadius: 50,
                        imageUrl: userDetailPost
                                ?.result?.firstOrNull?.user?.photo?.url ??
                            ''),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text:
                        '${userDetailPost?.result?.firstOrNull?.user?.name ?? ''} ${userDetailPost?.result?.firstOrNull?.user?.lastName ?? ''}',
                    size: 16,
                    color: blackColor,
                    weight: FontWeight.w500,
                  ),
                  CustomText(
                    text:
                        userDetailPost?.result?.firstOrNull?.user?.department ??
                            '',
                    size: 12,
                    color: Colors.grey,
                    weight: FontWeight.w400,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (SharedPreferenceHelper().getUserData()?.id !=
                      userDetailPost?.result?.firstOrNull?.user?.id)
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final controller = Get.find<FollowController>();
                              final userId = userDetailPost
                                      ?.result?.firstOrNull?.user?.id
                                      .toString() ??
                                  '';

                              await controller.toggleFollow(
                                userId,
                                isFollowing: controller.isFollowing(userId),
                              );

                              isFollowing = !isFollowing;

                              setState(() {});
                            },
                            child: Obx(() {
                              final controller = Get.find<FollowController>();
                              print(controller.UserId);

                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 7),
                                decoration: BoxDecoration(
                                  color:
                                      isFollowing ? Colors.green : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isFollowing
                                        ? Colors.green
                                        : Colors.black,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (isFollowing) ...[
                                      Icon(Icons.check,
                                          color: Colors.white, size: 14),
                                      const SizedBox(width: 5),
                                      Text(
                                        'Following',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ] else ...[
                                      Icon(Icons.add,
                                          color: Colors.black, size: 14),
                                      const SizedBox(width: 5),
                                      Text(
                                        'Follow',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                        SizedBox(width: 10),
                        Visibility(
                          visible: false,
                          child: InkWell(
                            onTap: () {
                              _showBottomSheetProfile(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey)),
                              child: const Icon(Icons.more_horiz),
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _columnView('assets/followers/follower.png',
                          '${userDetailPost?.totalfollowingCount} Followers '),
                      _columnView('assets/followers/post.png',
                          '${userDetailPost?.totalPostCount} Posts'),
                      _columnView('assets/followers/following.png',
                          '${userDetailPost?.totalfollowersCount} Following'),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomText(
                    text: 'About',
                    size: 16,
                    color: blackColor,
                    weight: FontWeight.w400,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ExpandableText(
                      text: userDetailPost?.result?.firstOrNull?.user?.bio ??
                          'No Bio Available' , ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomText(
                    text: 'All Posts',
                    size: 16,
                    color: blackColor,
                    weight: FontWeight.w400,
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) =>
                        _postCard(userDetailPost?.result![index]),
                    separatorBuilder: (_, __) => SizedBox(
                      height: 20,
                    ),
                    itemCount: userDetailPost?.result?.length ?? 0,
                  ),
                  // SizedBox(height: 20,)
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          String mobileNumber =
              '+91${userDetailPost?.result?.firstOrNull?.user?.mobileNo ?? ''}';
          WhatsAppService()
              .launchWhatsAppCall(phoneNumber: mobileNumber, context: context);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
              color: buttonColor, borderRadius: BorderRadius.circular(8)),
          child: Text(
            textAlign: TextAlign.center,
            'Contact Now',
            style: GoogleFonts.poppins(
                fontSize: 14, color: whiteColor, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  Widget _actionButton(
      String text, IconData? icon, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
        border: bgColor == whiteColor
            ? Border.all(color: buttonColor)
            : Border.all(color: Colors.transparent),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, color: textColor),
            const SizedBox(width: 5),
          ],
          CustomText(
            text: text,
            size: 14,
            color: textColor,
            weight: FontWeight.w500,
          ),
        ],
      ),
    );
  }

  Widget _postCard(FeedPostModel? feedPost) {
    // final feedPost =userDetailPost?.result?.firstOrNull;
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8),
        // border: Border.all(color: Colors.grey[300]!
        // ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                child: AppCacheNetworkImage(
                  borderRadius: 50,
                  width: Get.width,
                  imageUrl: feedPost?.user?.photo?.url ?? '',
                  height: 100,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text:
                          '${feedPost?.user?.name ?? ''} ${feedPost?.user?.lastName ?? ''}',
                      size: 12,
                      color: blackColor,
                      weight: FontWeight.w500,
                    ),
                    CustomText(
                      text: feedPost?.user?.department ?? '',
                      size: 10,
                      color: Colors.grey,
                      weight: FontWeight.w400,
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Image.asset(
                          'assets/homepage/clock.png',
                          height: 12,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        TimeAgoCustomWidget(
                          createdAt:
                              feedPost?.postType?.createdAt?.toString() ?? '',
                              size: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Spacer(),
              InkWell(
                  onTap: () {
                    _showBottomSheet(
                      context,
                      feedPost?.postType?.fieldName ?? '',
                      feedPost?.id ?? 0,
                      "${feedPost?.user?.name ?? ''} ${feedPost?.user?.lastName ?? ''}",
                      feedPost?.user?.id ?? 0,
                    );
                  },
                  child: const Icon(Icons.more_vert, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: Get.height / 3.3,
            width: Get.width,
            child: AppCacheNetworkImage(
                borderRadius: 8, imageUrl: feedPost?.thumbnail ?? ''),
          ),
          const SizedBox(height: 10),
          ExpandableText(
            text: feedPost?.description ?? '',
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              if (feedPost?.postType?.fieldName != null)
                _tag(feedPost?.postType?.fieldName ?? ''),
              const SizedBox(width: 10),
              if (feedPost?.postType?.type != null)
                _tag(feedPost?.postType?.type ?? ''),
            ],
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(
    BuildContext context,
    String title,
    int iD,
    String userName,
    int userID,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              _bottomSheetOption(
                context,
                icon: Icons.bookmark_outline,
                label: 'Save Post',
                onTap: () {
                  Obx(() {
                    return SaveButton(
                      postId: iD,
                      isSaved: savepostController.savedPostID.contains(iD),
                    );

                  });
                  // Add your functionality here
                                                        Navigator.pop(context);

                },
              ),
              _bottomSheetOption(
                context,
                icon: Icons.share_outlined,
                label: 'Share Post',
                onTap: () {
                  ShareService().shareText(title);
                },
              ),
              _bottomSheetOption(
                context,
                icon: Icons.report_gmailerrorred_outlined,
                label: 'Report Post',
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (BuildContext context) {
                      return ReportPost(
                        postId: iD,
                        postTitle: title,
                        userId: userID,
                        userName: userName,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showBottomSheetProfile(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 20),
              _bottomSheetOption(
                context,
                icon: Icons.share,
                label: 'Share Profile',
                onTap: () {
                  Navigator.pop(context); // Add your functionality here
                },
              ),
              _bottomSheetOption(
                context,
                icon: Icons.report_gmailerrorred_outlined,
                label: 'Report Profile',
                onTap: () {
                  Navigator.pop(context); // Add your functionality here
                },
              ),
              _bottomSheetOption(
                context,
                icon: Icons.info_rounded,
                label: 'About Profile',
                onTap: () {
                  Get.to(
                      const AboutProfilePage()); // Add your functionality here
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _bottomSheetOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: const Color(0xffBAF0F4).withOpacity(.4),
        child: Icon(
          icon,
          color: Colors.grey,
        ),
      ),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}

Widget _tag(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    decoration: BoxDecoration(
      color: buttonColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/homepage/tag.png',
          height: 13,
        ),
        const SizedBox(
          width: 8,
        ),
        CustomText(
          text: label,
          size: 10,
          color: blackColor,
          weight: FontWeight.w400,
        ),
      ],
    ),
  );
}

Column _columnView(String image, String title) {
  return Column(
    children: [
      Image.asset(
        image,
        height: 24,
      ),
      const SizedBox(
        height: 5,
      ),
      CustomText(
        text: title,
        size: 10,
        color: buttonColor,
        weight: FontWeight.w400,
      ),
    ],
  );
}
