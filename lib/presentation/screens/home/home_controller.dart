import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/common/utils/location_handler.dart';
import 'package:pets_app/common/utils/utils.dart';
import 'package:pets_app/constants/firebase_constants.dart';
import 'package:pets_app/constants/string_constants.dart';
import 'package:pets_app/data/local/preference.dart';
import 'package:pets_app/data/network/firebase/firestore_repository.dart';
import 'package:pets_app/styles/text_styles.dart';

class HomeController extends GetxController {
  final firestoreRepository = FirestoreRepository();
  String selectedCategory = 'All'; // Default category
  var user = Preference.getUser(); // Current user
  var petsQuery; // Query for fetching pets

  @override
  void onInit() {
    super.onInit();
    // Fetch the user's address when the screen is loaded
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getAddress();
      updateQuery('All'); // Fetch all pets by default
    });
  }

  // Update the query based on the selected category
  void updateQuery(String category) {
    selectedCategory = category;
    petsQuery =
        FirebaseFirestore.instance.collection(FirebaseConstants.petsCollection);

    if (selectedCategory != 'All') {
      petsQuery = petsQuery?.where('category', isEqualTo: selectedCategory);
    }

    update(); // Notify the UI to update
  }

  // Fetch the user's address
  void getAddress() async {
    if (user?.address == null) {
      // You might want to add a condition here to check if location permissions are granted
      Utils.showLoading('Fetching address');

      final result = await LocationHandler.getCurrentAddress();
      Get.back(); // Close the loading dialog

      if (result.isError) {
        // Handle address retrieval error
        Get.defaultDialog(
          title: 'Permission required',
          middleText: result.error!,
          confirm: TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
              getAddress(); // Retry fetching the address
            },
            child: Text(
              StringConstants.retry,
              style: AppTextStyles.regular(),
            ),
          ),
        );
      } else {
        // Update the user's address and save it
        user = user?.copyWith(id: user?.id, address: result.data);

        if (user != null) {
          final updateUser = await firestoreRepository.saveUser(user);

          if (updateUser.isError) {
            Utils.showErrorSnackBar('Update Error', updateUser.error!);
          } else {
            await Preference.setUserJson(user);
            update(); // Notify the UI to update
          }
        }
      }
    }
  }
}
