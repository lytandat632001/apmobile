

import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageConverter {
  final ImagePicker _picker = ImagePicker();

  Future<String> getImageBase64() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      final imageBytes = await imageFile.readAsBytes();

      // Thực hiện chuyển đổi thành Base64
      final encodedString = base64.encode(imageBytes);

      return encodedString;
    } else {
      throw Exception('Không thể lấy ảnh');
    }
  }
}