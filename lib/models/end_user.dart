import 'package:cloud_firestore/cloud_firestore.dart';

class EndUser {
  final String id;
  final String name;
  final String email;
  final List requests;

  EndUser({
    required this.id,
    required this.name,
    required this.email,
    required this.requests,
  });
  factory EndUser.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return EndUser(
      id: data['id'] as String,
      name: data['name'] as String,
      email: data['email'] as String,
      requests: data['requests'] as List,
    );
  }
}
