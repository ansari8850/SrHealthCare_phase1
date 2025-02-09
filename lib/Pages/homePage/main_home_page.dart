// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sr_health_care/Controller/save_post_controller.dart';
// import 'package:sr_health_care/CustomWidget/app_cache_network_image.dart';
// import 'package:sr_health_care/CustomWidget/expandable_text.dart';
// import 'package:sr_health_care/CustomWidget/modal_bottom_sheet_home.dart';
// import 'package:sr_health_care/CustomWidget/time_ago.dart';
// import 'package:sr_health_care/Pages/Form_pages/create_post_form.dart';
// import 'package:sr_health_care/Pages/Form_pages/create_post_service.dart';
// import 'package:sr_health_care/Pages/Form_pages/field_response_model.dart';
// import 'package:sr_health_care/Pages/homePage/post_detail_page.dart';
// import 'package:sr_health_care/Pages/homePage/search_page.dart';
// import 'package:sr_health_care/Pages/homePage/servicesModel/home_api_service.dart';
// import 'package:sr_health_care/Pages/homePage/servicesModel/post_model_class.dart';
// import 'package:sr_health_care/Pages/notification/notification.dart';
// import 'package:sr_health_care/Pages/profilePage/save_post.dart';
// import 'package:sr_health_care/const/colors.dart';
// import 'package:sr_health_care/const/sharedference.dart';
// import 'package:sr_health_care/const/text.dart';
// import 'package:sr_health_care/services/share_plus_service.dart';

// final savepostController = SavePostController.instance;

// class MainHomePage extends StatefulWidget {
//   const MainHomePage({super.key});

//   @override
//   State<MainHomePage> createState() => _MainHomePageState();
// }

// class _MainHomePageState extends State<MainHomePage> {
//   List<PostModel> postList = [];
//   bool isLoading = true;
//   // List<PostModel> eventPostList = [];
//   // List<PostModel> productPostList = [];
//   // List<PostModel> jobPostList = [];
//   List<FieldTypeModel> postTypeList = [];
//   List<FieldTypeModel> selectedLocationTypes = [];
//   List<FieldTypeModel> locationList = [];
//   Map<String, List<PostModel>> postDataList = {};

//   String selectedtab = 'All';
//   String selectedLocation = 'All';
//   // TextEditingController searchController = TextEditingController();
//   TextEditingController locationController = TextEditingController();
//   TextEditingController typeController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     getData();
//     initData();
//   }

//   void initData() async {
//     // Fetch data for locations
//     final locationResponse =
//         await CreatePostService().fethInitialData('location');
//     locationList = locationResponse?.masterList
//             ?.where((item) => item.status == 'Active')
//             .toSet()
//             .toList() ??
//         []; // Ensure uniqueness

//     // Fetch data for post types
//     final postTypeResponse = await CreatePostService().fethInitialData('post');
//     postTypeList = postTypeResponse?.masterList
//             ?.where((item) => item.status == 'Active') // Filter active items
//             .toSet() // Remove duplicates
//             .toList() ??
//         [];

// // Add "All" as the first item in the list
//     postTypeList.insert(0, FieldTypeModel(name: "All"));

//     setState(() {
//       selectedLocationTypes = [
//         FieldTypeModel(name: 'All'), // Always include "All" tab first
//         ...postTypeList
//             .where((e) => e.location.toLowerCase() == selectedLocationTypes)
//             .map((item) => FieldTypeModel(name: item.name))
//             .toSet(), // Ensure uniqueness
//       ];
//     });
//   }

//   Future<void> getData() async {
//     final (error, data) = await PostService().fetchPosts();
//     if (error?.isNotEmpty == true || data == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(error ?? 'Something went wrong')),
//       );
//     } else {
//       final allPost = data.postList
//               ?.where((element) => element.status == 'Approved')
//               .toList() ??
//           [];

//       // Clear previous post data before adding new posts
//       postDataList.clear();
//       savepostController.savedPostID.clear();

//       print('object');

//       // If "All" tab is selected, add all posts to the postDataList
//       if (selectedtab == 'All') {
//         postDataList['All'] = allPost;
//       } else {  
//         // Add posts based on selected tab (Event, Product, Job, etc.)
//         for (var i = 0; i < allPost.length; i++) {
//           if (selectedtab == allPost[i].postType?.name) {
//             final list = postDataList[selectedtab] ?? [];
//             list.add(allPost[i]);
//             log(allPost[i].isSaved.toString());
//             log(allPost[i].id.toString());
//             if (allPost[i].id != null && allPost[i].isSaved == 0) {
//               savepostController.savedPostID.add(allPost[i].id!);
//             }
//             postDataList[selectedtab] = list;
//           }
//         }
//       }

//       // Update the post list for UI
//       setState(() {
//         postList = allPost;
//       });
//     }
//     setState(() {
//       isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: whiteColor,
//       body: CustomScrollView(
//         slivers: [
//           SliverToBoxAdapter(
//             child: Container(
//               padding: const EdgeInsets.only(top: 50, left: 15, right: 15),
//               decoration: const BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Color.fromARGB(255, 23, 7, 168),
//                     Color.fromARGB(255, 93, 53, 138)
//                   ],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(20),
//                   bottomRight: Radius.circular(20),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           ShaderMask(
//                             shaderCallback: (bounds) => const LinearGradient(
//                               colors: [
//                                 Color(0xFFDCFFF6),
//                                 Color(0xFF18B78E),
//                               ],
//                               begin: Alignment.topCenter,
//                               end: Alignment.bottomCenter,
//                             ).createShader(bounds),
//                             child: Text(
//                               "${SharedPreferenceHelper().getUserData()?.name} ${SharedPreferenceHelper().getUserData()?.lastName}",
//                               style: GoogleFonts.poppins(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           Text(
//                             '👋',
//                             style: GoogleFonts.poppins(
//                               fontSize: 20,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                             ),
//                           )
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           CircleAvatar(
//                             backgroundColor: Colors.white.withValues(alpha:.2),
//                             child: Stack(
//                               clipBehavior: Clip.none,
//                               children: [
//                                 InkWell(
//                                   onTap: () {
//                                     Get.to(const NotificationPage());
//                                   },
//                                   child: const Icon(
//                                       Icons.notifications_none_outlined,
//                                       color: Colors.white),
//                                 ),
//                                 Positioned(
//                                     right: -3,
//                                     top: -2,
//                                     child: Container(
//                                         padding: const EdgeInsets.symmetric(
//                                             vertical: 2, horizontal: 5),
//                                         decoration: BoxDecoration(
//                                             color: const Color(0xffB3261E),
//                                             borderRadius:
//                                                 BorderRadius.circular(100)),
//                                         child: Text(
//                                           '2',
//                                           style: GoogleFonts.poppins(
//                                               color: whiteColor,
//                                               fontSize: 8,
//                                               fontWeight: FontWeight.w600),
//                                         )))
//                               ],
//                             ),
//                           ),
//                           const SizedBox(width: 10),
//                           GestureDetector(
//                             onTap: () {
//                               Get.to(SavedPostsPage());
//                             },
//                             child: CircleAvatar(
//                               backgroundColor: Colors.white.withValues(alpha:0.2),
//                               child: const Icon(Icons.bookmark_border_outlined,
//                                   color: Colors.white),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                   // const SizedBox(height: 5),
//                   Row(
//                     // mainAxisAlignment: MainAxisAlignment.end,
//                     // crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 0),
//                         child: const Icon(Icons.location_on,
//                             size: 18, color: Colors.white),
//                       ),
//                       const SizedBox(width: 5),
//                       SizedBox(
//                         height: 60,
//                         child: _buildDropdown(
//                           label: 'Location',
//                           hint: 'Type Location',
//                           controller: locationController,
//                           items: locationList
//                               .map((e) => e.name.toString())
//                               .toList(),
//                           onChanged: (value) {
//                             typeController.clear();

//                             // Set the selected location
//                             selectedLocation = value;

//                             // Update the selectedLocationTypes to include "All" as the first tab
//                             selectedLocationTypes = [
//                               FieldTypeModel(
//                                   name: 'All'), // Always include the "All" tab
//                               ...postTypeList
//                                   .where((e) =>
//                                       e.location.toString().toLowerCase() ==
//                                       value.toLowerCase())
//                                   .toList(),
//                             ];

//                             setState(() {});
//                           },
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 15),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         child: GestureDetector(
//                           onTap: () {
//                             Get.to(
//                                 transition: Transition.zoom,
//                                 duration: const Duration(milliseconds: 2),
//                                 const SearchPage());
//                           },
//                           child: Container(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               height: 40,
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(25),
//                               ),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   const Icon(Icons.search_rounded),
//                                   const SizedBox(
//                                     width: 10,
//                                   ),
//                                   Text(
//                                     'Search Posts , Categorie..',
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w500,
//                                         color: Colors.grey),
//                                   ),
//                                 ],
//                               )),
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           showModalBottomSheet(
//                               isScrollControlled: true,
//                               context: context,
//                               builder: (_) => const SortFilterBottomSheet());
//                         },
//                         child: CircleAvatar(
//                           backgroundColor: whiteColor,
//                           child: Image.asset(
//                             'assets/homepage/filter.png',
//                             height: 18,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),

//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),

//           // Category Tabs Section
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//               child: SizedBox(
//                 height: 35,
//                 child: ListView.builder(
//                   itemCount: postTypeList
//                       .map((e) => e.name) // Extract tab names
//                       .toSet() // Remove duplicates by converting to Set
//                       .length,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, index) {
//                     // Generate a list of unique tab names
//                     List<String> uniqueTabs = postTypeList
//                         .map((e) => e.name ?? '') // Extract tab names safely
//                         .toSet() // Remove duplicates
//                         .toList();

//                     String tabName = uniqueTabs[index];
//                     return GestureDetector(
//                       onTap: () => _onTabClicked(tabName), // Handle tab click
//                       child: _buildTab(
//                         tabName,
//                         selectedtab == tabName, // Highlight the selected tab
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),

//           // Main Content Section
//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (context, index) {
//                 final post = (postDataList[selectedtab]?.isNotEmpty ?? false)
//                     ? postDataList[selectedtab]![index]
//                     : null;

//                 if (post == null) {
//                   return SizedBox.shrink(); // Avoid displaying an empty item
//                 }
//                 return Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
//                   child: GestureDetector(
//                     onTap: () async {
//                       log('message');
//                       final value = await Get.to(() => PostDetailPage(
//                             post: post,
//                           ));
//                       log(value);
//                       if (value == true) {
//                         setState(() {
//                           getData();
//                         });
//                       }
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(15),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.shade100,
//                             blurRadius: 10,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               CircleAvatar(
//                                 radius: 31,
//                                 backgroundColor: buttonColor,
//                                 child: CircleAvatar(
//                                   radius: 30,
//                                   backgroundColor: buttonColor,
//                                   child: AppCacheNetworkImage(
//                                     width: Get.width,
//                                     borderRadius: 50,
//                                     imageUrl: post?.user?.photo?.url ?? '',
//                                     height: Get.height,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 10),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       post?.userName ?? '',
//                                       style: GoogleFonts.poppins(
//                                         fontSize: 14,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     Text(
//                                       post?.user?.department ?? '',
//                                       style: GoogleFonts.poppins(
//                                         fontSize: 12,
//                                         color: Colors.grey.shade600,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 10),
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: AppCacheNetworkImage(
//                               imageUrl: post?.thumbnail ?? '',
//                               fit: BoxFit.cover,
//                               height: 180,
//                               width: double.infinity,
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           ExpandableText(
//                             text: post?.description ??
//                                 '', // Pass the description here
//                             trimLength:
//                                 100, // Optional: Adjust how many characters to display before truncating
//                           ),
//                           const SizedBox(height: 10),
//                           Padding(
//                             padding: const EdgeInsets.only(right: 8),
//                             child: _buildChip(post?.fieldName ?? ''),
//                           ),
//                           const SizedBox(height: 10),
//                           Divider(
//                             thickness: .5,
//                             color: Colors.grey.withValues(alpha:.2),
//                           ),
//                           Row(
//                             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Obx(
//                                  () {
//                                   return SaveButton(
//                                     postId: post?.id ?? -1,
//                                     isSaved: savepostController.savedPostID
//                                         .contains(post.id),
//                                   );
//                                 }
//                               ),
//                               const SizedBox(
//                                 width: 15,
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   ShareService().shareText(
//                                       'Hello This Is My Post on Sr HealthCare ${post?.thumbnail}');
//                                 },
//                                 child: _buildAction(
//                                     'assets/homepage/share.png', "Share"),
//                               ),
//                               const Spacer(),
//                               Row(
//                                 children: [
//                                   Image.asset(
//                                     'assets/homepage/clock.png',
//                                     height: 15,
//                                   ),
//                                   const SizedBox(
//                                     width: 5,
//                                   ),
//                                   TimeAgoCustomWidget(
//                                     createdAt: post?.createdAt.toString() ?? '',
//                                     size: 10,
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               childCount: postDataList[selectedtab]?.length ?? 0,
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: HomeFloatingButtonCreatePost(),
    
//     );
//   }

//   void _onTabClicked(String tabName) {
//     setState(() {
//       selectedtab = tabName; // Update the selected tab
//     });
//   }

//   Widget _buildDropdown(
//       {required String label,
//       required String hint,
//       required TextEditingController controller,
//       required List<String> items,
//       required Function(String) onChanged}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 8),
//         Container(
//           width: 200,
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           decoration: BoxDecoration(
//             // border: Border.all(color: Colors.grey.shade300),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: DropdownButtonFormField<String>(
//             isExpanded: true,
//             value: controller.text.isNotEmpty && items.contains(controller.text)
//                 ? controller.text
//                 : null,
//             style: GoogleFonts.poppins(
//                 color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400),
//             borderRadius: BorderRadius.circular(12),
//             dropdownColor: buttonColor,
//             // value: controller.text.isNotEmpty ? controller.text : null,
//             items: items.toSet().map((String value) {
//               return DropdownMenuItem(
//                 value: value,
//                 child: Text(
//                   value,
//                   style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.white),
//                 ),
//               );
//             }).toList(),
//             onChanged: (value) {
//               // debugger();
//               if (value != null) {
//                 onChanged.call(value);
//               }
//               controller.text = value.toString();
//             },
//             // controller: controller,
//             decoration: InputDecoration(
//               hintText: hint,
//               hintStyle: GoogleFonts.poppins(
//                   color: Colors.grey.shade100,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w400),
//               border: InputBorder.none,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildTab(String title, bool isActive) {
//     return GestureDetector(
//       onTap: () {
//         selectedtab = title;
//         setState(() {});
//       },
//       child: Container(
//         // height: 100,
//         // width: 100,
//         padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
//         decoration: BoxDecoration(
//           color: isActive ? buttonColor : buttonColor.withValues(alpha:.03),
//           borderRadius: BorderRadius.circular(15),
//           // border:
//           //     isActive ? null : Border.all(color: Colors.grey.shade300, width: 1),
//         ),
//         child: Text(
//           title,
//           style: GoogleFonts.poppins(
//             color: isActive ? Colors.white : Colors.black87,
//             fontSize: 13,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildChip(String title) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       decoration: BoxDecoration(
//         color: Colors.purple.withValues(alpha:.03),
//         borderRadius: BorderRadius.circular(25),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Image.asset(
//             'assets/homepage/tag.png',
//             height: 15,
//           ),
//           const SizedBox(
//             width: 8,
//           ),
//           Text(
//             title,
//             style: GoogleFonts.poppins(
//               fontSize: 11,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildAction(String image, String label) {
//     return Row(
//       children: [
//         CircleAvatar(
//             radius: 15,
//             backgroundColor: const Color(0xffBAF0F4).withValues(alpha:.4),
//             child: Image.asset(
//               image,
//               height: 15,
//             )),
//         const SizedBox(width: 5),
//         Text(
//           label,
//           style: GoogleFonts.poppins(
//               fontSize: 12,
//               fontWeight: FontWeight.w400,
//               color: const Color(0xff6656E0)),
//         ),
//       ],
//     );
//   }
// }

// class HomeFloatingButtonCreatePost extends StatelessWidget {
//   const HomeFloatingButtonCreatePost({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width / 2.5,
//       // decoration: BoxDecoration(color: buttonColor),
//       child: FloatingActionButton(
//         backgroundColor: const Color(0xff402CD8),
//         shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         onPressed: () {
//           Get.to(const CreatePostPage());
//         },
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(
//               Icons.add,
//               color: Colors.white,
//             ),
//             const SizedBox(
//               width: 5,
//             ),
//             CustomText(
//                 text: 'Create Post',
//                 size: 14,
//                 color: whiteColor,
//                 weight: FontWeight.w400)
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SaveButton extends StatefulWidget {
//   const SaveButton({
//     super.key,
//     required this.isSaved,
//     required this.postId,
//     this.layoutType = Axis.horizontal,
//   });

//   final bool isSaved;
//   final int postId;
//   final Axis layoutType;

//   @override
//   State<SaveButton> createState() => _SaveButtonState();
// }

// class _SaveButtonState extends State<SaveButton> {
//   late final SavePostController _savePostController;

//   @override
//   void initState() {
//     super.initState();
//     _savePostController = Get.find<SavePostController>();
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isSaved = _savePostController.isPostSaved(widget.postId);

//     return InkWell(
//       onTap: () async {
//         if(savepostController.savedPostID.contains( widget.postId)){
//           savepostController.savedPostID.remove( widget.postId);
//         }else{
//           savepostController.savedPostID.add( widget.postId);
//         }
//         await _savePostController.toggleSave(
//           widget.postId,
//           isSaved: isSaved,
//           onStateChange: () {
//             setState(() {});
//           },
//         );
//       },
//       child: widget.layoutType == Axis.horizontal
//           ? Row(
//               children: [
//                 CircleAvatar(
//                   radius: 15,
//                   backgroundColor: const Color(0xffBAF0F4).withValues(alpha:.4),
//                   child: Image.asset(
//                     isSaved
//                         ? 'assets/myfeed/save.png'
//                         : 'assets/homepage/save.png',
//                     height: 15,
//                   ),
//                 ),
//                 const SizedBox(width: 5),
//                 Text(
//                   isSaved ? 'Unsave' : 'Save',
//                   style: GoogleFonts.poppins(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                     color: const Color(0xff6656E0),
//                   ),
//                 ),
//               ],
//             )
//           : Column(
//               children: [
//                 Image.asset(
//                   isSaved
//                       ? 'assets/myfeed/save.png'
//                       : 'assets/homepage/save.png',
//                   height: 24,
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   isSaved ? 'Unsave' : 'Save',
//                   style: GoogleFonts.poppins(
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.black,
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }
