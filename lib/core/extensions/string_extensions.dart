import 'package:easy_localization/easy_localization.dart';

import '../constants/app_strings.dart';

extension StringExtensions on String {
  /// Replaces placeholders with values provided in [params].
  /// Placeholders should be in the format `{key}`.
  String requestParams(Map<String, dynamic> params) {
    final formattedString = "$this \n$params";

    return formattedString;
  }

  String capitalizeFirst() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}

extension StringCasingExtension on String {
  String capitalizeSentence() {
    if (trim().isEmpty) return this;
    final cleaned = replaceAll('_', ' ');
    return cleaned[0].toUpperCase() + cleaned.substring(1);
  }
}

extension StringNumberExtraction on dynamic {
  String getPackageMonths() {
    if (this.contains("monthly")) {
      return AppStrings.month.tr();
    } else if (this.contains("yearly")) {
      return AppStrings.year.tr();
    } else {
      return "";
    }
  }

  String getPackageName() {
    if (this.contains("monthly")) {
      return AppStrings.monthlyPlan.tr();
    } else if (this.contains("yearly")) {
      return AppStrings.yearlyPlan.tr();
    } else {
      return AppStrings.free.tr();
    }
  }
}
