import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/common/navigation/navigation.dart';
import 'package:pets_app/common/utils/utils.dart';
import 'package:pets_app/data/local/preference.dart';
import 'package:pets_app/data/network/firebase/auth_repository.dart';
import 'package:pets_app/data/network/firebase/firestore_repository.dart';
import 'package:pets_app/presentation/widgets/navbar/app_navbar.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authRepository = FirebaseAuthRepository();
  final firestoreRepository = FirestoreRepository();

  Future<void> login() async {
    // Get user input data from text controllers
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    // Show loading indicator
    Utils.showLoading('Signing user');

    // Sign in the user with email and password
    final response =
        await authRepository.signInWithEmailAndPassword(email, password);

    if (response.isError) {
      // If there is an authentication error, show an error message
      Get.back();
      Utils.showErrorSnackBar('Authentication Error', response.error!);
    } else {
      // Retrieve user details from Firestore by email
      final userDetails =
          await firestoreRepository.getUserDetailsByEmail(email);

      if (userDetails.isError) {
        // If there is an error getting user details, show an error message
        Get.back();
        Utils.showErrorSnackBar('User Error', userDetails.error!);
      } else {
        // Save user details to local storage
        await Preference.setUserJson(userDetails.data);
        Get.back();

        // Navigate to the main application screen
        Navigation.navigateOffAllRightToLeft(const AppNavBar());
      }
    }
  }

  Future<void> resetPassword() async {
    final String email = emailController.text.trim();

    Utils.showLoading('Resetting password');

    final response = await authRepository.resetPassword(email);

    Get.back();

    if (response.isSuccess) {
      Utils.showSuccessSnackBar(
        'Password Reset',
        response.data,
      );
    } else {
      Utils.showErrorSnackBar('Password Reset Error', response.error!);
    }
  }

  @override
  void onClose() {
    // emailController.dispose();
    // passwordController.dispose();
    super.onClose();
  }
}
