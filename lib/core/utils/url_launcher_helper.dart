import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart' as ul;

/// Helper to safely launch external URLs and mailto/tel protocols.
class UrlLauncherHelper {
  const UrlLauncherHelper._();

  static Future<bool> launchURL(String urlString) async {
    try {
      final uri = Uri.parse(urlString);
      if (await ul.canLaunchUrl(uri)) {
        return await ul.launchUrl(
          uri,
          mode: ul.LaunchMode.externalApplication,
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

  static Future<bool> launchUrl(String urlString) => launchURL(urlString);

  static Future<bool> launchEmail(
    String email, {
    String? subject,
    String? body,
  }) async {
    final queryParams = <String, String>{};
    if (subject != null && subject.isNotEmpty) queryParams['subject'] = subject;
    if (body != null && body.isNotEmpty) queryParams['body'] = body;

    final uri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: queryParams.isNotEmpty ? queryParams : null,
    );
    return launchURL(uri.toString());
  }

  static Future<bool> launchPhone(String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    return launchURL(uri.toString());
  }

  static Future<bool> launchWhatsApp(String phone) async {
    final cleaned = phone.replaceAll(RegExp(r'[^0-9]'), '');
    final url = 'https://wa.me/$cleaned';
    return launchURL(url);
  }
}
