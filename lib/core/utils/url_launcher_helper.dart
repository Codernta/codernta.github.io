import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Helper to safely launch external URLs and mailto/tel protocols.
class UrlLauncherHelper {
  const UrlLauncherHelper._();

  static Future<bool> launchURL(String urlString) async {
    try {
      final uri = Uri.parse(urlString);
      if (await canLaunchUrl(uri)) {
        return await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        debugPrint('Could not launch url: $urlString');
        return false;
      }
    } catch (e) {
      debugPrint('Error launching url: $e');
      return false;
    }
  }

  static Future<bool> launchEmail(String email) async {
    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'Senior Flutter Developer Opportunity',
      },
    );
    return launchURL(uri.toString());
  }

  static Future<bool> launchWhatsApp(String phone) async {
    final cleaned = phone.replaceAll(RegExp(r'[^0-9]'), '');
    final url = 'https://wa.me/$cleaned';
    return launchURL(url);
  }
}
