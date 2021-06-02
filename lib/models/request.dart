import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  final String id;
  final String machineId;
  final String endUserId;
  final String title;
  final String description;
  final DateTime createdAt;
  final bool solved;

  Request({
    required this.id,
    required this.machineId,
    required this.endUserId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.solved,
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
      solved: data['solved'] as bool,
    );
  }

  static List<Request> fromQuerySnapshot(
    QuerySnapshot snapshot,
  ) {
    return snapshot.docs.map((doc) {
      return Request(
        id: doc['id'].toString(),
        endUserId: doc['end_user_id'].toString(),
        machineId: doc['machine_id'].toString(),
        title: doc['title'].toString(),
        description: doc['description'].toString(),
        createdAt: DateTime.parse(doc['created_at'].toDate().toString()),
        solved: doc['solved'] as bool,
      );
    }).toList();
  }
}
