import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/constants/asset_constants.dart';
import 'package:pets_app/constants/string_constants.dart';
import 'package:pets_app/presentation/screens/splash/splash_controller.dart';
import 'package:pets_app/styles/text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (_) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Image.asset(AssetConstants.imgLogo, height: 150)),
              const SizedBox(height: 15),
              Center(
                child: Text(
                  StringConstants.petsGallery,
                  style: AppTextStyles.medium(fontSize: 25),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
