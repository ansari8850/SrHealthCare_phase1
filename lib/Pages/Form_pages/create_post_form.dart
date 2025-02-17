import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/Pages/Form_pages/create_post_service.dart';
import 'package:sr_health_care/Pages/Form_pages/field_response_model.dart';
import 'package:sr_health_care/Pages/Form_pages/post_preview.dart';
import 'package:sr_health_care/Pages/homePage/servicesModel/post_model_class.dart';
import 'package:sr_health_care/const/colors.dart';
import 'package:sr_health_care/const/text.dart';
import 'package:sr_health_care/services/image_picker_service.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  VideoPlayerController? _videoController;
  DateTime? _deleteDate;
  bool _isAutoDeleteEnabled = false;
  File? selectedFile;
  bool isVideo = false;
  int? selectedFieldId;

  TextEditingController locationController = TextEditingController();
  TextEditingController fieldController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<FieldTypeModel> fieldList = [];
  List<FieldTypeModel> locationList = [];
  List<FieldTypeModel> postTypeList = [];
  List<FieldTypeModel> selectedLocationFields = [];
  List<FieldTypeModel> selectedLocationTypes = [];

  @override
  void initState() {
    super.initState();
    // CreatePostService().fethInitialData('field');
    initData();
  }

  void initData() async {
    // Fetch data for fields
    final fieldResponse = await CreatePostService().fethInitialData('field');
    fieldList = fieldResponse?.masterList
            ?.where((item) => item.status == 'Active')
            .toSet()
            .toList() ??
        []; // Ensure uniqueness

    // Fetch data for locations
    final locationResponse =
        await CreatePostService().fethInitialData('location');
    locationList = locationResponse?.masterList
            ?.where((item) => item.status == 'Active')
            .toSet()
            .toList() ??
        []; // Ensure uniqueness

    // Fetch data for post types
    final postTypeResponse = await CreatePostService().fethInitialData('post');
    postTypeList = postTypeResponse?.masterList
            ?.where((item) => item.status == 'Active')
            .toSet()
            .toList() ??
        []; // Ensure uniqueness

    setState(() {});
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Select Date';
    return DateFormat("dd, MMM yyyy").format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        title: CustomText(
            text: 'Create A Post',
            size: 24,
            color: blackColor,
            weight: FontWeight.w500),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDropdown(
              label: 'Location',
              hint: 'Type Location',
              controller: locationController,
              items: locationList.map((e) => e.name.toString()).toList(),
              onChanged: (value) {
                selectedLocationFields = fieldList
                    .where((e) =>
                        e.location.toString().toLowerCase() ==
                        value.toLowerCase())
                    .toList();
                typeController.clear();
                selectedLocationTypes = postTypeList
                    .where((e) =>
                        e.location.toString().toLowerCase() ==
                        value.toLowerCase())
                    .toList();
                setState(() {});
              },
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              label: 'Field',
              hint: 'Select Field Type',
              controller: fieldController,
              items: fieldList.map((e) => e.name.toString()).toList(),
              onChanged: (value) {
                // Find the selected field in the list
                final selectedField = fieldList.firstWhere(
                  (field) => field.name == value,
                  orElse: () => FieldTypeModel(),
                );
                // Store the ID of the selected field
                setState(() {
                  selectedFieldId = selectedField.id;
                });
              },
            ),

            const SizedBox(height: 16),
            _buildDropdown(
                label: 'Type',
                hint: 'Select Type',
                controller: typeController,
                items: selectedLocationTypes
                    .map((e) => e.name.toString())
                    .toList(),
                onChanged: (value) {}),

            // const SizedBox(height: 16),
            // _buildDateField('Posting Date', 'Select Date', () {
            //   _pickDate(context, (date) {
            //     setState(() => _postingDate = date);
            //   });
            // }, _postingDate),
            const SizedBox(height: 16),
            _buildFileUpload(
              (img) {
                setState(() {
                  selectedFile = img;
                  isVideo = false;
                });
              },
              (vid) {
                setState(() {
                  selectedFile = vid;
                  isVideo = true;
                });
              },
            ),

            const SizedBox(height: 16),
            Text(
              'Description',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            _buildDescriptionField(descriptionController),
            const SizedBox(height: 16),
            _buildAutoDeleteToggle(),
            if (_isAutoDeleteEnabled)
              _buildDateField('Auto Delete Date', 'Set a specific date', () {
                _pickDate(context, (date) {
                  setState(() => _deleteDate = date);
                });
              }, _deleteDate),
            const SizedBox(height: 24),
            _buildNextButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String hint,
    required TextEditingController controller,
    required List<String> items,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: blackColor,
            ),
            children: [
              TextSpan(
                text: "*",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: label == 'Location'
              ? InkWell(
                  onTap: () {
                    _showSearchDialog(context, controller, items, onChanged);
                  },
                  child: IgnorePointer(
                    child: TextFormField(
                      controller: controller,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                )
              : DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: controller.text.isNotEmpty &&
                          items.contains(controller.text)
                      ? controller.text
                      : null,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                  ),
                  items: items.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(
                        value,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      controller.text = value;
                      onChanged(value);
                    }
                  },
                ),
        ),
      ],
    );
  }

  void _showSearchDialog(
    BuildContext context,
    TextEditingController controller,
    List<String> items,
    Function(String) onChanged,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        String searchQuery = '';
        List<String> filteredItems = List.from(items);

        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        autofocus: true,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 12),
                          hintText: 'Search...',
                          hintStyle: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          prefixIcon:
                              Icon(Icons.search, color: Colors.grey.shade600),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: buttonColor),
                          ),
                        ),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value.toLowerCase();
                            filteredItems = items
                                .where((item) =>
                                    item.toLowerCase().contains(searchQuery))
                                .toList();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: filteredItems.length,
                        separatorBuilder: (context, index) =>
                            Divider(height: 1, color: Colors.grey.shade200),
                        itemBuilder: (context, index) {
                          return Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                controller.text = filteredItems[index];
                                onChanged(filteredItems[index]);
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                child: Text(
                                  filteredItems[index],
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    if (filteredItems.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'No results found',
                          style: GoogleFonts.poppins(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDateField(
      String label, String placeholder, VoidCallback onTap, DateTime? date) {
    String dateText = _formatDate(date);

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
                children: [
              TextSpan(
                text: "*",
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.red),
              )
            ])),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
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
                  dateText,
                  style: GoogleFonts.poppins(
                      color: date != null ? Colors.black : Colors.grey.shade400,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                const Icon(Icons.calendar_today, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _initializeVideo(File videoFile) async {
    // Dispose any previous controller
    _videoController?.dispose();
    _videoController = VideoPlayerController.file(videoFile);
    await _videoController!.initialize();
    // Optionally auto-play the video once initialized:
    _videoController!.setLooping(true);
    _videoController!.play();
    setState(() {});
  }

  Widget _buildFileUpload(
      Function(File?) onPickImage, Function(File?) onPickVideo) {
    return GestureDetector(
      onTap: () async {
        showModalBottomSheet(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: Colors.white,
          context: context,
          builder: (context) {
            return SizedBox(
              height: Get.height / 5,
              width: Get.width,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Select which File you want to upload',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final image = await ImagePickerService()
                                .pickImageFromGallery();
                            if (image != null) {
                              // If an image (or GIF) is selected, dispose any video controller.
                              _videoController?.dispose();
                              setState(() {
                                selectedFile = image;
                                isVideo = false;
                              });
                            }
                            onPickImage(image);
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, right: 5),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              'Image',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final video = await ImagePickerService()
                                .pickVideoFromGallery();
                            if (video != null) {
                              // Initialize the video controller for preview.
                              await _initializeVideo(video);
                              setState(() {
                                selectedFile = video;
                                isVideo = true;
                              });
                            }
                            onPickVideo(video);
                            Navigator.pop(context);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10, left: 5),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              'Video',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Image/Video',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: selectedFile != null
                ? Stack(
                    children: [
                      // Preview content:
                      isVideo
                          ? _videoController != null &&
                                  _videoController!.value.isInitialized
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: AspectRatio(
                                    aspectRatio:
                                        _videoController!.value.aspectRatio,
                                    child: VideoPlayer(_videoController!),
                                  ),
                                )
                              : const Center(child: CircularProgressIndicator())
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                selectedFile!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                      // Positioned label showing the file format
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            isVideo
                                ? 'Video'
                                : selectedFile!.path
                                        .toLowerCase()
                                        .endsWith('.gif')
                                    ? 'GIF'
                                    : 'Image',
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cloud_upload,
                          size: 40, color: Colors.grey),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Browse and choose the files you want to upload from your Device',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(Icons.add,
                            size: 20, color: Colors.white),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionField(TextEditingController controller) {
    return TextField(
      controller: controller,
      maxLines: 4,
      decoration: InputDecoration(
        hintText: 'Enter Job Description',
        hintStyle: GoogleFonts.poppins(
            color: Colors.grey.shade400,
            fontSize: 14,
            fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }

  Widget _buildAutoDeleteToggle() {
    return Row(
      children: [
        Checkbox(
          value: _isAutoDeleteEnabled,
          onChanged: (value) {
            setState(() {
              _isAutoDeleteEnabled = value ?? false;
            });
          },
          activeColor: Colors.deepPurple,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Auto Delete Post',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            Text(
              'Time Based Auto delete',
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNextButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          // final postType = PostType(
          //   fieldName: fieldController.text,
          //   type: typeController.text,
          // );
          final selectedField = fieldList.firstWhere(
            (item) => item.name == fieldController.text,
            orElse: () => FieldTypeModel(),
          );
          final fieldId = selectedField.id;
          final selectedPostType = postTypeList.firstWhere(
              (item) => item.name == typeController.text,
              orElse: () => FieldTypeModel());
          final postTypeId = selectedPostType.id;

          final post = PostModel(
              location: locationController.text,
              fieldName: PostType(fieldName: fieldController.text).fieldName,
              fieldId: fieldId.toString(),
              postTypeId: postTypeId.toString(),
              postType: PostType(type: typeController.text),
              createdAt: DateTime.now(),
              autoDeleteDate: _deleteDate ?? DateTime.now(),
              // autoDeleteDate : _isAutoDeleteEnabled,
              thumbnail: selectedFile?.path ?? '',
              description: descriptionController.text ?? '',
              title: PostType(fieldName: fieldController.text).fieldName);
          Get.to(PreviewPostPage(
            post: post,
          ));
        },
        child: Text(
          'Next',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: whiteColor),
        ),
      ),
    );
  }

  Future<void> _pickDate(
      BuildContext context, Function(DateTime) onDatePicked) async {
    // Pick a date
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // Pick a time
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        // Combine date and time into a DateTime object
        final combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Return the combined DateTime
        onDatePicked(combinedDateTime);
      }
    }
  }
}
