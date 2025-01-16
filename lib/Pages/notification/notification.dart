import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/text.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, String>> notifications = [
    {
      'title': 'Your Shop Mobile Number Is Updated Successfully',
      'date': 'Jul 23, 2024 At 9:15 AM',
    },
    {
      'title': 'Your Order Has Been Shipped',
      'date': 'Jul 22, 2024 At 1:00 PM',
    },
    {
      'title': 'Welcome to Our Service',
      'date': 'Jul 20, 2024 At 10:00 AM',
    },
  ];

  void _deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notification deleted')),
    );
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            Navigator.pop(context);
            _deleteNotification(index);
          },
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
                // padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  leading: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 40,
                  ),
                  title: const CustomText(
                      text: 'Delete',
                      size: 16,
                      color: Colors.red,
                      weight: FontWeight.w500),
                  // subtitle: CustomText(
                  //     text: 'Delete this notification',
                  //     size: 16,
                  //     color: blackColor,
                  //     weight: FontWeight.w400),
                )),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Notifications(${notifications.length})',
          style: GoogleFonts.poppins(
              color: const Color(0xff3F3F3F),
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  radius: 22,
                  child: Icon(Icons.notifications, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notifications[index]['title']!,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notifications[index]['date']!,
                        style: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => _showDeleteDialog(index),
                  child: const Icon(Icons.more_vert, color: Colors.black54),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
