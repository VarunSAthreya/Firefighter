import 'package:cloud_firestore/cloud_firestore.dart';

class Spot {
  final String id;
  final List machineId;
  final String endUserId;
  final GeoPoint location;

  Spot({
    required this.id,
    required this.machineId,
    required this.endUserId,
    required this.location,
  });
}
