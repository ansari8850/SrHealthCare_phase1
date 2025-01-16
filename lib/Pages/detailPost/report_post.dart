import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/const/colors.dart';

class ReportPost extends StatefulWidget {
  const ReportPost({super.key});

  @override
  State<ReportPost> createState() => ReportPostState();
}

class ReportPostState extends State<ReportPost> {
  int selectedOption = -1;

  // List of report reasons
  final List<String> _reportReasons = [
    "I'm Not Interested In The Cretor",
    "I'm Not Interested In The Topic",
    "Have Seen This Post Before",
    "The Post Provides False Or Deceptive Content",
    "Te Post Contains Threts Or Promotes Violence",
    "The Post Contains Explicit Or Sensitive Visuals",
    "Other Reason",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Close button and title aligned
          Row(
            children: [
              const Expanded(
                child: Text(
                  "Report Post",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              IconButton(
                icon: CircleAvatar(
                    backgroundColor: buttonColor,
                    child: Icon(
                      Icons.close,
                      color: whiteColor,
                    )),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),

          ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 0),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _reportReasons.length,
            itemBuilder: (context, index) {
              return ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 11,
                  backgroundColor: whiteColor,
                  child: Radio(
                    visualDensity: VisualDensity.comfortable,
                    value: index,
                    groupValue: selectedOption,
                    activeColor: const Color(0xff65558F),
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value as int;
                      });
                    },
                  ),
                ),
                title: Text(
                  _reportReasons[index],
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400),
                ),
              );
            },
          ),
          // SizedBox(height: 16)
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                if (selectedOption != -1) {
                  Navigator.pop(context);
                  // Handle submission logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Report submitted successfully!"),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please select a reason to continue."),
                    ),
                  );
                }
              },
              child: const Text(
                "Submit",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
