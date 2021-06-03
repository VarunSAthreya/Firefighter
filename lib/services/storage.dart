import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  StorageService({required this.userId});
  final String userId;

  Future<String> uploadImage({
    required File file,
  }) async {
    return _upload(
      file: file,
      path: '$userId/service/${DateTime.now()}.png',
      contentType: 'image/png',
    );
  }

  Future<String> _upload({
    required File file,
    required String path,
    required String contentType,
  }) async {
    final storageReference = FirebaseStorage.instance.ref().child(path);
    final UploadTask uploadTask = storageReference.putFile(
        file, SettableMetadata(contentType: contentType));

    final TaskSnapshot snapshot = await uploadTask;

    final String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
