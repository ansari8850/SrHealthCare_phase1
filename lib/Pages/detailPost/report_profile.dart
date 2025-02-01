import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/const/colors.dart';

class ReportProfileContent extends StatefulWidget {
  const ReportProfileContent({super.key});

  @override
  State<ReportProfileContent> createState() => ReportProfileContentState();
}

class ReportProfileContentState extends State<ReportProfileContent> {
  int selectedOption = -1;

  // List of report reasons
  final List<String> _reportReasons = [
    "This Account Is Impersonating Someone Else Or Using False Information",
    "This Account Is Sending Spam Messages Or Attempting Fraudulent Activities",
    "The User Is Promoting Self-Harm, Violence, Or Other Dangerous Activities",
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
                  "Report Profile",
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
          const SizedBox(height: 8),
          // Divider(thickness: 1, color: Colors.grey[300]),
          const SizedBox(height: 8),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _reportReasons.length,
            separatorBuilder: (_, __) => const SizedBox(
              height: .5,
            ),
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
                      fontSize: 11,
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
