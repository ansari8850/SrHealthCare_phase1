import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sr_health_care/Pages/Form_pages/create_post_service.dart';
import 'package:sr_health_care/Pages/Form_pages/sucessfull_post.dart';
import 'package:sr_health_care/Pages/homePage/servicesModel/post_model_class.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/sharedference.dart';
import 'package:sr_health_care/const/text.dart';
import 'package:sr_health_care/services/firebase_storage.dart';

class PreviewPostPage extends StatefulWidget {
  final PostModel post;
  const PreviewPostPage({super.key, required this.post});

  @override
  State<PreviewPostPage> createState() => _PreviewPostPageState();
}

class _PreviewPostPageState extends State<PreviewPostPage> {
  bool isLoading = false;
  DateTime? _selectedDate;
  DateTime? _autoDeleteDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        toolbarHeight: 90,
        title: CustomText(
            text: 'Preview Post',
            size: 24,
            color: blackColor,
            weight: FontWeight.w500),
        centerTitle: false,
        backgroundColor: Colors.grey.withValues(alpha: .1),
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: _sectionFirstTitle('Post Details'),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: _postDetailTile(
                  '${SharedPreferenceHelper().getUserData()?.displayName ?? ""} (${SharedPreferenceHelper().getUserData()?.department ?? ''}) '
                      '',
                  SharedPreferenceHelper().getUserData()?.companyName ??
                      "No Company Name Availabel",
                  '${SharedPreferenceHelper().getUserData()?.address ?? ""}(Hybrid)'),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: _locationTile(widget.post.location ?? ''),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: _dateTimeTile(widget.post.createdAt ?? DateTime.now()),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: _iconTextRow('Field', widget.post.fieldName ?? '',
                  'assets/homepage/filed.png'),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: _iconTextRow('Type', widget.post.postType?.type ?? '',
                  'assets/homepage/type.png'),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: .5,
                color: Colors.grey.withValues(alpha: .2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: _sectionTitle('Post Description'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.post.description ?? '',
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    height: 1.5,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              height: 20,
              decoration:
                  BoxDecoration(color: Colors.grey.withValues(alpha: .1)),
            ),
            const SizedBox(height: 24),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: _sectionTitle('Post Settings'),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: _postSettings(),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: _buildDateField('Date', 'Set a specific date',
            //       DateFormat("dd MMM yyyy").format(widget.post.autoDeleteDate)),
            // ),

            // const SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: Divider(
            //     thickness: .5,
            //     color: Colors.grey.withValues(alpha:.2),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: _AutoSheduleSettings(),
            // ),
            // // const SizedBox(height: 16),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: Divider(
            //     thickness: .5,
            //     color: Colors.grey.withValues(alpha:.2),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: _commentsToggle(),
            // ),
            // const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: _postNowButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionFirstTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        // CircleAvatar(
        //   radius: 17,
        //   backgroundColor: const Color(0xffBAF0F4).withValues(alpha:.4),
        //   // backgroundImage: AssetImage('assets/homepage/pen.png'),
        //   child: Image.asset(
        //     'assets/homepage/pen.png',
        //     height: 20,
        //   ),
        // )
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _postDetailTile(String title, String subtitle, String workmode) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          'assets/homepage/aggency.png',
          height: 40,
          width: 40,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                  // height: 1.4,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                workmode,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.withValues(alpha: .5),
                  height: 1.4,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        // const Icon(Icons.edit, color: Colors.grey),
      ],
    );
  }

  Widget _locationTile(String address) {
    return _iconTextRow('Location', address, 'assets/homepage/location.png');
  }

  Widget _dateTimeTile(DateTime date) {
    return _iconTextRow(
        'Date & Time',
        '${DateFormat.yMMMMEEEEd().format(date)}\n${DateFormat("h:mm a").format(date)}',
        'assets/homepage/dandt.png');
  }

  Widget _iconTextRow(String title, String subtitle, String icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              height: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.4,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _postSettings() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Auto Delete Post',
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w400),
              ),
              Text(
                'Time Based Auto delete',
                style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
          CircleAvatar(
            radius: 17,
            backgroundColor: const Color(0xffBAF0F4).withValues(alpha: .4),
            // backgroundImage: AssetImage('assets/homepage/pen.png'),
            child: Image.asset(
              'assets/homepage/pen.png',
              height: 20,
            ),
          )
        ],
      ),
    );
  }

  Widget _AutoSheduleSettings() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Auto Delete Post',
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w400),
              ),
              Text(
                'Time Based Auto delete',
                style: GoogleFonts.poppins(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
          CircleAvatar(
              radius: 17,
              backgroundColor: const Color(0xffBAF0F4).withValues(alpha: .4),
              // backgroundImage: AssetImage('assets/homepage/pen.png'),
              child: const Icon(
                Icons.add,
                color: Colors.grey,
              ))
        ],
      ),
    );
  }

  // Date Picker Function
  Future<void> _pickDate(
      BuildContext context, Function(DateTime) onDatePicked) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      // Update state to the newly selected date
      setState(() {
        _selectedDate = picked;
      });
      onDatePicked(picked);
    }
  }

  Widget _buildDateField(String label, String placeholder, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(
                text: label,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: blackColor),
                children: const [
              // TextSpan(
              //   text: "*",
              //   style: GoogleFonts.poppins(
              //       fontSize: 14,
              //       fontWeight: FontWeight.w400,
              //       color: Colors.red),
              // )
            ])),
        const SizedBox(height: 8),
        InkWell(
          // onTap: onTap, // Open date picker when tapped
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date, // Show selected date or placeholder
                  style: GoogleFonts.poppins(
                      color: _selectedDate != null
                          ? Colors.black
                          : Colors.grey.shade400,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                Image.asset(
                  'assets/homepage/clanedar.png',
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _settingTile(String title, String date, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          date,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 4),
        const Icon(Icons.edit, color: Colors.grey),
      ],
    );
  }

  Widget _commentsToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Post Comments',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              'Public Commenting Will Be On/Off On Created Post',
              style: GoogleFonts.poppins(
                fontSize: 9,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        Switch(
          value: true,
          onChanged: (bool value) {},
          activeColor: Colors.teal,
        ),
      ],
    );
  }

  Widget _postNowButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          final imageFile = File(widget.post.thumbnail ?? '');
          final imageUrl = await FirebaseStorageService().uploadFile(imageFile);
          final message = await CreatePostService().createPost(
              description: widget.post.description,
              fieldId: int.tryParse(widget.post.fieldId ?? ''),
              location: widget.post.location,
              date: widget.post.createdAt.toString(),
              autodeletedate: widget.post.autoDeleteDate.toString(),
              thumbnail: imageUrl,
              postType: widget.post.postType?.type,
              postId: widget.post.postType?.id ?? 0,
              title: widget.post.fieldName);
          setState(() {
            isLoading = false;
          });
          if (message?.contains('success') == true) {
            Get.to(const SucessfullPost());
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("$message")),
            );
          }
          // Get.to(const SucessfullPost());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : const Text(
                'Post Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    );
  }
}
