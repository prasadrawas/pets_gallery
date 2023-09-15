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

  // Set pet details in the form fields for editing or creating a new pet
  void setPetDetails(Pet? pet) {
    if (pet != null) {
      selectedCategory = pet.category;
      categoryController.text = selectedCategory ?? 'Dog';
      nameController.text = pet.name;
      descriptionController.text = pet.description;
      colorController.text = pet.color;
      ageController.text = pet.age;
    } else {
      // Initialize fields with default values if creating a new pet
      // selectedCategory = AppConstants.petCategories.first;
      // categoryController.text = selectedCategory ?? 'Dog';
      // nameController.text = 'Max';
      // descriptionController.text =
      //     'Max is a friendly and energetic dog who loves to play fetch and go on long walks.';
      // colorController.text = 'Brown and White';
      // ageController.text = '3 years';
    }
    ownerNameController.text = user?.fullName ?? '';
    ownerContactNumberController.text = user?.phone ?? '';
    update();
  }

  // Pick an image from the gallery or camera
  void pickImageFrom(ImageSource source) async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(source: source);
    if (image != null) {
      selectedImage = XFile(image.path);
      update(); // Update the UI to display the selected image
    }
  }

  // Save pet data to Firestore and handle image upload
  Future<void> savePet(Pet? pet) async {
    Utils.showLoading('Saving pet');
    String imageUrl =
        pet?.image ?? ''; // Use pet?.image if available, otherwise empty string

    if (selectedImage != null) {
      // Handle image upload
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

    // Get data from form fields
    final name = nameController.text.trim();
    final description = descriptionController.text.trim();
    final color = colorController.text.trim();
    final age = ageController.text.trim();
    final ownerName = ownerNameController.text.trim();
    final ownerContactNumber = ownerContactNumberController.text.trim();
    final petCategory = categoryController.text.trim();

    try {
      // Create a Pet object
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

      // Save pet data to Firestore
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

  // Delete a pet record from Firestore
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
    // Dispose of controllers
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
