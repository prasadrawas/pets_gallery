import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pets_app/common/navigation/navigation.dart';
import 'package:pets_app/constants/string_constants.dart';
import 'package:pets_app/models/pet/pet.dart';
import 'package:pets_app/presentation/screens/pets/add_pet/add_pet_screen.dart';
import 'package:pets_app/presentation/screens/pets/my_pets/my_pets_controller.dart';
import 'package:pets_app/presentation/widgets/appbar/custom_appbar.dart';
import 'package:pets_app/presentation/widgets/pet/pet_card.dart';
import 'package:pets_app/styles/text_styles.dart';

class MyPetsScreen extends StatelessWidget {
  const MyPetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyPetsController>(
        init: MyPetsController(),
        builder: (_) {
          return Scaffold(
            appBar: const CustomAppBar(
              title: StringConstants.myPets,
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: _.myPetsCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(strokeWidth: 1),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    '${StringConstants.error}: ${snapshot.error}',
                    style: AppTextStyles.light(),
                  ));
                }

                // Check if there are no documents in the collection
                if (snapshot.data?.docs.isEmpty ?? true) {
                  return Center(
                      child: Text(
                    StringConstants.noPetsFound,
                    style: AppTextStyles.light(),
                  ));
                }

                final screenWidth = MediaQuery.of(context).size.width;
                int crossAxisCount = 2; // Default value for small screens

                if (screenWidth < 600) {
                  crossAxisCount = 2; // Mobile screen
                } else if (screenWidth < 1200) {
                  crossAxisCount = 3; // Medium screen
                } else {
                  crossAxisCount = 4; // Large screen
                }

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 0.8,
                  ),
                  padding: const EdgeInsets.all(6),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data!.docs[index];
                    var petData =
                        Pet.fromJson(data.data() as Map<String, dynamic>);
                    petData = petData.copyWith(id: data.id);
                    return PetCard(
                      name: petData.name,
                      description: petData.description,
                      imageUrl: petData.image,
                      color: petData.color,
                      age: petData.age,
                      onPressed: () {
                        Navigation.navigateToRightToLeft(
                          AddPetScreen(pet: petData),
                        );
                      },
                    );
                  },
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigation.navigateToRightToLeft(const AddPetScreen());
              },
              child: const Icon(Icons.add),
            ),
          );
        });
  }
}
