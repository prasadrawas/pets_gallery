import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pets_app/common/utils/utils.dart';
import 'package:pets_app/common/utils/validator.dart';
import 'package:pets_app/constants/app_constants.dart';
import 'package:pets_app/constants/string_constants.dart';
import 'package:pets_app/models/pet/pet.dart';
import 'package:pets_app/presentation/widgets/appbar/custom_appbar.dart';
import 'package:pets_app/presentation/widgets/buttons/primary_button.dart';
import 'package:pets_app/presentation/widgets/dropdown/custom_dropdown.dart';
import 'package:pets_app/presentation/widgets/form_field/primary_form_field.dart';
import 'package:pets_app/styles/text_styles.dart';

import 'add_pet_controller.dart';

class AddPetScreen extends StatefulWidget {
  final Pet? pet;
  const AddPetScreen({Key? key, this.pet}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddPetScreenState createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _petController = AddPetController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPetController>(
      init: _petController,
      initState: (_) {
        _petController.setPetDetails(widget.pet);
      },
      builder: (_) {
        return Scaffold(
          appBar: CustomAppBar(
              title: widget.pet == null
                  ? StringConstants.addPet
                  : StringConstants.updatePet),
          body: LayoutBuilder(
            builder: (context, constraints) {
              final isSmallScreen = constraints.maxWidth < 600;
              return _buildFormWidget(_, isSmallScreen);
            },
          ),
        );
      },
    );
  }

  Padding _buildFormWidget(AddPetController _, bool isSmallScreen) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: isSmallScreen ? double.infinity : 450,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    StringConstants.pleaseFillDetails,
                    style: AppTextStyles.light(),
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () => showImagePickerBottomSheet(_),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        height: 120,
                        width: 120,
                        color: Colors.grey[200],
                        child: _.selectedImage == null && widget.pet != null
                            ? CachedNetworkImage(
                                imageUrl: widget.pet!.image,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              )
                            : (_.selectedImage == null
                                ? const Center(
                                    child: Icon(Icons.image, size: 28))
                                : Image.file(
                                    File(_.selectedImage!.path),
                                    fit: BoxFit.cover,
                                  )),
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  // Dropdown for selecting pet category
                  CustomDropDown<String>(
                    labelText: StringConstants.category,
                    prefixIcon: const Icon(Icons.category, size: 16),
                    value: _.selectedCategory,
                    items: AppConstants.petCategories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(
                          category,
                          style: AppTextStyles.regular(),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      _.categoryController.text = value ?? '';
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a pet category';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
                  // Form Fields
                  PrimaryFormField(
                    controller: _.nameController,
                    hint: StringConstants.name,
                    prefixIcon: const Icon(Icons.pets, size: 16),
                    validatorFunction: Validator.validateName,
                    keyboardType: TextInputType.text,
                  ),
                  PrimaryFormField(
                    controller: _.descriptionController,
                    hint: StringConstants.description,
                    prefixIcon: const Icon(Icons.description, size: 16),
                    validatorFunction: Validator.validateDescription,
                    keyboardType: TextInputType.text,
                    maxLines: 3,
                  ),
                  PrimaryFormField(
                    controller: _.colorController,
                    hint: StringConstants.color,
                    prefixIcon: const Icon(Icons.color_lens, size: 16),
                    validatorFunction: Validator.validateColor,
                    keyboardType: TextInputType.text,
                  ),
                  PrimaryFormField(
                    controller: _.ageController,
                    hint: StringConstants.age,
                    prefixIcon: const Icon(Icons.calendar_today, size: 16),
                    validatorFunction: Validator.validateAge,
                    keyboardType: TextInputType.text,
                  ),
                  PrimaryFormField(
                    controller: _.ownerNameController,
                    hint: StringConstants.ownerName,
                    prefixIcon: const Icon(Icons.person, size: 16),
                    validatorFunction: Validator.validateFullName,
                    keyboardType: TextInputType.text,
                  ),
                  PrimaryFormField(
                    controller: _.ownerContactNumberController,
                    hint: StringConstants.ownerContact,
                    prefixIcon: const Icon(Icons.phone, size: 16),
                    validatorFunction: Validator.validatePhone,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                  ),

                  const SizedBox(height: 25),

                  // Submit Button
                  PrimaryButton(
                    text: widget.pet == null
                        ? StringConstants.addPet
                        : StringConstants.updatePet,
                    onPressed: () => _onSubmit(_),
                    borderRadius: 100,
                    // isLoading: _.isLoading,
                  ),
                  const SizedBox(height: 10),

                  if (widget.pet != null)
                    PrimaryButton(
                      backgroundColor: Colors.red,
                      text: StringConstants.deletePet,
                      onPressed: () => _onDelete(_),
                      borderRadius: 100,
                      // isLoading: _.isLoading,
                    ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit(AddPetController _) {
    Utils.hideKeyboard(context);
    if (_formKey.currentState!.validate()) {
      _.savePet(widget.pet);
    }
  }

  void _onDelete(AddPetController _) {
    Utils.hideKeyboard(context);
    _.deletePet(widget.pet?.id);
  }

  Future<void> showImagePickerBottomSheet(AddPetController _) async {
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
                _.pickImageFrom(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                Get.back();
                _.pickImageFrom(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }
}
