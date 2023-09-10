import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pets_app/constants/color_constants.dart';
import 'package:pets_app/constants/string_constants.dart';
import 'package:pets_app/models/pet/pet.dart';
import 'package:pets_app/presentation/screens/pets/pet_details/pet_details_controller.dart';
import 'package:pets_app/presentation/screens/pets/pet_details/widgets/RowText.dart';
import 'package:pets_app/presentation/widgets/buttons/primary_button.dart';
import 'package:pets_app/styles/text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class PetDetailsScreen extends StatelessWidget {
  final Pet pet;

  const PetDetailsScreen({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PetDetailsController>(
        init: PetDetailsController(),
        builder: (_) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    // title: Text(pet.name),
                    background: CachedNetworkImage(
                      imageUrl: pet.image,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pet.name,
                              style: AppTextStyles.bold(fontSize: 22),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              pet.description,
                              style: AppTextStyles.regular(fontSize: 15),
                            ),
                            const SizedBox(height: 8),
                            RowText(
                                label: StringConstants.category,
                                value: pet.category),
                            const SizedBox(height: 8),
                            RowText(
                                label: StringConstants.color, value: pet.color),
                            const SizedBox(height: 8),
                            RowText(label: StringConstants.age, value: pet.age),
                            const SizedBox(height: 8),
                            RowText(
                                label: StringConstants.ownerName,
                                value: pet.ownerName),
                            const SizedBox(height: 8),
                            RowText(
                                label: StringConstants.ownerContact,
                                value: pet.ownerContactNumber),
                            const SizedBox(height: 8),
                            RowText(
                                label: StringConstants.address,
                                value:
                                    '${pet.address?.streetNumber ?? ''} ${pet.address?.city ?? ''}, ${pet.address?.state ?? ''}, ${pet.address?.country ?? ''}'),
                            const SizedBox(height: 30),
                            Divider(color: Colors.grey.withOpacity(0.14)),
                            const SizedBox(height: 30),
                            Center(
                              child: Text(
                                StringConstants.wantToBuyOrAdopt,
                                style: AppTextStyles.light(),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: GestureDetector(
                                onTap: () =>
                                    _onContactOwnerTap(pet.ownerContactNumber),
                                child: Text(
                                  StringConstants.contactOwner,
                                  style: AppTextStyles.medium(
                                      color: ColorConstants.primaryColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: PrimaryButton(
              text: StringConstants.addToFav,
              onPressed: () => _.addToFavourite(pet),
              height: 60,
              isLoading: _.isLoading,
            ),
          );
        });
  }

  void _onContactOwnerTap(String contact) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: contact,
    );
    await launchUrl(launchUri);
  }
}
