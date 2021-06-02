import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firefighter/models/machine.dart';
import 'package:firefighter/models/request.dart';
import 'package:firefighter/models/user.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class DatabaseService {
  DatabaseService._();

  //   Initialize uuid
  static final Uuid _uuid = Uuid(options: {'grng': UuidUtil.cryptoRNG});

  // Cloud firestore collection path
  static final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('users');

  static final CollectionReference _requestsRef =
      FirebaseFirestore.instance.collection('requests');

  static final CollectionReference _machinesRef =
      FirebaseFirestore.instance.collection('machines');

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

  //   Request related queries

  static Future<void> createRequest({
    required String machineId,
    required String endUserId,
    required String title,
    required String description,
  }) async {
    final String id = _uuid.v4();
    await _requestsRef.doc(id).set({
      "id": id,
      "machine_id": machineId,
      "end_user_id": endUserId,
      "title": title,
      "description": description,
      'created_at': Timestamp.now(),
      'is_solved': false
    });
    await _usersRef.doc(endUserId).update({
      "actions": FieldValue.arrayUnion([id]),
    });
  }

  static Stream<List<Request>> get allRequests => _requestsRef
      .where('is_solved', isEqualTo: false)
      .snapshots()
      .map(Request.fromQuerySnapshot);

  static Future<Request> getRequest({required String id}) async {
    final DocumentSnapshot snapshot = await _requestsRef.doc(id).get();
    return Request.fromDocumentSnapshot(snapshot);
  }

  static Future<void> updateRequest({
    required String id,
    required String key,
    required dynamic value,
  }) async {
    await _requestsRef.doc(id).update({key: value});
  }

  static Future<void> deleteRequest(
      {required String id, required String uid}) async {
    await _requestsRef.doc(id).delete();
    await _usersRef.doc(uid).update({
      "actions": FieldValue.arrayRemove([id]),
    });
  }

  //   Machines related queries

  static Future<void> createMachines({
    required String address,
    required String endUserId,
    required String type,
  }) async {
    final String id = _uuid.v4();
    await _machinesRef.doc(id).set({
      "id": id,
      "address": address,
      "end_user_id": endUserId,
      "type": type,
      "services": <String>[],
      'last_serviced': null,
      'future_serviced': null,
    });
  }

  static Stream<List<Machine>> get allMachines =>
      _machinesRef.snapshots().map(Machine.fromQuerySnapshot);

  static Future<Machine> getMachine({required String id}) async {
    final DocumentSnapshot snapshot = await _machinesRef.doc(id).get();
    return Machine.fromDocumentSnapshot(snapshot);
  }

  static Future<void> updateMachines({
    required String id,
    required String key,
    required dynamic value,
  }) async {
    await _machinesRef.doc(id).update({key: value});
  }

  static Future<void> deleteMachines(
      {required String id, required String uid}) async {
    await _machinesRef.doc(id).delete();
  }
}
