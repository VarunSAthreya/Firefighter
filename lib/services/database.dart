import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

import '../models/machine.dart';
import '../models/request.dart';
import '../models/spot.dart';
import '../models/user.dart';

class DatabaseService {
  DatabaseService._();

  //   Initialize uuid
  static const Uuid _uuid = Uuid(options: {'grng': UuidUtil.cryptoRNG});

  // Cloud firestore collection path
  static final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection('users');

  static final CollectionReference _requestsRef =
      FirebaseFirestore.instance.collection('requests');

  static final CollectionReference _machinesRef =
      FirebaseFirestore.instance.collection('machines');

  static final CollectionReference _spotsRef =
      FirebaseFirestore.instance.collection('spots');

  // Users realted functions

  static Future<void> addUser({
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

  static Future<void> updateUser({
    required String id,
    required String key,
    required dynamic value,
  }) async {
    await _usersRef.doc(id).update({key: value});
  }

  static Future<Users> getUser({required String id}) async {
    final DocumentSnapshot snapshot = await _usersRef.doc(id).get();
    return Users.fromDocumentSnapshot(snapshot);
  }

  static Stream<List<Users>> get engineers => _usersRef
      .where('type', isEqualTo: 'engineer')
      .snapshots()
      .map(Users.fromQuerySnapshot);

  //   Request related queries

  static Future<void> createRequest({
    required String machineId,
    required String endUserId,
    required String spotId,
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
      'is_solved': false,
      'spot_id': spotId,
      'assigned_to': null,
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

  static Future<void> assignRequest({
    required String id,
    required String uid,
  }) async {
    await _requestsRef.doc(id).update({'assigned_to': uid});
    await _usersRef.doc(uid).update({
      'actions': FieldValue.arrayUnion([id]),
    });
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

  static Future<String> createMachines({
    required String name,
    required String address,
    required String type,
    required String spotId,
  }) async {
    final String id = _uuid.v4();
    await _machinesRef.doc(id).set({
      "id": id,
      "name": name,
      "address": address,
      "spot_id": spotId,
      "type": type,
      "services": <String>[],
      'last_serviced': null,
      'future_serviced': null,
    });
    await _spotsRef.doc(spotId).update({
      'machine_id': FieldValue.arrayUnion([id]),
    });
    return id;
  }

  static Stream<List<Machine>> get allMachines =>
      _machinesRef.snapshots().map(Machine.fromQuerySnapshot);

  static Stream<List<Machine>> getSpotMachines({required String spotId}) =>
      _machinesRef
          .where('spot_id', isEqualTo: spotId)
          .snapshots()
          .map(Machine.fromQuerySnapshot);

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

  static Future<void> deleteMachines({required String id}) async {
    await _machinesRef.doc(id).delete();
  }
  //   Spots related queries

  static Future<void> createSpots({
    required LatLng location,
    required String name,
  }) async {
    final String id = _uuid.v4();
    await _spotsRef.doc(id).set({
      "id": id,
      "name": name,
      "machine_id": <String>[],
      "location": GeoPoint(location.latitude, location.longitude),
    });
  }

  static Stream<List<Spot>> get allspots =>
      _spotsRef.snapshots().map(Spot.fromQuerySnapshot);

  static Future<Spot> getSpot({required String id}) async {
    final DocumentSnapshot snapshot = await _spotsRef.doc(id).get();
    return Spot.fromDocumentSnapshot(snapshot);
  }

  static Future<void> updatespots({
    required String id,
    required String key,
    required dynamic value,
  }) async {
    await _spotsRef.doc(id).update({key: value});
  }

  static Future<void> deletespots({required String id}) async {
    await _spotsRef.doc(id).delete();
  }
}
