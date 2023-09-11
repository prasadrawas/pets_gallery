import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pets_app/constants/string_constants.dart';
import 'package:pets_app/models/pet/pet.dart';
import 'package:pets_app/presentation/screens/pets/favourites_pets/favourites_controller.dart';
import 'package:pets_app/presentation/widgets/appbar/custom_appbar.dart';
import 'package:pets_app/presentation/widgets/pet/pet_card.dart';
import 'package:pets_app/styles/text_styles.dart';

class MyFavouritesScreen extends StatelessWidget {
  const MyFavouritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavouritesController>(
        init: FavouritesController(),
        builder: (_) {
          return Scaffold(
            appBar: const CustomAppBar(
              title: StringConstants.myFavourites,
            ),
            body: StreamBuilder<QuerySnapshot>(
              stream: _.myFavouritesCollection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(strokeWidth: 1),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    'Error: ${snapshot.error}',
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

                if (screenWidth >= 600 && screenWidth < 900) {
                  crossAxisCount = 3; // Medium-sized screens
                } else if (screenWidth >= 900) {
                  crossAxisCount = 4; // Large screens
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
                    final data = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    var petData = Pet.fromJson(data['petDetails']);
                    petData = petData.copyWith(id: data['petId']);
                    return PetCard(
                      name: petData.name,
                      description: petData.description,
                      imageUrl: petData.image,
                      color: petData.color,
                      age: petData.age,
                    );
                  },
                );
              },
            ),
          );
        });
  }
}
