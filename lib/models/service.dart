import 'package:cloud_firestore/cloud_firestore.dart';

class Service {
  final String id;
  final String machineId;
  final String engineerId;
  final String endUserId;
  final DateTime serviceDate;
  final bool endUserApproved;

  Service({
    required this.id,
    required this.machineId,
    required this.engineerId,
    required this.endUserId,
    required this.serviceDate,
    required this.endUserApproved,
  });

  factory Service.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Service(
      id: data['id'].toString(),
      machineId: data['machine_id'].toString(),
      endUserId: data['end_user_id'].toString(),
      engineerId: data['engineer_id'].toString(),
      serviceDate: DateTime.parse(data['service_date'].toDate().toString()),
      endUserApproved: data['end_user_id'] as bool,
    );
  }
}
