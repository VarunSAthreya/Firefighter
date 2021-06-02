import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  final String id;
  final String name;
  final String email;

  Admin({
    required this.id,
    required this.name,
    required this.email,
  });

  factory Admin.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    return Admin(
      id: data['id'].toString(),
      name: data['name'].toString(),
      email: data['email'].toString(),
    );
  }
}
