import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/common/navigation/navigation.dart';
import 'package:pets_app/common/utils/utils.dart';
import 'package:pets_app/data/local/preference.dart';
import 'package:pets_app/data/network/firebase/auth_repository.dart';
import 'package:pets_app/data/network/firebase/firestore_repository.dart';
import 'package:pets_app/models/user/app_user.dart';
import 'package:pets_app/presentation/widgets/navbar/app_navbar.dart';

class SignupController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final authRepository = FirebaseAuthRepository();
  final firestoreRepository = FirestoreRepository();

  Future<void> signUp() async {
    // Get user input data from text controllers
    final String name = nameController.text.trim();
    final String email = emailController.text.trim();
    final String phone = phoneController.text.trim();
    final String password = passwordController.text.trim();

    // Show loading indicator
    Utils.showLoading('Register user');

    // Sign up the user with email and password
    final response =
        await authRepository.signUpWithEmailAndPassword(email, password);

    if (response.isError) {
      // If there is an error during sign up, show an error message
      Get.back();
      Utils.showErrorSnackBar('Signup Error', response.error);
    } else {
      final userDetails = AppUser(
        fullName: name,
        phone: phone,
        email: email,
        // address: address.data,
      );

      // Save user details to Firestore
      final savedUser = await firestoreRepository.saveUser(userDetails);

      Get.back();

      if (savedUser.isError) {
        // If there is an error saving user details, show an error message
        Utils.showErrorSnackBar('Save Error', savedUser.error);
      } else {
        // Save user details to local storage
        await Preference.setUserJson(userDetails);

        // Navigate to the main application screen
        Navigation.navigateOffAllRightToLeft(const AppNavBar());
      }
    }
  }

  @override
  void onClose() {
    // nameController.dispose();
    // emailController.dispose();
    // phoneController.dispose();
    // passwordController.dispose();
    // confirmPasswordController.dispose();
    super.onClose();
  }
}
