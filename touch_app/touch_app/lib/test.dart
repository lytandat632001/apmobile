import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  File? imageFile;
  String? imageBase64;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Picker"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            imageFile == null
                ? Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            _getFromGallery();
                          },
                          child: Text("PICK FROM GALLERY"),
                        ),
                        SizedBox(height: 40.0),
                        TextButton(
                          onPressed: () {
                            _getFromCamera();
                          },
                          child: Text("PICK FROM CAMERA"),
                        )
                      ],
                    ),
                  )
                : Column(
                    children: <Widget>[
                      Image.file(
                        imageFile!,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 20.0),
                      TextButton(
                        onPressed: () {
                          _convertToBase64();
                        },
                        child: Text("CONVERT TO BASE64"),
                      ),
                      if (imageBase64 != null)
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            imageBase64!,
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        imageBase64 = null; // Reset base64 when selecting a new image
      });
    }
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        imageBase64 = null; // Reset base64 when selecting a new image
      });
    }
  }

  _convertToBase64() async {
    if (imageFile != null) {
      List<int> imageBytes = await imageFile!.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      setState(() {
        imageBase64 = base64Image;
      });
    }
  }
}
