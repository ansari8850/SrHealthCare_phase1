import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sr_health_care/CustomWidget/app_cache_network_image.dart';
import 'package:sr_health_care/CustomWidget/expandable_text.dart';
import 'package:sr_health_care/CustomWidget/time_ago.dart';
import 'package:sr_health_care/Pages/Form_pages/create_post_service.dart';
import 'package:sr_health_care/Pages/followers/modeandservice/service_to_fetahc_detail_user.dart';
import 'package:sr_health_care/Pages/followers/modeandservice/singleuserprofiledetail.dart';
import 'package:sr_health_care/Pages/myfeed/myfeedDetail.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/text.dart';

// ignore: must_be_immutable
class MyFeedPage extends StatefulWidget {
  String userID;
  MyFeedPage({super.key, required this.userID});

  @override
  _MyFeedPageState createState() => _MyFeedPageState();
}

class _MyFeedPageState extends State<MyFeedPage> {
  String selectedTab = 'Approved';
  bool isApprovedSelected = true;
  bool isPendingSelected = false;
  bool isRejectedSelected = false;
  List<FeedPostModel> approved = [];
  List<FeedPostModel> pending = [];
  List<FeedPostModel> rejected = [];

  Future<void> fetchMyFeed() async {
    final userDetail = await ServiceToFetahcDetailUser()
        .fetchPostUserDetail(postUsedId: widget.userID);
    if (userDetail != null) {
      for (var i = 0; i < (userDetail.result?.length ?? 0); i++) {
        if (userDetail.result![i].status?.toLowerCase() == 'approved') {
          approved.add(userDetail.result![i]);
        } else if (userDetail.result![i].status?.toLowerCase() == 'pending') {
          pending.add(userDetail.result![i]);
        } else {
          rejected.add(userDetail.result![i]);
        }
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMyFeed();
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
                // Clear the lists to avoid duplicate data
                approved.clear();
                pending.clear();
                rejected.clear();

                // Delete the post
                await CreatePostService().deletePost(postId);

                // Refetch data
                await fetchMyFeed();

                // Ensure only the current tab remains active (no changes to the state)
                setState(() {});

                // Close the dialog
                Navigator.pop(context, true);
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        // leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: Text(
          'My Feed',
          style: GoogleFonts.poppins(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black),
        ),
        centerTitle: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tabs Section
          Container(
            // margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              // color: Colors.grey.withOpacity(.1),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => setState(() {
                    isApprovedSelected = true;
                    isPendingSelected = false;
                    isRejectedSelected = false;
                  }),
                  child: _buildTab('Approved', isSelected: isApprovedSelected),
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    isApprovedSelected = false;
                    isPendingSelected = true;
                    isRejectedSelected = false;
                  }),
                  child: _buildTab('Pending', isSelected: isPendingSelected),
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    isApprovedSelected = false;
                    isPendingSelected = false;
                    isRejectedSelected = true;
                  }),
                  child: _buildTab('Rejected', isSelected: isRejectedSelected),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Feed List
          isApprovedSelected
              ? _buildApprovedList()
              : isPendingSelected
                  ? _buildPendingList()
                  : _buildRejectedList(),
        ],
      ),
    );
  }

  // Rejected Feed List
  Widget _buildRejectedList() {
    return Expanded(
      child: ListView.builder(
        itemCount: rejected.length,
        itemBuilder: (context, index) {
          final post = rejected[index];
          return GestureDetector(
            onTap: () async {
              final shouldRefresh = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MyFeedDetail(id: rejected[index].id ?? 0),
                ),
              );

              if (shouldRefresh == true) {
                // Refresh the feed
                approved.clear();
                pending.clear();
                rejected.clear();
                fetchMyFeed();
              }
            },
            child: _buildFeedCard(
                title: post.title ?? '',
                description: post.description ?? '',
                tag1: post.postType?.fieldName ?? '',
                tag2: post.postType?.name ?? '',
                dateAgo: post.createdAt.toString(),
                comments: "8 Comments",
                imagePath: post.thumbnail ?? '',
                showShareButton: false,
                postId: post.id ?? 0,
                onTap: () {
                  Share.share('This is the rejected post ${post.thumbnail}');
                },
                status: post.status ?? ''),
          );
        },
        padding: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }

  // Approved Feed List
  Widget _buildApprovedList() {
    return Expanded(
      child: ListView.builder(
        itemCount: approved.length,
        itemBuilder: (context, index) {
          final post = approved[index];
          return GestureDetector(
            onTap: () async {
              final shouldRefresh = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MyFeedDetail(id: approved[index].id ?? 0),
                ),
              );
              // log(approved);

              if (shouldRefresh == true) {
                // Refresh the feed
                approved.clear();
                pending.clear();
                rejected.clear();
                fetchMyFeed();
              }
            },
            child: _buildFeedCard(
                title: post.title ?? '',
                description: post.description ?? '',
                tag1: post.postType?.fieldName ?? '',
                tag2: post.postType?.name ?? '',
                dateAgo: post.createdAt.toString(),
                comments: "8 Comments",
                imagePath: post.thumbnail ?? '',
                showShareButton: false,
                postId: post.id ?? 0,
                onTap: () {
                  Share.share('This is the rejected post ${post.thumbnail}');
                },
                status: post.status ?? ''),
          );
        },
        padding: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }

  // Pending Feed List
  Widget _buildPendingList() {
    return Expanded(
      child: ListView.builder(
        itemCount: pending.length,
        itemBuilder: (context, index) {
          final post = pending[index];
          return GestureDetector(
            onTap: () async {
              final shouldRefresh = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MyFeedDetail(id: pending[index].id ?? 0),
                ),
              );

              if (shouldRefresh == true) {
                // Refresh the feed
                approved.clear();
                pending.clear();
                rejected.clear();
                fetchMyFeed();
              }
            },
            child: _buildFeedCard(
                title: post.title ?? '',
                description: post.description ?? '',
                tag1: post.user?.fieldName ?? '',
                tag2: post.postType?.name ?? '',
                dateAgo: post.createdAt.toString(),
                comments: "8 Comments",
                imagePath: post.thumbnail ?? '',
                showShareButton: false,
                postId: post.id ?? 0,
                onTap: () {
                  Share.share('This is the rejected post ${post.thumbnail}');
                },
                status: post.status ?? ''),
          );
        },
        padding: const EdgeInsets.symmetric(horizontal: 10),
      ),
    );
  }

  // Tabs
  Widget _buildTab(String text, {required bool isSelected}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 47,
      width: Get.width / 3.3,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        border:
            Border.all(color: isSelected ? buttonColor : Colors.transparent),
        color: isSelected
            ? Colors.grey.withOpacity(.06)
            : Colors.grey.withOpacity(.2),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: isSelected ? Color(0xff1B125B) : Colors.grey,
        ),
      ),
    );
  }

  // Feed Card
  Widget _buildFeedCard(
      {required String title,
      required String description,
      required String tag1,
      required String tag2,
      required String dateAgo,
      required String comments,
      required String imagePath,
      required String status,
      required bool showShareButton,
      void Function()? onTap,
      required int postId}) {
    return Card(
      color: whiteColor,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image and Text Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppCacheNetworkImage(
                  imageUrl: imagePath,
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                  borderRadius: 8,
                ),
                // AppCacheNetworkImage(imageUrl: imageUrl)
                const SizedBox(width: 10),
                Expanded(flex: 7, child: ExpandableText(text: description)),
                Spacer(
                  flex: 1,
                ),
                Column(
                  children: [
                    if (status == "Approved")
                      GestureDetector(
                        onTap: onTap,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Color(0xffE8F8F4),
                          child: Image.asset(
                            'assets/homepage/share.png',
                            height: 16,
                            width: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 8,
                    ),
                    if (status == "Approved" || status == 'Rejected')
                      GestureDetector(
                        onTap: () {
                          _showMyDialog(postId);
                          setState(() {});
                        },
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Color(0xffE8F8F4),
                          child: Image.asset(
                            'assets/homepage/delete.png',
                            height: 16,
                            width: 16,
                            color: Colors.red,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Divider(thickness: .5, color: Colors.grey.withOpacity(.2)),

            // Tags and Comments
            Row(
              children: [
                if (tag1.isNotEmpty) ...[
                  _buildTag(tag1),
                  const SizedBox(width: 5),
                ],
                if (tag2.isNotEmpty) _buildTag(tag2),
                Spacer(),
                Image.asset(
                  'assets/myfeed/clock.png',
                  height: 12,
                ),
                const SizedBox(width: 5),
                TimeAgoCustomWidget(
                  createdAt: dateAgo,
                  size: 10,
                )
              ],
            ),

           
          ],
        ),
      ),
    );
  }

  // Tags
  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: buttonColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 10,
          color: blackColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }


}
