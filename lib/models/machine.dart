import 'package:cloud_firestore/cloud_firestore.dart';

class Machine {
  final String id;
  final String address;
  final String endUserId;
  final String type;
  final List services;
  final DateTime lastServiced;
  final DateTime futureService;

  Machine({
    required this.id,
    required this.address,
    required this.endUserId,
    required this.type,
    required this.services,
    required this.lastServiced,
    required this.futureService,
  });

  factory Machine.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Machine(
      id: data['id'].toString(),
      address: data['address'].toString(),
      endUserId: data['end_user_id'].toString(),
      type: data['type'].toString(),
      services: data['services'] as List,
      lastServiced: DateTime.parse(data['last_serviced'].toDate().toString()),
      futureService:
          DateTime.parse(data['future_serviced'].toDate().toString()),
    );
  }
}
