import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/admin.dart';
import '../models/end_user.dart';
import '../models/engineers.dart';

class DatabaseService {
  DatabaseService._();

  // Cloud firestore collection path
  static final CollectionReference _engineersRef =
      FirebaseFirestore.instance.collection('engineers');
  static final CollectionReference _endUserRef =
      FirebaseFirestore.instance.collection('end_users');
  static final CollectionReference _adminsRef =
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

  static Future<void> updateEngineers({
    required String id,
    required String key,
    required dynamic value,
  }) async {
    await _engineersRef.doc(id).update({key: value});
  }

  static Future<Engineer> getEngineers({required String id}) async {
    final DocumentSnapshot snapshot = await _engineersRef.doc(id).get();
    return Engineer.fromDocumentSnapshot(snapshot);
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

  static Future<void> updateEndUser({
    required String id,
    required String key,
    required dynamic value,
  }) async {
    await _endUserRef.doc(id).update({key: value});
  }

  static Future<EndUser> getEndUser({required String id}) async {
    final DocumentSnapshot snapshot = await _endUserRef.doc(id).get();
    return EndUser.fromDocumentSnapshot(snapshot);
  }

  // Admin realted functions

  static Future<void> addAdmin({
    required String id,
    required String name,
    required String email,
  }) async {
    await _adminsRef.doc(id).set({
      "id": id,
      "name": name,
      "email": email,
    });
  }

  static Future<void> updateAdmin({
    required String id,
    required String key,
    required dynamic value,
  }) async {
    await _adminsRef.doc(id).update({key: value});
  }

  static Future<Admin> getAdmin({required String id}) async {
    final DocumentSnapshot snapshot = await _adminsRef.doc(id).get();
    return Admin.fromDocumentSnapshot(snapshot);
  }
}
