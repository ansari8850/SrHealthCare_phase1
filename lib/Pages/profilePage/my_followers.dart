import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/CustomWidget/app_cache_network_image.dart';
import 'package:sr_health_care/CustomWidget/time_ago.dart';
import 'package:sr_health_care/Pages/followers/follower_profile.dart';
import 'package:sr_health_care/Pages/profilePage/modelandservice/following_model.dart';
import 'package:sr_health_care/Pages/profilePage/modelandservice/user_profile_service.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:http/http.dart' as http;

class FollowersPage extends StatefulWidget {
  const FollowersPage({super.key});

  @override
  _FollowersPageState createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  String? searchQuery = '';
  List<Follower?> followers = [];
  List<Following?> following = [];
  bool isLoadingFollowers = true;
  bool isLoadingFollowing = true;

  @override
  void initState() {
    super.initState();
    fetchFollowers();
    fetchFollowing();
  }

  Future<void> fetchFollowers() async {
    try {
      UserFollowing response = await UserProfileApiService().fetchFollowers();
      setState(() {
        followers = response.followers ?? [];
        isLoadingFollowers = false;
      });
    } catch (e) {
      log('Error fetching followers: $e');
      setState(() {
        isLoadingFollowers = false;
      });
    }
  }

  Future<void> fetchFollowing() async {
    try {
      UserFollowing response = await UserProfileApiService().fetchFollowing();
      setState(() {
        following = response.followings ?? [];
        isLoadingFollowing = false;
      });
    } catch (e) {
      log('Error fetching following: $e');
      setState(() {
        isLoadingFollowing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.5,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "My Followers",
            style: GoogleFonts.poppins(
              color: const Color(0xff3F3F3F),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.black,
            tabs: [
              Tab(text: "Followers (${followers.length})"),
              Tab(text: "Following (${following.length})"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            isLoadingFollowers
                ? const Center(child: CircularProgressIndicator())
                : buildListFollowers(followers),
            isLoadingFollowing
                ? const Center(child: CircularProgressIndicator())
                : buildListFollowing(following),
          ],
        ),
      ),
    );
  }

  Widget buildListFollowing(List<Following?> dataList) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            shadowColor: Colors.green,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintStyle: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w500),
                hintText: "Search by name..",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final user = dataList[index];

              if (searchQuery != null &&
                  searchQuery!.isNotEmpty &&
                  user?.displayName != null &&
                  !user!.displayName!.toLowerCase().contains(searchQuery!)) {
                return const SizedBox.shrink();
              }

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                child: ListTile(
                  onTap: () async{
                  //   Get.to(
                  // FollowerProfile(postUsedId: (user?.id ?? 0 ).toString(),isAboveFollowing:true,)

                  //   );
                  final shouldReferesh = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FollowerProfile(postUsedId: (user?.id ?? 0 ).toString(),isAboveFollowing:true,)
                ),
              );
              if(shouldReferesh ==true)
              {followers.clear();
              following.clear();
              fetchFollowers();
              fetchFollowing();}

              // l 
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 26,
                    backgroundColor: buttonColor,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 25,
                      child: AppCacheNetworkImage(
                        imageUrl: user?.photo?.url ?? '',
                        borderRadius: 50,
                        width: Get.width,
                        height: Get.height,
                      ),
                    ),
                  ),
                  title: Text(
                    user?.displayName ?? '',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.department ?? '',
                        style: GoogleFonts.poppins(
                          color: Colors.grey[700],
                          fontSize: 10,
                        ),
                      ),
                      TimeAgoCustomWidget(createdAt: user!.updatedAt.toString() , size: 10,)
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

 Widget buildListFollowers(List<Follower?> dataList) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
          child: Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            shadowColor: Colors.green,
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.trim().toLowerCase();
                });
              },
              decoration: InputDecoration(
                hintStyle: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w500),
                hintText: "Search by name..",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (context, index) {
              final user = dataList[index];

              if (searchQuery != null &&
                  searchQuery!.isNotEmpty &&
                  user?.displayName != null &&
                  !user!.displayName!.toLowerCase().contains(searchQuery!)) {
                return const SizedBox.shrink();
              }

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                child: ListTile(
                  onTap: (){
                    Get.to(
                  FollowerProfile(postUsedId: (user?.id ?? 0 ).toString(),)

                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 26,
                    backgroundColor: buttonColor,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 25,
                      child: AppCacheNetworkImage(
                        imageUrl: user?.photo?.url ?? '',
                        borderRadius: 50,
                        width: Get.width,
                        height: Get.height,
                      ),
                    ),
                  ),
                  title: Text(
                    user?.displayName ?? '',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.department ?? '',
                        style: GoogleFonts.poppins(
                          color: Colors.grey[700],
                          fontSize: 10,
                        ),
                      ),
                     TimeAgoCustomWidget(createdAt: user!.updatedAt.toString() , size: 10,)
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String calculateDaysAgo(String? createdAt) {
    if (createdAt == null || createdAt.isEmpty) {
      return "Invalid Date";
    }

    try {
      final DateTime followedDate = DateTime.parse(createdAt);
      final DateTime currentDate = DateTime.now();
      final Duration difference = currentDate.difference(followedDate);

      if (difference.inDays == 0) {
        return "Followed Today";
      } else if (difference.inDays == 1) {
        return "Followed Yesterday";
      } else {
        return "Followed ${difference.inDays} Days Ago";
      }
    } catch (e) {
      return "Invalid Date";
    }
  }
}
