import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class FilePickerService {
  static final FilePickerService _instance = FilePickerService._internal();
  FilePickerService._internal();
  factory FilePickerService() => _instance;

  /// Pick image from gallery
  Future<File?> pickPdfFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, // Custom type to pick specific file types
        allowedExtensions: ['pdf'], // Only allow PDF files
      );

      if (result != null) {
        File file = File(result.files.single.path!);
        return file;
      } else {
        // User canceled the picker
      }
    } catch (e) {
      log('Error picking image from gallery: $e');
      return null;
    }
    return null;
  }
}
