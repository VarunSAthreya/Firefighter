import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  final String id;
  final String machineId;
  final String endUserId;
  final String title;
  final String description;
  final DateTime createdAt;

  Request({
    required this.id,
    required this.machineId,
    required this.endUserId,
    required this.title,
    required this.description,
    required this.createdAt,
  });
  factory Request.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Request(
      id: data['id'].toString(),
      endUserId: data['end_user_id'].toString(),
      machineId: data['machine_id'].toString(),
      title: data['title'].toString(),
      description: data['description'].toString(),
      createdAt: DateTime.parse(data['created_at'].toDate().toString()),
    );
  }
}
