import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isRequired;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.maxLength,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: RichText(
            text: TextSpan(
              text: label,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              children: isRequired
                  ? [
                      TextSpan(
                        text: " *",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.red,
                        ),
                      )
                    ]
                  : [],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.withOpacity(0.5)),
          ),
          child: TextFormField(
            controller: controller,
            cursorColor: Colors.grey,
            keyboardType: keyboardType,
            validator: validator,
            maxLength: maxLength,
            inputFormatters: inputFormatters,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(12),
              border: InputBorder.none,
              // Hide the built-in counter text
              counterText: '',
            ),
          ),
        ),
      ],
    );
  }
}
