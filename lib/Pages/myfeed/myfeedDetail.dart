import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sr_health_care/CustomWidget/app_cache_network_image.dart';
import 'package:sr_health_care/CustomWidget/dotted_divider.dart';
import 'package:sr_health_care/CustomWidget/follow_button.dart';
import 'package:sr_health_care/CustomWidget/time_ago.dart';
import 'package:sr_health_care/Pages/Form_pages/create_post_service.dart';
import 'package:sr_health_care/Pages/detailPost/report_post.dart';
import 'package:sr_health_care/Pages/followers/follower_profile.dart';
import 'package:sr_health_care/Pages/homePage/servicesModel/home_api_service.dart';
import 'package:sr_health_care/Pages/homePage/servicesModel/post_model_class.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/text.dart';
import 'package:sr_health_care/services/post_save_and_unsave_service.dart';
import 'package:sr_health_care/services/share_plus_service.dart';
import 'package:sr_health_care/services/whatsapp_service.dart';

class MyFeedDetail extends StatefulWidget {
  final int id;

  MyFeedDetail({super.key, required this.id});

  @override
  State<MyFeedDetail> createState() => _MyFeedDetailState();
}

class _MyFeedDetailState extends State<MyFeedDetail> {
  bool isFollowing = false;
  bool isLoading = true;
  PostModel? _postDetail;

  void _fetchUserDetail() async {
    setState(() {
      isLoading = true; // Start loading
    });

    try {
      _postDetail =
          await PostService().fetchPostDetail(postid: widget.id ?? -1);
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

  Future<void> _showMyDialog(int postId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // contentPadding: EdgeInsets.symmetric(horizontal: 10 , vertical: 8),
          //  buttonPadding: EdgeInsets.only(bottom: 0),
          // titlePadding: EdgeInsets.only(top: 8 , bottom: 8 , left: 10 , right: 10),//
          actionsPadding: EdgeInsets.only(bottom: 0, right: 8, top: 0),
          // contentPadding: EdgeInsets.only(bottom: 0 , left: 20 , right: 20 , top: 8),
          backgroundColor: Colors.white,
          title: CustomText(
              text: 'Are You Sure You Want To Delete This Post?',
              size: 16,
              color: blackColor,
              weight: FontWeight.w500),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                CustomText(
                    text: 'Your Post Will Be Permanently Deleted ',
                    size: 12,
                    color: Color(0xff1B1A1A),
                    weight: FontWeight.w400)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: CustomText(
                  text: 'Delete',
                  size: 14,
                  color: Colors.red,
                  weight: FontWeight.w500),
              onPressed: () async {
                await CreatePostService().deletePost(postId);

                // Ensure only the current tab remains active (no changes to the state)
                setState(() {});

                // Close the dialog
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: CustomText(
                  text: 'Cancel',
                  size: 14,
                  color: blackColor,
                  weight: FontWeight.w500),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: _postDetail?.status == 'Approved'
                          ? Colors.blue.withOpacity(.3)
                          : _postDetail?.status == 'Pending'
                              ? Color(0xffF7F7E8)
                              : _postDetail?.status == 'Rejected'
                                  ? Colors.red.withOpacity(.3)
                                  : Colors.white,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundColor: _postDetail?.status == 'Approved'
                              ? Color(0xff4976F4)
                              : _postDetail?.status == 'Pending'
                                  ? Color(0xffB1AB1D)
                                  : _postDetail?.status == 'Rejected'
                                      ? Color(0xffAF4B4B)
                                      : Colors.white,
                          radius: 10,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          _postDetail?.status == 'Approved'
                              ? 'Approved'
                              : _postDetail?.status == 'Pending'
                                  ? 'Pending'
                                  : _postDetail?.status == 'Rejected'
                                      ? 'Rejected'
                                      : '',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: _postDetail?.status == 'Approved'
                                ? Color(0xff4976F4)
                                : _postDetail?.status == 'Pending'
                                    ? Color(0xffB1AB1D)
                                    : _postDetail?.status == 'Rejected'
                                        ? Color(0xffAF4B4B)
                                        : Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Action Buttons
                  if (_postDetail?.status == 'Approved')
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              ShareService().shareText('This is Approved Post');
                            },
                            child: _buildActionIcon(
                                'assets/detailpost/share.png',
                                "Share",
                                Colors.green)),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                            onTap: () async {
                              await CreatePostService()
                                  .deletePost(_postDetail?.id ?? 0);
                              Navigator.pop(context, true);
                            },
                            child: _buildActionIcon(
                                'assets/homepage/delete.png',
                                "Delete",
                                Colors.red)),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  if (_postDetail?.status == 'Rejected')
                    RichText(
                        text: TextSpan(
                            text: 'Reason:',
                            style: GoogleFonts.poppins(
                                color: buttonColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            children: [
                          TextSpan(
                              text: _postDetail?.rejectedReason ??
                                  ' There is No Valid Reason For the Rejection till Now ',
                              style: GoogleFonts.poppins(
                                  color: Color(0xffDA4019),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400))
                        ])),

                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: MySeparator(
                      // height: 10,
                      color: Colors.grey.withOpacity(.3),
                    ),
                  ),

                  // Position and Description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _postDetail?.title ?? '',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: buttonColor,
                            ),
                          ),
                          Spacer(),
                          Image.asset(
                            'assets/homepage/clock.png',
                            height: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          TimeAgoCustomWidget(
                              createdAt:
                                  _postDetail?.createdAt.toString() ?? '')
                        ],
                      ),
                      const SizedBox(height: 7),
                      Text(
                        _postDetail?.description ?? '',
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(height: 15),
                      // Container(
                      //   // width: MediaQuery.of(context).size.width / 2,
                      //   padding: const EdgeInsets.symmetric(
                      //       vertical: 8, horizontal: 10),
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(10),
                      //       color: buttonColor.withOpacity(.1)),
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       Image.asset(
                      //         'assets/homepage/tag.png',
                      //         height: 13,
                      //       ),
                      //       const SizedBox(
                      //         width: 5,
                      //       ),
                      //       Text(
                      //         'Under Development',
                      //         style: GoogleFonts.poppins(
                      //             fontSize: 10,
                      //             fontWeight: FontWeight.w400,
                      //             color: blackColor),
                      //       )
                      //     ],
                      //   ),
                      // ),
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
                      _buildEventInfo(_postDetail?.postType?.type ?? '',
                          'assets/detailpost/job.png'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(
                    thickness: .1,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  if (_postDetail?.status == 'Rejected')
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          await CreatePostService()
                              .deletePost(_postDetail?.id ?? 0);
                          Navigator.pop(context, true);
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xffDA4019)),
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            'Delete Post',
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to build the share icon
  Widget _buildActionIcon(String assetPath, String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(50)),
          child: Image.asset(
            assetPath,
            height: 15,
            width: 15,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: color,
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
    DateTime dateTime = DateTime.parse(createdAt);

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
