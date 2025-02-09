import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sr_health_care/CustomWidget/app_cache_network_image.dart';
import 'package:sr_health_care/CustomWidget/dotted_divider.dart';
import 'package:sr_health_care/CustomWidget/time_ago.dart';
import 'package:sr_health_care/Pages/Form_pages/create_post_service.dart';
import 'package:sr_health_care/Pages/homePage/servicesModel/home_api_service.dart';
import 'package:sr_health_care/Pages/homePage/servicesModel/post_model_class.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/text.dart';
import 'package:sr_health_care/services/share_plus_service.dart';

class MyFeedDetail extends StatefulWidget {
  final int id;

  const MyFeedDetail({super.key, required this.id});

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
          actionsPadding: EdgeInsets.only(bottom: 0, right: 8, top: 0),
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
                onPressed: () => _showMyDialog(postId)),
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
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: _postDetail?.status == 'Approved'
                          ? Colors.blue.withValues(alpha: .3)
                          : _postDetail?.status == 'Pending'
                              ? Color(0xffF7F7E8)
                              : _postDetail?.status == 'Rejected'
                                  ? Colors.red.withValues(alpha: .3)
                                  : _postDetail?.status == 'Reported'
                                      ? Colors.blueGrey.withValues(alpha: .3)
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
                                      : _postDetail?.status == 'Reported'
                                          ? Colors.blueGrey
                                          : Colors.white,
                          radius: 5,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          _postDetail?.status == 'Approved'
                              ? 'Approved'
                              : _postDetail?.status == 'Pending'
                                  ? 'Pending'
                                  : _postDetail?.status == 'Rejected'
                                      ? 'Rejected'
                                      : _postDetail?.status == 'Reported'
                                          ? 'Reported'
                                          : '',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: _postDetail?.status == 'Approved'
                                ? Color(0xff4976F4)
                                : _postDetail?.status == 'Pending'
                                    ? Color(0xffB1AB1D)
                                    : _postDetail?.status == 'Rejected'
                                        ? Color(0xffAF4B4B)
                                        : _postDetail?.status == 'Reported'
                                            ? Colors.blueGrey
                                            : Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),

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
                            onTap: () {
                              // await CreatePostService()
                              //     .deletePost(_postDetail?.id ?? 0);
                              // Navigator.pop(context, true);
                              _showDeleteConfirmationDialog(context);
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
                                fontSize: 12,
                                fontWeight: FontWeight.w400),
                            children: [
                          TextSpan(
                              text: _postDetail?.rejectedReason ??
                                  ' There is No Valid Reason For the Rejection till Now ',
                              style: GoogleFonts.poppins(
                                  color: Color(0xffDA4019),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400))
                        ])),

                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: MySeparator(
                      // height: 10,
                      color: Colors.grey.withValues(alpha: .3),
                    ),
                  ),

                  // Position and Description
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            _postDetail?.title != null &&
                                    _postDetail!.title!.length > 20
                                ? '${_postDetail!.title!.substring(0, 20)}...'
                                : _postDetail?.title ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: buttonColor,
                            ),
                          ),
                          Spacer(),
                          Image.asset(
                            'assets/homepage/clock.png',
                            height: 12,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          TimeAgoCustomWidget(
                              size: 10,
                              createdAt:
                                  _postDetail?.createdAt.toString() ?? '')
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _postDetail?.description ?? '',
                        style: GoogleFonts.poppins(
                            fontSize: 10, color: Colors.grey),
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
                        onTap: () {
                          _showDeleteConfirmationDialog(context);
                          // await CreatePostService()
                          //     .deletePost(_postDetail?.id ?? 0);
                          // Navigator.pop(context, true);
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

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this post?',
              style: GoogleFonts.poppins(color: blackColor)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(color: blackColor),
              ),
            ),
            TextButton(
              onPressed: () async {
                // Call the delete function
                await CreatePostService().deletePost(_postDetail?.id ?? 0);
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pop(context, true); // Pop to the main page
              },
              child:
                  Text('Delete', style: GoogleFonts.poppins(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  // Helper function to build the share icon
  Widget _buildActionIcon(String assetPath, String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(50)),
          child: Image.asset(
            assetPath,
            height: 12,
            width: 12,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: color,
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
      Text(text,
          style:
              GoogleFonts.poppins(fontSize: 8, color: const Color(0xff0A4D3C))),
    ],
  );
}

Widget _buildEventInfoDate(String createdAt, String iconAsset) {
  try {
    // Parse the date in ISO 8601 format
    DateTime dateTime = DateTime.parse(createdAt);

    // Format the date and time for display
    String formattedDate = DateFormat('MMMM d, y').format(dateTime);
    String postedTime = DateFormat('h:mm a').format(dateTime);

    // Return a user-friendly widget with icon, date, and time
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          iconAsset,
          width: 18, // Slightly larger for better UX
          height: 18,
          fit: BoxFit.contain,
        ),
        // Added spacing for better visual separation
        Text(
          formattedDate,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 8, // Updated font size for better readability
            fontWeight: FontWeight.w400,
            color: Color(0xff0A4D3C),
          ),
        ),
        // Spacing between date and time
        Text(
          postedTime,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 8, // Slightly smaller font size for time
            fontWeight: FontWeight.w400, // Slightly lighter for distinction
            color: Color(0xff0A4D3C),
          ),
        ),
      ],
    );
  } catch (e) {
    // Fallback for unexpected errors
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
