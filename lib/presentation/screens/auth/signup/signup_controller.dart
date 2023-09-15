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
  // Text editing controllers for user input fields
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Repositories for authentication and Firestore interactions
  final authRepository = FirebaseAuthRepository();
  final firestoreRepository = FirestoreRepository();

  // Function to sign up a user
  Future<void> signUp() async {
    // Extract user input data from text controllers
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();

    // Show a loading indicator
    Utils.showLoading('Registering user');

    // Sign up the user with email and password
    final signUpResult =
        await authRepository.signUpWithEmailAndPassword(email, password);

    // Hide the loading indicator
    Get.back();

    // Check if there was an error during sign up
    if (signUpResult.isError) {
      // Show an error message if there was an error
      Utils.showErrorSnackBar('Signup Error', signUpResult.error);
      return; // Exit the function early
    }

    // Create user details object
    final userDetails = AppUser(
      fullName: name,
      phone: phone,
      email: email,
    );

    // Save user details to Firestore
    final saveUserResult = await firestoreRepository.saveUser(userDetails);

    // Hide the loading indicator again
    Get.back();

    // Check if there was an error while saving user details
    if (saveUserResult.isError) {
      // Show an error message if there was an error
      Utils.showErrorSnackBar('Save Error', saveUserResult.error);
    } else {
      // Save user details to local storage
      await Preference.setUserJson(userDetails);

      // Navigate to the main application screen
      Navigation.navigateOffAllRightToLeft(const AppNavBar());
    }
  }

  @override
  void onClose() {
    // Dispose of text editing controllers
    // nameController.dispose();
    // emailController.dispose();
    // phoneController.dispose();
    // passwordController.dispose();
    // confirmPasswordController.dispose();
    super.onClose();
  }
}
