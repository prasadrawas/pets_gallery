import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pets_app/common/utils/utils.dart';
import 'package:pets_app/data/local/preference.dart';
import 'package:pets_app/data/network/firebase/firestore_repository.dart';
import 'package:pets_app/data/network/firebase/storage_repository.dart';
import 'package:pets_app/models/pet/pet.dart';

class AddPetController extends GetxController {
  final storageRepository = FirebaseStorageRepository();
  final firestoreRepository = FirestoreRepository();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final colorController = TextEditingController();
  final ageController = TextEditingController();
  final categoryController = TextEditingController();
  final ownerNameController = TextEditingController();
  final ownerContactNumberController = TextEditingController();
  final user = Preference.getUser();
  XFile? selectedImage;
  String? selectedCategory;

  void setPetDetails(Pet? pet) {
    if (pet != null) {
      selectedCategory = pet.category;
      categoryController.text = selectedCategory ?? 'Dog';
      nameController.text = pet.name;
      descriptionController.text = pet.description;
      colorController.text = pet.color;
      ageController.text = pet.age;
    } else {
      // selectedCategory = AppConstants.petCategories.first;
      // categoryController.text = selectedCategory ?? 'Dog';
      // nameController.text = 'Max';f
      // descriptionController.text =
      //     'Max is a friendly and energetic dog who loves to play fetch and go on long walks.';
      // colorController.text = 'Brown and White';
      // ageController.text = '3 years';
    }
    ownerNameController.text = user?.fullName ?? '';
    ownerContactNumberController.text = user?.phone ?? '';
    update();
  }

  Future<void> showImagePickerBottomSheet() async {
    await Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () async {
                Get.back();
                final imagePicker = ImagePicker();
                final image = await imagePicker.pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  selectedImage = XFile(image.path);
                  update(); // Update the UI to display the selected image
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                Get.back();
                final imagePicker = ImagePicker();
                final image = await imagePicker.pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  selectedImage = XFile(image.path);
                  update(); // Update the UI to display the selected image
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> savePet(Pet? pet) async {
    Utils.showLoading('Saving pet');
    String imageUrl =
        pet?.image ?? ''; // Use pet?.image if available, otherwise empty string

    if (selectedImage != null) {
      final storageResult =
          await storageRepository.uploadImage(File(selectedImage!.path));
      if (storageResult.isError) {
        Get.back();
        Utils.showErrorSnackBar('Upload Error', storageResult.error!);

        return;
      }
      if (imageUrl.isNotEmpty) {
        storageRepository.deleteImage(imageUrl);
      }
      imageUrl = storageResult.data!;
    } else if (pet?.image == null) {
      Get.back();
      Utils.showErrorSnackBar('Image Error', 'Please select an image');

      return;
    }

    final name = nameController.text.trim();
    final description = descriptionController.text.trim();
    final color = colorController.text.trim();
    final age = ageController.text.trim();
    final ownerName = ownerNameController.text.trim();
    final ownerContactNumber = ownerContactNumberController.text.trim();
    final petCategory = categoryController.text.trim();

    try {
      final petData = Pet(
        id: pet?.id,
        name: name,
        image: imageUrl,
        description: description,
        color: color,
        age: age,
        ownerName: ownerName,
        ownerContactNumber: ownerContactNumber,
        createdBy: user?.id ?? '',
        address: user?.address,
        category: petCategory,
      );

      final petResult = await firestoreRepository.savePet(petData);
      Get.back();
      if (petResult.isError) {
        Utils.showErrorSnackBar('Saving Error', petResult.error!);
      } else {
        Get.back();
        Utils.showSuccessSnackBar('Success', petResult.data!);
      }
    } catch (e) {
      Get.back();
      Utils.showErrorSnackBar('Error', 'An error occurred: $e');
    }
  }

  Future<void> deletePet(String? id) async {
    Utils.showLoading('Deleting record');
    firestoreRepository.deletePet(id).then((value) async {
      await Future.delayed(const Duration(seconds: 1));
      Get.back();
      if (value.isError) {
        Utils.showErrorSnackBar('Delete Error', value.error!);
      } else {
        Get.back();
        Utils.showSuccessSnackBar('Delete Success', value.data!);
      }
    });
  }

  @override
  void onClose() {
    // nameController.dispose();
    // descriptionController.dispose();
    // colorController.dispose();
    // ageController.dispose();
    // ownerNameController.dispose();
    // categoryController.dispose();
    // ownerContactNumberController.dispose();
    super.onClose();
  }
}
