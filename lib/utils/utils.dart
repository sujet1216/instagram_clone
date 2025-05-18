import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

Future<Uint8List?> pickImage() async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? xFile = await imagePicker.pickImage(
    source:
        kIsWeb
            ? ImageSource.gallery
            : Platform.isAndroid
            ? ImageSource.camera
            : ImageSource.gallery,
  );

  if (xFile != null) {
    return await xFile.readAsBytes();
  }
  return null;
}
