import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

import '../app/app_dependency.dart';
import '../app/app_preference.dart';

class UrlHelper {
  // ============ [ Privacy Policy And Terms & Conditions ] ============
  static const String baseUrl = 'https://camerasync.ai';
  static const String privacyPolicyEn = '$baseUrl/privacy-policy/';
  static const String privacyPolicyDe = '$baseUrl/privacy-policy/';
  static const String privacyPolicyIt = '$baseUrl/privacy-policy/';
  static const String privacyPolicyFr = '$baseUrl/privacy-policy/';

  static const String termsAndConditionsEn = '$baseUrl/terms-conditions/';
  static const String termsAndConditionsDe = '$baseUrl/terms-conditions/';
  static const String termsAndConditionsIt = '$baseUrl/terms-conditions/';
  static const String termsAndConditionsFr = '$baseUrl/terms-conditions/';

  // ============ [ Privacy Policy And Terms & Conditions ] ============

  static void openPrivacyPolicy() {
    final preferences = instance.get<AppPreferences>();
    final languageKey = preferences.getLanguage();

    if (languageKey == 'en') navigateToBrowser(privacyPolicyEn);
    if (languageKey == 'de') navigateToBrowser(privacyPolicyDe);
    if (languageKey == 'it') navigateToBrowser(privacyPolicyIt);
    if (languageKey == 'fr') navigateToBrowser(privacyPolicyFr);
  }

  static void openTermsAndConditions() {
    final preferences = instance.get<AppPreferences>();
    final languageKey = preferences.getLanguage();

    if (languageKey == 'en') navigateToBrowser(termsAndConditionsEn);
    if (languageKey == 'de') navigateToBrowser(termsAndConditionsDe);
    if (languageKey == 'it') navigateToBrowser(termsAndConditionsIt);
    if (languageKey == 'fr') navigateToBrowser(termsAndConditionsFr);
  }

  static void navigateToWebView(String title, String url) {
    /*

    GetContext.to(
      StaticWebViewPageScreen(appBarTitle: title, contentDetails: url),
    );

    */
  }

  static Future<void> navigateToBrowser(String url) async {
    try {
      final uri = Uri.parse(url);

      if (!await launchUrl(uri)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      log('UrlHelper:: @navigateToBrowser => $e');
    }
  }
}
