import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:pets_app/common/utils/logger_service.dart';
import 'package:pets_app/models/response/result.dart';

class FirebaseStorageRepository {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<Result<String>> uploadImage(File imageFile) async {
    try {
      final ref = _firebaseStorage
          .ref('images/img-${DateTime.now().microsecondsSinceEpoch}');
      final uploadTask = ref.putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadURL = await snapshot.ref.getDownloadURL();
      LoggerService.i('Image uploaded successfully');
      return Result(data: downloadURL);
    } on FirebaseException catch (e) {
      LoggerService.e('Error uploading image: ${e.message}');
      return Result(error: e.message);
    } catch (e) {
      LoggerService.e('Error uploading image: $e');
      return Result(error: e.toString());
    }
  }

  Future<Result<void>> deleteImage(String downloadURL) async {
    try {
      final ref = _firebaseStorage.refFromURL(downloadURL);
      await ref.delete();
      LoggerService.i('Previous image deleted successfully');
      return Result();
    } on FirebaseException catch (e) {
      LoggerService.e('Error deleting image: ${e.message}');
      return Result(error: e.message);
    } catch (e) {
      LoggerService.e('Error deleting image: $e');
      return Result(error: e.toString());
    }
  }
}
