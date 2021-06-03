import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Spot {
  final String id;
  final List machineId;
  final LatLng location;
  final String name;

  Spot({
    required this.id,
    required this.machineId,
    required this.location,
    required this.name,
  });

  factory Spot.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;

    return Spot(
      id: data['id'].toString(),
      machineId: data['machine_id'] as List,
      name: data['name'].toString(),
      location: LatLng(
        double.parse(data['location'].latitude.toString()),
        double.parse(data['location'].longitude.toString()),
      ),
    );
  }
  static List<Spot> fromQuerySnapshot(
    QuerySnapshot snapshot,
  ) {
    return snapshot.docs.map((doc) {
      return Spot(
        id: doc['id'].toString(),
        name: doc['name'].toString(),
        machineId: doc['machine_id'] as List,
        location: LatLng(
          double.parse(doc['location'].latitude.toString()),
          double.parse(doc['location'].longitude.toString()),
        ),
      );
    }).toList();
  }
}
