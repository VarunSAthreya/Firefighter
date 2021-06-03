import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final imageProvider =
    ChangeNotifierProvider<ImagePickerService>((ref) => ImagePickerService());

class ImagePickerService extends ChangeNotifier {
  final imagePicker = ImagePicker();
  // Returns a [File] object pointing to the image that was picked.
  Future<File> pickImage() async {
    final pickedFile = await imagePicker.getImage(
        source: ImageSource.gallery, imageQuality: 75);
    return File(pickedFile!.path);
  }
}
