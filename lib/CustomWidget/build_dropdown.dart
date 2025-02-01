// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class BuildDropdown extends StatefulWidget {
//   const BuildDropdown(
//       {super.key,
//       required String label,
//       required String hint,
//       required TextEditingController controller,
//       required List<String> items,
//       required Function(String) onChanged});

//   @override
//   State<BuildDropdown> createState() => _BuildDropdownState();
// }

// class _BuildDropdownState extends State<BuildDropdown> {
//   @override
//   Widget build(BuildContext context) {
//     return  Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         RichText(
//             text: TextSpan(
//                 text: label,
//                 style: GoogleFonts.poppins(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     color: blackColor),
//                 children: [
//               TextSpan(
//                 text: "*",
//                 style: GoogleFonts.poppins(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     color: Colors.red),
//               )
//             ])),
//         const SizedBox(height: 8),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey.shade300),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: DropdownButtonFormField<String>(
//             value: controller.text.isNotEmpty && items.contains(controller.text)
//                 ? controller.text
//                 : null,
//             style: GoogleFonts.poppins(
//                 color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w400),
//             borderRadius: BorderRadius.circular(12),
//             dropdownColor: Colors.white,
//             // value: controller.text.isNotEmpty ? controller.text : null,
//             items: items.toSet().map((String value) {
//               return DropdownMenuItem(
//                 value: value,
//                 child: Text(
//                   value,
//                   style: GoogleFonts.poppins(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w400,
//                       color: Colors.black),
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
// }
