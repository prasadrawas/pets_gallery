import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/constants/asset_constants.dart';
import 'package:pets_app/constants/string_constants.dart';
import 'package:pets_app/presentation/screens/pets/add_pet/add_pet_screen.dart';
import 'package:pets_app/presentation/screens/pets/favourites_pets/favourites_screen.dart';
import 'package:pets_app/presentation/screens/pets/my_pets/my_pets_screen.dart';
import 'package:pets_app/presentation/screens/profile/profile_controller.dart';
import 'package:pets_app/presentation/widgets/appbar/custom_appbar.dart';
import 'package:pets_app/presentation/widgets/list_tile/custom_list_tile.dart';
import 'package:pets_app/styles/text_styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (_) {
          return Scaffold(
            appBar: const CustomAppBar(title: StringConstants.profile),
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    // Profile header with dummy Icon
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(AssetConstants.imgPerson),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${_.user?.fullName}',
                      style: AppTextStyles.medium(fontSize: 18),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_.user?.email}',
                      style: AppTextStyles.light(),
                    ),
                    const SizedBox(height: 15),
                    const Divider(),
                    // My Pets section
                    CustomListTile(
                      leadingIcon: Icons.pets,
                      text: StringConstants.myPets,
                      onTap: _onMyPetsTap,
                    ),
                    // Add pet section
                    CustomListTile(
                      leadingIcon: Icons.add_circle_outlined,
                      text: StringConstants.addPet,
                      onTap: _onAddPetTap,
                    ),
                    // My Favourites section
                    CustomListTile(
                      leadingIcon: Icons.favorite,
                      text: StringConstants.myFavourites,
                      onTap: _onMyFavTap,
                    ),

                    const Divider(),
                    // Logout button
                    CustomListTile(
                      leadingIcon: Icons.exit_to_app,
                      text: StringConstants.logout,
                      onTap: () => _onLogoutTap(_),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _onAddPetTap() {
    Get.to(
      () => const AddPetScreen(),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 350),
    );
  }

  void _onMyPetsTap() {
    Get.to(
      () => const MyPetsScreen(),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 350),
    );
  }

  void _onMyFavTap() {
    Get.to(
      () => const MyFavouritesScreen(),
      transition: Transition.rightToLeft,
      duration: const Duration(milliseconds: 350),
    );
  }

  void _onLogoutTap(ProfileController _) {
    _.logout();
  }
}
