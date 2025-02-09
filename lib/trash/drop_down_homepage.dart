import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/Pages/Form_pages/create_post_service.dart';
import 'package:sr_health_care/Pages/Form_pages/field_response_model.dart';
import 'package:sr_health_care/const/colors.dart';

class DropdownExample extends StatefulWidget {
  final Function(String?) onLocationSelected; // Callback to update parent state

  const DropdownExample({super.key, required this.onLocationSelected});

  @override
  State<DropdownExample> createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownExample> {
  List<FieldTypeModel> dropdownItems = [];
  List<String> allDropdownItems = [];
  String? selectedItem = "All"; // Default selection
  final CreatePostService apiService = CreatePostService();

  @override
  void initState() {
    super.initState();
    fetchDropdownData();
  }

  Future<void> fetchDropdownData() async {
    final response = await apiService.fethInitialData('location');
    if (response != null && response.masterList != null) {
      setState(() {
        dropdownItems = response.masterList
                ?.where((item) => item.status == 'Active')
                .toSet()
                .toList() ??
            [];

        // Create a list of names with the static "All" value
        allDropdownItems = [
          "All",
          ...dropdownItems.map((item) => item.name ?? "")
        ];
        selectedItem = "All"; // Ensure "All" is selected initially
        widget.onLocationSelected(
            selectedItem); // Notify parent of default selection
      });
    } else {
      log('No data available');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.location_on, size: 18, color: Colors.white),
        SizedBox(width: 10),
        Flexible(
          // flex: 1,
          fit: FlexFit.tight,
          child: DropdownButtonFormField<String>(
            isDense: true,
            isExpanded: true,
            borderRadius: BorderRadius.circular(10),
            value: selectedItem,
            padding: EdgeInsets.zero,
            items: allDropdownItems
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedItem = value;
              });
              widget.onLocationSelected(value); // Notify parent of selection
            },
            decoration: InputDecoration(border: InputBorder.none),
            icon: SizedBox.shrink(),
            dropdownColor: buttonColor,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
        Spacer()
      ],
    );
  }
}
