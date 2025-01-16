import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static final ImagePickerService _instance = ImagePickerService._internal();
  ImagePickerService._internal();
  factory ImagePickerService() => _instance;

  final ImagePicker _picker = ImagePicker();

  /// Pick image from gallery
  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? response = await _picker. pickImage(
        source: ImageSource.gallery,
        // maxWidth: 400,
      );
      return response != null ? File(response.path) : null;
    } catch (e) {
      print('Error picking image from gallery: $e');
      return null;
    }
  }
   /// Pick image from gallery
  Future<File?> pickVideoFromGallery() async {
    try {
      final XFile? response = await _picker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: Duration(minutes: 2)
        // maxWidth: 400,
      );
      return response != null ? File(response.path) : null;
    } catch (e) {
      print('Error picking image from gallery: $e');
      return null;
    }
  }

  /// Pick image from camera
  Future<File?> pickImageFromCamera() async {
    try {
      final XFile? response = await _picker.pickImage(
        source: ImageSource.camera,
        // maxWidth: 400,
      );
      return response != null ? File(response.path) : null;
    } catch (e) {
      print('Error picking image from camera: $e');
      return null;
    }
  }
}
