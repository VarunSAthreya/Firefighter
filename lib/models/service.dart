import 'package:cloud_firestore/cloud_firestore.dart';

class Services {
  final String id;
  final String machineId;
  final String engineerId;
  final String spotId;
  final DateTime serviceDate;
  final bool endUserApproved;
  final bool isComplete;
  final String beforePic;
  final String afterPic;

  Services({
    required this.id,
    required this.machineId,
    required this.engineerId,
    required this.spotId,
    required this.serviceDate,
    required this.endUserApproved,
    required this.isComplete,
    required this.beforePic,
    required this.afterPic,
  });

  factory Services.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final Map<String, dynamic> data = snapshot.data()! as Map<String, dynamic>;

    return Services(
      id: data['id'].toString(),
      machineId: data['machine_id'].toString(),
      spotId: data['spot_id'].toString(),
      engineerId: data['engineer_id'].toString(),
      serviceDate: DateTime.parse(data['service_date'].toDate().toString()),
      endUserApproved: data['end_user_id'] as bool,
      isComplete: data['is_complete'] as bool,
      beforePic: data['before_pic'].toString(),
      afterPic: data['after_pic'].toString(),
    );
  }

  static List<Services> fromQuerySnapshot(
    QuerySnapshot snapshot,
  ) {
    return snapshot.docs.map((doc) {
      return Services(
        id: doc['id'].toString(),
        machineId: doc['machine_id'].toString(),
        spotId: doc['spot_id'].toString(),
        engineerId: doc['engineer_id'].toString(),
        serviceDate: DateTime.parse(doc['service_date'].toDate().toString()),
        endUserApproved: doc['end_user_id'] as bool,
        isComplete: doc['is_complete'] as bool,
        beforePic: doc['before_pic'].toString(),
        afterPic: doc['after_pic'].toString(),
      );
    }).toList();
  }
}
