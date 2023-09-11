import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/constants/app_constants.dart';
import 'package:pets_app/constants/string_constants.dart';
import 'package:pets_app/models/pet/pet.dart';
import 'package:pets_app/presentation/screens/home/home_controller.dart';
import 'package:pets_app/presentation/screens/home/widgets/category_button.dart';
import 'package:pets_app/presentation/screens/pets/pet_details/pet_details_screen.dart';
import 'package:pets_app/presentation/widgets/appbar/custom_appbar.dart';
import 'package:pets_app/presentation/widgets/pet/pet_card.dart';
import 'package:pets_app/styles/text_styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (_) {
        return Scaffold(
          appBar: CustomAppBar(
            title: StringConstants.home,
            subTitle:
                '${_.user?.address?.state ?? ''}, ${_.user?.address?.city ?? ''} ${_.user?.address?.streetNumber ?? ''}',
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildCategories(_),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(StringConstants.results,
                        style: AppTextStyles.medium(fontSize: 18)),
                  ),
                ),
                _buildResults(_),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildResults(HomeController _) {
    return LayoutBuilder(
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
          stream: _.petsQuery?.snapshots(),
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
                ),
              );
            }

            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  StringConstants.noPetsFound,
                  style: AppTextStyles.light(),
                ),
              );
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
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final data = snapshot.data!.docs[index];
                var petData = Pet.fromJson(data.data() as Map<String, dynamic>);
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
    );
  }

  Column _buildCategories(HomeController _) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(StringConstants.categories,
                style: AppTextStyles.medium(fontSize: 18)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: SizedBox(
            height: 35,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: AppConstants.petCategories.length + 1,
              itemBuilder: (context, index) {
                final category = index == 0
                    ? StringConstants.all
                    : AppConstants.petCategories[index - 1];
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: CategoryButton(
                    category: category,
                    onPressed: (String s) {
                      _.updateQuery(s);
                    },
                    selected: _.selectedCategory,
                  ),
                );
              },
            ),
          ),
        ),
      ],
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
