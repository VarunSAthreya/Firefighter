import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  DatabaseService._();

  // Cloud firestore collection path
  static final CollectionReference _engineersRef =
      FirebaseFirestore.instance.collection('engineers');
  static final CollectionReference _endUserRef =
      FirebaseFirestore.instance.collection('end_users');
  static final CollectionReference _adminRef =
      FirebaseFirestore.instance.collection('admins');

  // Engineer realted functions

  static Future<void> addEngineers({
    required String id,
    required String name,
    required String email,
  }) async {
    await _engineersRef.doc(id).set({
      "id": id,
      "name": name,
      "email": email,
      "service": <String>[],
    });
  }

  // End User realted functions

  static Future<void> addEndUser({
    required String id,
    required String name,
    required String email,
  }) async {
    await _endUserRef.doc(id).set({
      "id": id,
      "name": name,
      "email": email,
      "requests": <String>[],
    });
  }

  // Admin realted functions

  static Future<void> addAdmin({
    required String id,
    required String name,
    required String email,
  }) async {
    await _adminRef.doc(id).set({
      "id": id,
      "name": name,
      "email": email,
    });
  }
}
