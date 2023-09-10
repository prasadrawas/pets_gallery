import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pets_app/constants/color_constants.dart';
import 'package:pets_app/constants/string_constants.dart';
import 'package:pets_app/presentation/widgets/navbar/navbar_controller.dart';

class AppNavBar extends StatefulWidget {
  const AppNavBar({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AppNavBarState createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(
        init: NavBarController(),
        builder: (_) {
          return WillPopScope(
            onWillPop: () async {
              return _.onBackPressed();
            },
            child: Scaffold(
              body: _.pages[_.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                selectedItemColor: ColorConstants.primaryColor,
                type: BottomNavigationBarType.fixed,
                currentIndex: _.currentIndex,
                onTap: _.updatePage,
                items: [
                  BottomNavigationBarItem(
                    icon: _.currentIndex == 0
                        ? const Icon(
                            Icons.home,
                          )
                        : const Icon(
                            Icons.home_outlined,
                          ),
                    label: StringConstants.home,
                  ),
                  BottomNavigationBarItem(
                    icon: _.currentIndex == 1
                        ? const Icon(
                            Icons.near_me,
                          )
                        : const Icon(
                            Icons.near_me_outlined,
                          ),
                    label: StringConstants.nearbyPets,
                  ),
                  BottomNavigationBarItem(
                    icon: _.currentIndex == 2
                        ? const Icon(
                            Icons.account_circle,
                          )
                        : const Icon(
                            Icons.account_circle_outlined,
                          ),
                    label: StringConstants.profile,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
