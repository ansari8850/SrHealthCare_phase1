import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLength;
   Color color;

   ExpandableText({
    super.key,
    required this.text,
    this.trimLength = 61, // Default to 100 characters before collapsing
    this.color = const Color(0xff402CD8),
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false; // Track whether text is expanded or collapsed

  @override
  Widget build(BuildContext context) {
    final isTextLong = widget.text.length > widget.trimLength;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _isExpanded || !isTextLong
              ? widget.text // Show full text if expanded
              : '${widget.text.substring(0, widget.trimLength)}...', // Show trimmed text
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Color(0xff55545D),
            fontWeight: FontWeight.w400,
          ),
        ),
        if (isTextLong) // Show "See More" or "See Less" only for long texts
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded; // Toggle state
              });
            },
            child: Text(
              _isExpanded ? "See Less" : "See More",
              style: GoogleFonts.poppins(
                // height: 14,
                  fontSize: 12,
                  color: widget.color,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline),
            ),
          ),
      ],
    );
  }
}
