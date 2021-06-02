import 'package:firebase_auth/firebase_auth.dart';
import 'package:firefighter/services/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authProvider = ChangeNotifierProvider<FirebaseAuthProvider>(
    (ref) => FirebaseAuthProvider());

class FirebaseAuthProvider extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<User?> signInWithEmail(
      {required String email, required String password}) async {
    final UserCredential userCredential =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    required String userType,
  }) async {
    final UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (userCredential.user != null) {
      switch (userType) {
        case 'Spot Engineer':
          await DatabaseService.addEngineers(
            id: userCredential.user!.uid,
            name: name,
            email: email,
          );
          break;
        case 'Dashboard Admin':
          await DatabaseService.addAdmin(
            id: userCredential.user!.uid,
            name: name,
            email: email,
          );
          break;
        case 'End User':
          await DatabaseService.addEndUser(
            id: userCredential.user!.uid,
            name: name,
            email: email,
          );
          break;
        default:
          debugPrint('Wrong type of user');
      }
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> resetPassword({required String email}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
