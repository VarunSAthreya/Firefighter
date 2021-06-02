import 'package:cloud_firestore/cloud_firestore.dart';

class Engineer {
  final String id;
  final String name;
  final String email;
  final List service;

  Engineer({
    required this.id,
    required this.name,
    required this.email,
    required this.service,
  });
  factory Engineer.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Engineer(
      id: data['id'].toString(),
      name: data['name'].toString(),
      email: data['email'].toString(),
      service: data['service'] as List,
    );
  }
}
