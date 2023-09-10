import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pets_app/common/utils/logger_service.dart';
import 'package:pets_app/constants/firebase_constants.dart';
import 'package:pets_app/models/pet/pet.dart';
import 'package:pets_app/models/response/result.dart';
import 'package:pets_app/models/user/app_user.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Result<AppUser>> saveUser(AppUser? userDetails) async {
    try {
      if (userDetails?.id != null) {
        await _firestore
            .collection(FirebaseConstants.usersCollection)
            .doc(userDetails?.id)
            .update(userDetails?.toJson() ?? {});
        LoggerService.i('User updated successfully');
        return Result(data: userDetails);
      } else {
        final doc = await _firestore
            .collection(FirebaseConstants.usersCollection)
            .add(userDetails?.toJson() ?? {});
        LoggerService.i('User created successfully');
        userDetails?.id = doc.id;
        return Result(data: userDetails);
      }
    } on FirebaseException catch (e) {
      LoggerService.e('Error saving user: ${e.message}');
      return Result(error: e.message);
    } catch (e) {
      LoggerService.e('Error saving user: $e');
      return Result(error: e.toString());
    }
  }

  Future<Result<AppUser>> getUserDetailsByEmail(String email) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection(FirebaseConstants.usersCollection)
          .where('email', isEqualTo: email)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first;
        return Result(
            data: AppUser.fromJson(data.data()).copyWith(id: data.id));
      } else {
        return Result(error: "User not found");
      }
    } on FirebaseException catch (e) {
      LoggerService.e('Error getting user by email: ${e.message}');
      return Result(error: e.message);
    } catch (e) {
      LoggerService.e('Error getting user by email: $e');
      return Result(error: e.toString());
    }
  }

  Future<Result<String>> savePet(Pet petData) async {
    try {
      if (petData.id != null) {
        await _firestore
            .collection(FirebaseConstants.petsCollection)
            .doc(petData.id)
            .update(petData.toJson());
        LoggerService.i('Pet updated successfully');
        return Result(data: 'Pet updated successfully');
      } else {
        await _firestore
            .collection(FirebaseConstants.petsCollection)
            .add(petData.toJson());
        LoggerService.i('Pet created successfully');
        return Result(data: 'Pet created successfully');
      }
    } on FirebaseException catch (e) {
      LoggerService.e('Error saving pet: ${e.message}');
      return Result(error: e.message);
    } catch (e) {
      LoggerService.e('Error saving pet: $e');
      return Result(error: e.toString());
    }
  }

  Future<Result> deletePet(String? petId) async {
    try {
      await _firestore
          .collection(FirebaseConstants.petsCollection)
          .doc(petId)
          .delete();
      LoggerService.i('Pet deleted successfully');
      return Result(data: 'Pet deleted successfully');
    } on FirebaseException catch (e) {
      LoggerService.e('Error deleting pet: ${e.message}');
      return Result(error: e.message);
    } catch (e) {
      LoggerService.e('Error deleting pet: $e');
      return Result(error: e.toString());
    }
  }

  Future<Result<String>> addToFavorites(String userId, Pet pet) async {
    try {
      final favoritesCollection = FirebaseFirestore.instance
          .collection(FirebaseConstants.favouritesCollection);

      final existingFavorite = await favoritesCollection
          .where('userId', isEqualTo: userId)
          .where('petId', isEqualTo: pet.id)
          .get();

      if (existingFavorite.docs.isEmpty) {
        await favoritesCollection.add({
          'userId': userId,
          'petId': pet.id,
          'petDetails': pet.toJson(),
          'timestamp': FieldValue.serverTimestamp(),
        });
        LoggerService.i('Pet added to favorites');
      }
      return Result(data: 'Pet added to favorites');
    } on FirebaseException catch (e) {
      LoggerService.e('Error adding pet to favorites: ${e.message}');
      return Result(error: e.message);
    } catch (e) {
      LoggerService.e('Error adding pet to favorites: $e');
      return Result(error: e.toString());
    }
  }
}
