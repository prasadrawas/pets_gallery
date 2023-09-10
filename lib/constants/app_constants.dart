import 'package:flutter/material.dart';
import 'package:onboarding_intro_screen/onboarding_screen.dart';
import 'package:pets_app/constants/asset_constants.dart';
import 'package:pets_app/constants/string_constants.dart';

class AppConstants {
  static const List<String> petCategories = [
    "Dog",
    "Cat",
    "Fish",
    "Bird",
    "Rabbit",
    "Hamster",
    "Turtle"
  ];

  static List<OnBoardingModel> onBoardingPages = [
    OnBoardingModel(
      image: Image.asset(AssetConstants.imgLogo),
      title: StringConstants.welcomeToPetsGallery,
      body: StringConstants.discoverPets,
    ),
    OnBoardingModel(
      image: Image.asset(AssetConstants.imgLogo),
      title: StringConstants.findYourPerfectCompanion,
      body: StringConstants.diverseRangeOfPets,
    ),
    OnBoardingModel(
      image: Image.asset(AssetConstants.imgLogo),
      title: StringConstants.mobileAppForPetLovers,
      body: StringConstants.exploreAndConnect,
    ),
    OnBoardingModel(
      image: Image.asset(AssetConstants.imgLogo),
      title: StringConstants.joinOurPetCommunity,
      body: StringConstants.connectWithEnthusiasts,
    ),
  ];
}
