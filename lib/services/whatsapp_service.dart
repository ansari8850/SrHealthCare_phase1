import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WhatsAppService {
  static final WhatsAppService _instance = WhatsAppService._internal();

  WhatsAppService._internal();

  factory WhatsAppService() => _instance;

  Future<void> launchWhatsAppCall({
    required String phoneNumber,
    BuildContext? context,
  }) async {
    // WhatsApp URL for direct chat or call
    final String whatsappUrl = 'https://wa.me/$phoneNumber';

    try {
      final Uri uri = Uri.parse(whatsappUrl);

      // Launch the URL externally in WhatsApp
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('Error launching WhatsApp: $e');
      _showSnackBar(context, 'An error occurred while launching WhatsApp.');
    }
  }

  void _showSnackBar(BuildContext? context, String message) {
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
}
