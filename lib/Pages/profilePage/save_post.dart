
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/CustomWidget/app_cache_network_image.dart';
import 'package:sr_health_care/CustomWidget/expandable_text.dart';
import 'package:sr_health_care/CustomWidget/time_ago.dart';
import 'package:sr_health_care/Pages/profilePage/modelandservice/bookmarkpostlistmodel.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/services/post_save_and_unsave_service.dart';
import 'package:sr_health_care/services/share_plus_service.dart';

class SavedPostsPage extends StatefulWidget {
  const SavedPostsPage({super.key});

  @override
  State<SavedPostsPage> createState() => _SavedPostsPageState();
}

class _SavedPostsPageState extends State<SavedPostsPage> {
  List<Datum> savedPosts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSavedPosts();
    // savedPosts = SavedPostManager().savedPosts;
  }

  /// Fetch saved posts
  Future<void> _fetchSavedPosts() async {
    setState(() => isLoading = true); 
    try {
      final result =
          await PostSaveAndUnsaveService().fetchSavedPosts(context: context);
      if (result != null) {
        savedPosts.clear();
        savedPosts = result.data ?? [];
      }
      // savedPosts = SavedPostManager().savedPosts;
    } catch (e) {
      savedPosts = [];
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching saved posts: $e')),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

 

  void _unsavePost(int index) async {
    await PostSaveAndUnsaveService().removeSavedPost(
        context: context, postId: savedPosts[index].post!.id.toString());
    setState(() {
      savedPosts.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Post Unsaved',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black87,
        action: SnackBarAction(
          label: 'X',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Saved Posts And Articles',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: const Icon(Icons.arrow_back, color: Colors.black),
      ),
      body: savedPosts.isEmpty
          ? Center(
              child: Text(
                'No Posts Saved',
                style: GoogleFonts.poppins(
                    fontSize: 16, color: Colors.grey.shade600),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: 10 , bottom: 0),
              itemCount: savedPosts.length,
              itemBuilder: (context, index) {
                final post = savedPosts[index];
                return Container(
                  // height: Get.height * 0.65,
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        offset: const Offset(0, 4),
                        blurRadius: 9,
                        spreadRadius: 0.1,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        contentPadding:
                            const EdgeInsets.only(left: 10, right: 5),
                        leading: CircleAvatar(
                          radius: 26,
                          backgroundColor: buttonColor,
                          child: AppCacheNetworkImage(imageUrl: post.post?.user?.photo?.url , fit: BoxFit.cover, borderRadius: 50, width: 100,  height: 100,),
                        ),
                        // AppCacheNetworkImage(
                        //   imageUrl: post.user?.photo?.url  ??'',
                        //   borderRadius: 50,
                        //   fit: BoxFit.cover,
                        // ),
                        title: Text(
                          // '${post.user?.name ?? ''}  ${post.user?.lastName ?? ''}',
                          // '${post.user?.name} ${post.user?.lastName}',
                          '${post.post?.userName}',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                        subtitle: Text(
                          // post.user?.companyName ?? '',
                          '${post.post?.user?.department}',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: AppCacheNetworkImage(
                            imageUrl: post.post?.thumbnail,
                            fit: BoxFit.cover,
                            height: 180,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: ExpandableText(
                          text: 
                          post.post?.description ?? '',
                          // style: GoogleFonts.poppins(fontSize: 12),
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            if (post.post?.fieldName != null)
                              
                            _buildTag(post.post?.fieldName??''),
                            const SizedBox(width: 10),
                            if (post.post?.postType != null)
                            _buildTag(post.post?.postType??''),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Divider(thickness: 0.5, color: Colors.grey.shade300),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => _unsavePost(index),
                              child: _buildActionButton(
                                  'assets/myfeed/save.png', 'Unsave'),
                            ),
                            SizedBox(width: 10,),
                            GestureDetector(
                              onTap: (){
                                ShareService().shareText('Sharing Post ${post.post?.description ?? ''}');
                              },
                              child: _buildActionButton(
                                  'assets/homepage/share.png', 'Share'),
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Image.asset('assets/homepage/clock.png',
                                    height: 14),
                                const SizedBox(width: 5),
                                TimeAgoCustomWidget(
                                  size: 10,
                                  createdAt:
                                      post.post?.createdAt.toString() ?? '',
                                ),
                              
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Image.asset('assets/homepage/tag.png', height: 14),
          const SizedBox(width: 5),
          Text(
            tag,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String icon, String label) {
    return Row(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: Colors.grey.shade200,
          child: Image.asset(icon, height: 14),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: const Color(0xff6656E0),
          ),
        ),
      ],
    );
  }
}
