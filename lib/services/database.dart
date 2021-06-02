import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firefighter/models/user.dart';

class DatabaseService {
  DatabaseService._();

  // Cloud firestore collection path
  static final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('users');

  // Users realted functions

  static Future<void> addUsers({
    required String id,
    required String name,
    required String email,
    required String type,
  }) async {
    await _usersRef.doc(id).set({
      "id": id,
      "name": name,
      "email": email,
      "type": type,
      "actions": <String>[],
    });
  }

  static Future<void> updateUsers({
    required String id,
    required String key,
    required dynamic value,
  }) async {
    await _usersRef.doc(id).update({key: value});
  }

  static Future<Users> getUsers({required String id}) async {
    final DocumentSnapshot snapshot = await _usersRef.doc(id).get();
    return Users.fromDocumentSnapshot(snapshot);
  }
}
