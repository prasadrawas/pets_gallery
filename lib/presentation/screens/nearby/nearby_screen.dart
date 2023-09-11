import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/constants/string_constants.dart';
import 'package:pets_app/models/pet/pet.dart';
import 'package:pets_app/presentation/screens/nearby/nearby_controller.dart';
import 'package:pets_app/presentation/screens/pets/pet_details/pet_details_screen.dart';
import 'package:pets_app/presentation/widgets/appbar/custom_appbar.dart';
import 'package:pets_app/presentation/widgets/pet/pet_card.dart';
import 'package:pets_app/styles/text_styles.dart';

class NearbyScreen extends StatefulWidget {
  const NearbyScreen({Key? key}) : super(key: key);

  @override
  State<NearbyScreen> createState() => _NearbyScreenState();
}

class _NearbyScreenState extends State<NearbyScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NearbyController>(
      init: NearbyController(),
      builder: (_) {
        return Scaffold(
          appBar: CustomAppBar(
            title: StringConstants.nearbyPets,
            subTitle:
                '${_.user?.address?.state ?? ''}, ${_.user?.address?.city ?? ''} ${_.user?.address?.streetNumber ?? ''}',
          ),
          body: Column(
            children: [
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final screenWidth = constraints.maxWidth;
                    int crossAxisCount;

                    if (screenWidth < 600) {
                      crossAxisCount = 2; // Mobile screen
                    } else if (screenWidth < 1200) {
                      crossAxisCount = 3; // Medium screen
                    } else {
                      crossAxisCount = 4; // Large screen
                    }

                    return StreamBuilder<QuerySnapshot>(
                      stream: _.nearbyQuery?.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(strokeWidth: 1),
                          );
                        }

                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              '${StringConstants.error}: ${snapshot.error}',
                              style: AppTextStyles.light(),
                            ),
                          );
                        }

                        if (snapshot.data == null ||
                            snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Text(
                              StringConstants.noPetsFound,
                              style: AppTextStyles.light(),
                            ),
                          );
                        }

                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 14,
                            mainAxisSpacing: 14,
                            childAspectRatio: 0.8,
                          ),
                          padding: const EdgeInsets.all(6),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final data = snapshot.data!.docs[index];
                            var petData = Pet.fromJson(
                                data.data() as Map<String, dynamic>);
                            petData = petData.copyWith(id: data.id);
                            return PetCard(
                              name: petData.name,
                              description: petData.description,
                              imageUrl: petData.image,
                              color: petData.color,
                              age: petData.age,
                              onPressed: () => _onCardPressed(petData),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _onCardPressed(Pet petData) {
    Get.to(
      () => PetDetailsScreen(pet: petData),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 350),
    );
  }
}
