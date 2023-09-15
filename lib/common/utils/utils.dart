import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pets_app/constants/string_constants.dart';
import 'package:pets_app/presentation/widgets/dialogs/loading_dialog.dart';
import 'package:pets_app/styles/text_styles.dart';

class Utils {
  static bool doubleBackToExitPressedOnce = false;

  static bool onBackPressed() {
    if (doubleBackToExitPressedOnce) {
      // This is the second back press within 2 seconds
      return true; // Exit the app
    }

    // Show a toast message
    Fluttertoast.showToast(msg: 'Press back to exit');

    doubleBackToExitPressedOnce = true;

    // Reset the flag after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      doubleBackToExitPressedOnce = false;
    });

    return false;
  }

  static void hideKeyboard(BuildContext context) {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static Future<bool> isDeviceConnectedToInternet(
      {bool showAlert = false}) async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      if (showAlert) {
        Get.defaultDialog(
          title: StringConstants.noConnection,
          content: Text(
            StringConstants.pleaseCheckConnection,
            style: AppTextStyles.light(),
          ),
          textConfirm: StringConstants.ok,
          onConfirm: () => Get.back(),
        );
      }
      return false;
    }

    return true;
  }

  static void showErrorSnackBar(String error, String errorDesc) {
    Get.snackbar(
      error,
      errorDesc,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  static void showSuccessSnackBar(String message, String messageDesc) {
    Get.snackbar(
      message,
      messageDesc,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  static void showLoading(String s) {
    Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(height: 0, fontSize: 0),
      content: LoadingDialog(message: s),
      barrierDismissible: false,
    );
  }

  static void showListSelectDialog(String s) {
    Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(height: 0, fontSize: 0),
      content: LoadingDialog(message: s),
      barrierDismissible: false,
    );
  }
}
