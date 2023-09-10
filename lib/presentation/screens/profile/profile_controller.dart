import 'package:get/get.dart';
import 'package:pets_app/common/navigation/navigation.dart';
import 'package:pets_app/common/utils/utils.dart';
import 'package:pets_app/data/local/preference.dart';
import 'package:pets_app/data/network/firebase/auth_repository.dart';
import 'package:pets_app/presentation/screens/auth/login/login_screen.dart';

class ProfileController extends GetxController {
  final authRepository = FirebaseAuthRepository();
  final user = Preference.getUser();

  void logout() async {
    Utils.showLoading('Signing out');
    await authRepository.signOut();
    await Preference.clearPreferences();
    await Future.delayed(const Duration(seconds: 1));
    Navigation.navigateOffAllRightToLeft(const LoginScreen());
  }
}
