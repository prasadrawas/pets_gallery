import 'package:firebase_auth/firebase_auth.dart';
import 'package:pets_app/common/utils/logger_service.dart';
import 'package:pets_app/models/response/result.dart';

class FirebaseAuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Result> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;
      LoggerService.i('User signed up successfully');
      return Result(data: user);
    } on FirebaseAuthException catch (e) {
      LoggerService.e('Error signing up: ${e.message}');
      return Result(error: e.message);
    } catch (e) {
      LoggerService.e('Error signing up: $e');
      return Result(error: e.toString());
    }
  }

  Future<Result> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;
      LoggerService.i('User signed in successfully');
      return Result(data: user);
    } on FirebaseAuthException catch (e) {
      LoggerService.e('Error signing in: ${e.message}');
      return Result(error: e.message);
    } catch (e) {
      LoggerService.e('Error signing in: $e');
      return Result(error: e.toString());
    }
  }

  Future<Result> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      LoggerService.i('Password reset email sent');
      return Result(data: 'Password reset email sent');
    } on FirebaseAuthException catch (e) {
      LoggerService.e('Error sending password reset email: ${e.message}');
      return Result(error: e.message);
    } catch (e) {
      LoggerService.e('Error sending password reset email: $e');
      return Result(error: e.toString());
    }
  }

  Future<Result> updateEmail(String newEmail) async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        await user.updateEmail(newEmail);
        LoggerService.i('Email updated successfully');
        return Result(data: 'Email updated successfully');
      } else {
        LoggerService.e('User not authenticated');
        return Result(error: 'User not authenticated');
      }
    } on FirebaseAuthException catch (e) {
      LoggerService.e('Error updating email: ${e.message}');
      return Result(error: e.message);
    } catch (e) {
      LoggerService.e('Error updating email: $e');
      return Result(error: e.toString());
    }
  }

  Future<Result> updatePassword(String newPassword) async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
        LoggerService.i('Password updated successfully');
        return Result(data: 'Password updated successfully');
      } else {
        LoggerService.e('User not authenticated');
        return Result(error: 'User not authenticated');
      }
    } on FirebaseAuthException catch (e) {
      LoggerService.e('Error updating password: ${e.message}');
      return Result(error: e.message);
    } catch (e) {
      LoggerService.e('Error updating password: $e');
      return Result(error: e.toString());
    }
  }

  Future<bool> isUserLoggedIn() async {
    final user = _auth.currentUser;
    LoggerService.i('User login status: ${user != null}');
    return user != null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    LoggerService.i('User signed out successfully');
  }
}
