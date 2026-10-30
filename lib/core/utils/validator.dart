import 'package:easy_localization/easy_localization.dart';

import '../constants/app_strings.dart';
import '../constants/strings.dart';

final nameRegExp = RegExp(r"^[a-zA-Z-' ]+$");

class Validator {
  static String? name(String? v) {
    if (v == null || v == '' || v.trim() == '') {
      return AppStrings.firstNameEmptyErr.tr();
    }

/*    if (v.trim() != v) {
      return AppStrings.firstNameLeadingOrTrailingSpaceErr.tr();
    }

    if (!nameRegExp.hasMatch(v)) {
      return AppStrings.firstNameInvalidCharErr.tr();
    }

    if (v.length < 2) return AppStrings.firstNameMinLengthErr.tr();

    if (v.length > 30) return AppStrings.firstNameMaxLengthErr.tr();*/

    return null;
  }


  static String? email(String? v) {
    if (v == null || v == '' || v.trim() == '') {
      return "";
    }

    if (!emailValidatorRegExp.hasMatch(v)) {
      if ((v??"").isNotEmpty||!emailValidatorRegExp.hasMatch(v??"")) {
        return AppStrings.emailInvalidErr.tr();
      }
      return null;
    }
    return null;
  }

  static String? password(String? v) {
    if (v == null || v == '') {
      return AppStrings.passwordInvalidErr.tr();
    }

    if (v.length > 20) return AppStrings.passwordInvalidErr.tr();

    if (v.length < 6) return AppStrings.passwordInvalidErr.tr();

    if (!v.contains(RegExp(r'[A-Z]'))) {
      return AppStrings.passwordInvalidErr.tr();
    }

    if (!v.contains(RegExp(r'[a-z]'))) {
      return AppStrings.passwordInvalidErr.tr();
    }

    if (!v.contains(RegExp(r'[0-9]'))) {
      return AppStrings.passwordInvalidErr.tr();
    }

    if (!v.contains(RegExp(r'[~!@#$%^&*()_+`{}|<>?;:.,=[\]\\/\-]'))) {
      return AppStrings.passwordInvalidErr.tr();
    }

    return null;
  }

  static String? passwordSigIn(String? v) {
    if (v == null || v == '') {
      return AppStrings.passwordInvalidErr.tr();
    }

    return null;
  }


  static String? confirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null ||
        confirmPassword == '' ||
        confirmPassword.trim() == '') {
      return AppStrings.confirmPasswordEmptyErr.tr();
    }

    if (confirmPassword != password) {
      return AppStrings.passwordsDoNotMatchErr.tr();
    }

    return null;
  }


}
