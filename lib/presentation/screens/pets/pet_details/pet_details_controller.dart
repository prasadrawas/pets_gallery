import 'package:get/get.dart';
import 'package:pets_app/common/utils/utils.dart';
import 'package:pets_app/data/local/preference.dart';
import 'package:pets_app/data/network/firebase/firestore_repository.dart';
import 'package:pets_app/models/pet/pet.dart';

class PetDetailsController extends GetxController {
  final firestoreRepository = FirestoreRepository();
  bool isLoading = false;

  void updateLoading(bool value) {
    isLoading = value;
    update();
  }

  void addToFavourite(Pet pet) async {
    final user = Preference.getUser();
    updateLoading(true);
    await firestoreRepository.addToFavorites(user?.id ?? '', pet).then((value) {
      updateLoading(false);
      if (value.isError) {
        Utils.showErrorSnackBar('Favourite Error', value.error!);
      } else {
        Utils.showSuccessSnackBar('Success', value.data!);
      }
    });
  }
}
