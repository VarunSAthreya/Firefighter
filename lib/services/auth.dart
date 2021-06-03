import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'database.dart';

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
          await DatabaseService.addUser(
            id: userCredential.user!.uid,
            name: name,
            email: email,
            type: 'enginner',
          );
          break;
        case 'Dashboard Admin':
          await DatabaseService.addUser(
            id: userCredential.user!.uid,
            name: name,
            email: email,
            type: 'admin',
          );
          break;
        case 'End User':
          await DatabaseService.addUser(
            id: userCredential.user!.uid,
            name: name,
            email: email,
            type: 'user',
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
