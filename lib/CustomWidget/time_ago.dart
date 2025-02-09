import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:google_fonts/google_fonts.dart';

class TimeAgoCustomWidget extends StatelessWidget {
  final String createdAt;
  final double size;

  const TimeAgoCustomWidget(
      {super.key, required this.createdAt, this.size = 14});

  @override
  Widget build(BuildContext context) {
    final formattedTime = timeago
        .format(DateTime.tryParse(createdAt) ?? DateTime.now(), locale: 'en');

    return Text(
      formattedTime,
      style: GoogleFonts.poppins(
        fontSize: size,
        color: Colors.grey.shade600,
      ),
    );
  }
}
