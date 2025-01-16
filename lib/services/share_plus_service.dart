import 'package:share_plus/share_plus.dart';

class ShareService {
  /// Shares plain text
  Future<void> shareText(String text) async {
    try {
      await Share.share(text);
    } catch (e) {
      print('Error sharing text: $e');
    }
  }

  /// Shares a file with optional text
  Future<void> shareFile(String filePath, {String? text}) async {
    try {
      await Share.shareXFiles(
        [XFile(filePath)],
        text: text,
      );
    } catch (e) {
      print('Error sharing file: $e');
    }
  }

  /// Shares multiple files with optional text
  Future<void> shareMultipleFiles(List<String> filePaths,
      {String? text}) async {
    try {
      final files = filePaths.map((path) => XFile(path)).toList();
      await Share.shareXFiles(files, text: text);
    } catch (e) {
      print('Error sharing multiple files: $e');
    }
  }
}
