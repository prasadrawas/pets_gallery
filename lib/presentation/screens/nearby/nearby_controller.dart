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

class NearbyController extends GetxController {
  final firestoreRepository = FirestoreRepository();
  var user = Preference.getUser();
  Query<Map<String, dynamic>>? nearbyQuery;

  @override
  void onInit() {
    super.onInit();
    // Fetch nearby pets and the user's address when the screen is loaded
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetchNearbyPets();
      getAddress();
    });
  }

  // Fetch nearby pets based on user's location
  void fetchNearbyPets() {
    if (user?.address != null) {
      nearbyQuery = FirebaseFirestore.instance
          .collection(FirebaseConstants.petsCollection)
          .where(
            FieldPath(const ['address', 'city']),
            isEqualTo: user?.address?.city,
          )
          .where(
            FieldPath(const ['address', 'streetNumber']),
            isEqualTo: user?.address?.streetNumber,
          )
          .where(
            FieldPath(const ['address', 'state']),
            isEqualTo: user?.address?.state,
          );

      update(); // Notify the UI to update
    }
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
        user = user?.copyWith(address: result.data);

        if (user != null) {
          final updateUser = await firestoreRepository.saveUser(user);

          if (updateUser.isError) {
            Utils.showErrorSnackBar('Update Error', updateUser.error!);
          } else {
            Preference.setUserJson(user);
          }
        }
      }

      update(); // Notify the UI to update
    }
  }
}
