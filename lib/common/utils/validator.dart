import 'package:pets_app/constants/regex_constants.dart';

class Validator {
  // Error messages
  static const String emailRequired = 'Email is required';
  static const String invalidEmailFormat = 'Invalid email format';
  static const String phoneRequired = 'Phone number is required';
  static const String invalidPhoneFormat = 'Invalid phone number format';
  static const String fullNameRequired = 'Full name is required';
  static const String invalidFullNameFormat = 'Invalid full name format';
  static const String strongPasswordRequired = 'Password is required';
  static const String invalidStrongPasswordFormat =
      'Password must be at least 6 characters long';
  static const String normalPasswordRequired = 'Password is required';
  static const String invalidNormalPasswordFormat =
      'Password must be at least 6 characters long';

  static const String fieldRequired = 'This field is required';
  static const String invalidFormat = 'Invalid format';

  // Validate email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return emailRequired;
    }
    final RegExp emailRegex = RegExp(RegexConstants.emailRegex);
    if (!emailRegex.hasMatch(value)) {
      return invalidEmailFormat;
    }
    return null;
  }

  // Validate phone number
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return phoneRequired;
    }
    final RegExp phoneRegex = RegExp(RegexConstants.phoneRegex);
    if (!phoneRegex.hasMatch(value)) {
      return invalidPhoneFormat;
    }
    return null;
  }

  // Validate full name
  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return fullNameRequired;
    }
    final RegExp fullNameRegex = RegExp(RegexConstants.fullNameRegex);
    if (!fullNameRegex.hasMatch(value)) {
      return invalidFullNameFormat;
    }
    return null;
  }

  // Validate strong password
  static String? validateStrongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return strongPasswordRequired;
    }
    final RegExp strongPasswordRegex =
        RegExp(RegexConstants.sixCharacterPasswordRegex);
    if (!strongPasswordRegex.hasMatch(value)) {
      return invalidStrongPasswordFormat;
    }
    return null;
  }

  // Validate normal password
  static String? validateNormalPassword(String? value) {
    if (value == null || value.isEmpty) {
      return normalPasswordRequired;
    }

    return null;
  }

  // Validator for name (Alphabetic characters only, allows spaces)
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return fieldRequired;
    }
    final RegExp nameRegex = RegExp(RegexConstants.nameRegex);
    if (!nameRegex.hasMatch(value)) {
      return invalidFormat;
    }
    return null;
  }

  // Validator for description (Alphanumeric characters, spaces, and special characters)
  static String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return fieldRequired;
    }
    final RegExp descriptionRegex = RegExp(RegexConstants.descriptionRegex);
    if (!descriptionRegex.hasMatch(value)) {
      return invalidFormat;
    }
    return null;
  }

  // Validator for color (Alphanumeric characters and spaces)
  static String? validateColor(String? value) {
    if (value == null || value.isEmpty) {
      return fieldRequired;
    }
    final RegExp colorRegex = RegExp(RegexConstants.colorRegex);
    if (!colorRegex.hasMatch(value)) {
      return invalidFormat;
    }
    return null;
  }

  // Validator for age (Positive whole numbers only)
  static String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return fieldRequired;
    }
    return null;
  }
}
