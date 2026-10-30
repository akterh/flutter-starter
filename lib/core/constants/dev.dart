import 'package:flutter/foundation.dart';

const bool isDev = false;
const bool isAutoFillUpTextField = isDev && kDebugMode;

String firstName = isAutoFillUpTextField == true ? 'Salman' : '';
String lastName = isAutoFillUpTextField == true ? 'Ahmed' : '';
String email = isAutoFillUpTextField == true ? 'salman@infodigita.com' : '';
String password = isAutoFillUpTextField == true ? '!1Password' : '';
String otp = isAutoFillUpTextField == true ? '111222' : '';
String username = isAutoFillUpTextField == true ? 'username' : '';
String dob = isAutoFillUpTextField == true ? '2004-11-03' : '';
