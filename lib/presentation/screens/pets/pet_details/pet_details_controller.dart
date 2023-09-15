import 'package:get/get.dart';
import 'package:pets_app/common/utils/utils.dart';
import 'package:pets_app/data/local/preference.dart';
import 'package:pets_app/data/network/firebase/firestore_repository.dart';
import 'package:pets_app/models/pet/pet.dart';

class PetDetailsController extends GetxController {
  final firestoreRepository = FirestoreRepository();
  bool isLoading = false;

  // Update the loading status and trigger UI update
  void updateLoading(bool value) {
    isLoading = value;
    update();
  }

  // Add a pet to the user's favorites
  void addToFavourite(Pet pet) async {
    // Get the currently logged-in user
    final user = Preference.getUser();

    // Set loading to true to show a loading indicator
    updateLoading(true);

    // Add the pet to the user's favorites in Firestore
    await firestoreRepository.addToFavorites(user?.id ?? '', pet).then((value) {
      // Set loading back to false once the operation is complete
      updateLoading(false);

      if (value.isError) {
        // Show an error message if there's an error
        Utils.showErrorSnackBar('Favourite Error', value.error!);
      } else {
        // Show a success message if the operation is successful
        Utils.showSuccessSnackBar('Success', value.data!);
      }
    });
  }
}
