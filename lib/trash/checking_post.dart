// import 'package:flutter/material.dart';

// import '../Pages/homePage/servicesModel/api_response_model.dart';
// import '../Pages/homePage/servicesModel/home_api_service.dart';


// class PostScreen extends StatefulWidget {
//   @override
//   _PostScreenState createState() => _PostScreenState();
// }

// class _PostScreenState extends State<PostScreen> {
//   late Future<ApiResponse> posts;

// @override
// void initState() {
//   super.initState();
//   posts = PostService().fetchPosts(); // Make sure `posts` is Future<ApiResponse>
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Posts')),
//       body: FutureBuilder<Map<String, dynamic>>(
//         future: posts,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data?['postList'] == null) {
//             return Center(child: Text('No posts found.'));
//           }

//           final postList = snapshot.data?['postList'];
          
//           return ListView.builder(
//             itemCount: postList.length,
//             itemBuilder: (context, index) {
//               final post = postList[index];
//               return ListTile(
//                 title: Text(post['description'] ?? 'No title'),
//                 subtitle: Text(post['location'] ?? 'No location'),
//                 trailing: Text(post['status'] ?? 'No status'),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
