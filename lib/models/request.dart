import 'package:cloud_firestore/cloud_firestore.dart';

class Request {
  final String id;
  final String machineId;
  final String? assignedTo;
  final String endUserId;
  final String spotId;
  final String title;
  final String description;
  final DateTime createdAt;
  final bool isSolved;

  Request({
    required this.id,
    required this.machineId,
    required this.assignedTo,
    required this.endUserId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.isSolved,
    required this.spotId,
  });
  factory Request.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;

    return Request(
      id: data['id'].toString(),
      endUserId: data['end_user_id'].toString(),
      assignedTo: data['assigned_to']?.toString(),
      machineId: data['machine_id'].toString(),
      title: data['title'].toString(),
      description: data['description'].toString(),
      createdAt: DateTime.parse(data['created_at'].toDate().toString()),
      isSolved: data['is_solved'] as bool,
      spotId: data['spot_id'].toString(),
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
        assignedTo: doc['assigned_to']?.toString(),
        title: doc['title'].toString(),
        description: doc['description'].toString(),
        createdAt: DateTime.parse(doc['created_at'].toDate().toString()),
        isSolved: doc['is_solved'] as bool,
        spotId: doc['spot_id'].toString(),
      );
    }).toList();
  }
}
