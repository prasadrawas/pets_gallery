import 'package:flutter/material.dart';
import 'package:pets_app/common/navigation/navigation.dart';
import 'package:pets_app/constants/string_constants.dart';
import 'package:pets_app/presentation/screens/splash/splash_screen.dart';
import 'package:pets_app/styles/text_styles.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.signal_wifi_off,
              size: 100.0,
              color: Colors.grey,
            ),
            const SizedBox(height: 20.0),
            Text(
              StringConstants.noConnection,
              style: AppTextStyles.bold(color: Colors.grey),
            ),
            const SizedBox(height: 10.0),
            Text(
              StringConstants.pleaseCheckConnection,
              textAlign: TextAlign.center,
              style: AppTextStyles.light(color: Colors.grey),
            ),
            const SizedBox(height: 20.0), // Add spacing between text and button
            ElevatedButton(
              onPressed: () {
                Navigation.navigateOffAllRightToLeft(const SplashScreen());
              },
              child: const Text(
                StringConstants.retry,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
