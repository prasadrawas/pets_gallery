import 'package:get/get.dart';
import 'package:pets_app/common/navigation/navigation.dart';
import 'package:pets_app/common/utils/utils.dart';
import 'package:pets_app/data/local/preference.dart';
import 'package:pets_app/data/network/firebase/auth_repository.dart';
import 'package:pets_app/presentation/screens/auth/login/login_screen.dart';
import 'package:pets_app/presentation/screens/no_connection/no_connection_screen.dart';
import 'package:pets_app/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:pets_app/presentation/widgets/navbar/app_navbar.dart';

class SplashController extends GetxController {
  final authRepository = FirebaseAuthRepository();
  @override
  void onInit() {
    super.onInit();
    checkNetworkAndNavigate();
  }

  Future<void> checkNetworkAndNavigate() async {
    // Check if the device has an internet connection
    final hasNetwork = await Utils.isDeviceConnectedToInternet();

    if (!hasNetwork) {
      // If there's no internet connection, navigate to the NoConnectionScreen
      Navigation.navigateOffAllRightToLeft(const NoConnectionScreen());
      return;
    }

    // Check if the user is logged in and user data is available in preferences
    if (await authRepository.isUserLoggedIn() && Preference.getUser() != null) {
      // If the user is logged in, navigate to the main screen (PersistentNavbar)
      Navigation.navigateOffAllRightToLeft(const AppNavBar());
    } else {
      // If the user is not logged in or no user data is available
      if (Preference.isFirstLaunch()) {
        // If it's the first app launch, navigate to the onboarding screen
        Navigation.navigateOffAllRightToLeft(const OnboardingScreen());
      } else {
        // If it's not the first launch, sign out the user, clear preferences, and navigate to the login screen
        authRepository.signOut();
        Preference.clearPreferences();
        Navigation.navigateOffAllRightToLeft(const LoginScreen());
      }
    }
  }
}
