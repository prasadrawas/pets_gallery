import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:pets_app/presentation/screens/home/home_screen.dart';
import 'package:pets_app/presentation/screens/nearby/nearby_screen.dart';
import 'package:pets_app/presentation/screens/profile/profile_screen.dart';

class NavBarController extends GetxController {
  int currentIndex = 0;
  final List<Widget> pages = [
    const HomeScreen(),
    const NearbyScreen(),
    const ProfileScreen(),
  ];

  void updatePage(int index) {
    if (index >= 0 && index <= 2) {
      currentIndex = index;
    }
    update();
  }

  bool doubleBackToExitPressedOnce = false;

  bool onBackPressed() {
    if (currentIndex > 0) {
      currentIndex = 0;
      update();
      return false;
    } else {
      if (doubleBackToExitPressedOnce) {
        // This is the second back press within 2 seconds
        return true; // Exit the app
      }

      // Show a toast message
      Fluttertoast.showToast(msg: 'Press back to exit');

      doubleBackToExitPressedOnce = true;

      // Reset the flag after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        doubleBackToExitPressedOnce = false;
      });

      return false;
    }
  }
}
