import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String id;
  final String name;
  final String email;
  final String type;
  final List actions;

  Users({
    required this.id,
    required this.name,
    required this.email,
    required this.type,
    required this.actions,
  });

  factory Users.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;

    return Users(
      id: data['id'].toString(),
      name: data['name'].toString(),
      email: data['email'].toString(),
      type: data['type'].toString(),
      actions: data['actions'] as List,
    );
  }

  static List<Users> fromQuerySnapshot(
    QuerySnapshot snapshot,
  ) {
    return snapshot.docs.map((doc) {
      return Users(
        id: doc['id'].toString(),
        name: doc['name'].toString(),
        email: doc['email'].toString(),
        type: doc['type'].toString(),
        actions: doc['actions'] as List,
      );
    }).toList();
  }
}
