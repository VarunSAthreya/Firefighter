import 'package:cloud_firestore/cloud_firestore.dart';

class Machine {
  final String id;
  final String name;
  final String address;
  final String type;
  final String spotId;
  final List services;
  final DateTime? lastServiced;
  final DateTime? futureService;

  Machine({
    required this.id,
    required this.name,
    required this.address,
    required this.type,
    required this.spotId,
    required this.services,
    required this.lastServiced,
    required this.futureService,
  });

  factory Machine.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;

    return Machine(
      id: data['id'].toString(),
      name: data['name'].toString(),
      address: data['address'].toString(),
      type: data['type'].toString(),
      services: data['services'] as List,
      spotId: data['spot_id'].toString(),
      lastServiced: data['last_serviced'] == null
          ? null
          : DateTime.parse(data['last_serviced'].toDate().toString()),
      futureService: data['future_serviced'] == null
          ? null
          : DateTime.parse(data['future_serviced'].toDate().toString()),
    );
  }
  static List<Machine> fromQuerySnapshot(
    QuerySnapshot snapshot,
  ) {
    return snapshot.docs.map((doc) {
      return Machine(
        id: doc['id'].toString(),
        name: doc['name'].toString(),
        address: doc['address'].toString(),
        type: doc['type'].toString(),
        services: doc['services'] as List,
        spotId: doc['spot_id'].toString(),
        lastServiced: doc['last_serviced'] == null
            ? null
            : DateTime.parse(doc['last_serviced'].toDate().toString()),
        futureService: doc['future_serviced'] == null
            ? null
            : DateTime.parse(doc['future_serviced'].toDate().toString()),
      );
    }).toList();
  }
}
