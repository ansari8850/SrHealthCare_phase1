import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sr_health_care/Controller/save_post_controller.dart';

final savepostController = SavePostController.instance;

class SaveButton extends StatefulWidget {
  const SaveButton({
    super.key,
    required this.isSaved,
    required this.postId,
    this.layoutType = Axis.horizontal,
  });

  final bool isSaved;
  final int postId;
  final Axis layoutType;

  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  late final SavePostController _savePostController;

  @override
  void initState() {
    super.initState();
    _savePostController = Get.find<SavePostController>();
  }

  @override
  @override
  Widget build(BuildContext context) {
    bool isSaved = _savePostController.isPostSaved(widget.postId);

    return InkWell(
      onTap: () async {
        final controller = Get.find<SavePostController>();
        // await _savePostController.toggleSave(
        //   widget.postId,
        //   isSaved: isSaved,
        //   onStateChange: () {
        //     setState(() {});
        //   },
        // );
        await controller.toggleSave(widget.postId,
            isSaved: controller.isPostSaved(widget.postId), onStateChange: () {
          setState(() {});
        });
      },
      child: widget.layoutType == Axis.horizontal
          ? Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundColor: const Color(0xffBAF0F4).withOpacity(.4),
                  child: Image.asset(
                    isSaved
                        ? 'assets/myfeed/save.png'
                        : 'assets/homepage/save.png',
                    height: 15,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  isSaved ? 'Unsave' : 'Save',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff6656E0),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Image.asset(
                  isSaved
                      ? 'assets/myfeed/save.png'
                      : 'assets/homepage/save.png',
                  height: 18,
                ),
                const SizedBox(height: 5),
                Text(
                  isSaved ? 'Unsave' : 'Save',
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
    );
  }
}
