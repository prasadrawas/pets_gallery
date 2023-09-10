import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pets_app/constants/firebase_constants.dart';
import 'package:pets_app/data/local/preference.dart';

class MyPetsController extends GetxController {
  final myPetsCollection = FirebaseFirestore.instance
      .collection(FirebaseConstants.petsCollection)
      .where(
        'createdBy',
        isEqualTo: Preference.getUser()!.id,
      );
}
