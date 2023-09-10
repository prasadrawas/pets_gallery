import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Navigation {
  static void navigateTo(
    Widget screen, {
    int transitionDuration = 350,
    bool opaque = true,
  }) {
    Get.to(
      () => screen,
      transition: Transition.cupertino,
      duration: Duration(milliseconds: transitionDuration),
      opaque: opaque,
    );
  }

  static void navigateToFade(
    Widget screen, {
    int transitionDuration = 350,
    bool opaque = true,
  }) {
    Get.to(
      () => screen,
      transition: Transition.fade,
      duration: Duration(milliseconds: transitionDuration),
      opaque: opaque,
    );
  }

  static void navigateToLeftToRight(
    Widget screen, {
    int transitionDuration = 350,
    bool opaque = true,
  }) {
    Get.to(
      () => screen,
      transition: Transition.leftToRight,
      duration: Duration(milliseconds: transitionDuration),
      opaque: opaque,
    );
  }

  static void navigateOffAllRightToLeft(
    Widget screen, {
    int transitionDuration = 350,
    bool opaque = true,
  }) {
    Get.offAll(
      () => screen,
      transition: Transition.rightToLeft,
      duration: Duration(milliseconds: transitionDuration),
      opaque: opaque,
    );
  }

  static void navigateToRightToLeft(
    Widget screen, {
    int transitionDuration = 350,
    bool opaque = true,
  }) {
    Get.to(
      () => screen,
      transition: Transition.rightToLeft,
      duration: Duration(milliseconds: transitionDuration),
      opaque: opaque,
    );
  }

  static void navigateToUpToDown(
    Widget screen, {
    int transitionDuration = 350,
    bool opaque = true,
  }) {
    Get.to(
      () => screen,
      transition: Transition.upToDown,
      duration: Duration(milliseconds: transitionDuration),
      opaque: opaque,
    );
  }

  static void navigateToDownToUp(
    Widget screen, {
    int transitionDuration = 350,
    bool opaque = true,
  }) {
    Get.to(
      () => screen,
      transition: Transition.downToUp,
      duration: Duration(milliseconds: transitionDuration),
      opaque: opaque,
    );
  }

  static void navigateOffAllDownToUp(
    Widget screen, {
    int transitionDuration = 350,
    bool opaque = false,
  }) {
    Get.to(
      () => screen,
      transition: Transition.downToUp,
      duration: Duration(milliseconds: transitionDuration),
      opaque: opaque,
    );
  }
}
