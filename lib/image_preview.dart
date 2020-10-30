import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

// to access camera

class ImagePreview extends StatefulWidget {
  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  File _image;

  getImage(bool isCamera) async {
    File image;
    PickedFile pickedimage;
    if (isCamera) {
      pickedimage = await ImagePicker().getImage(source: ImageSource.camera);
      image = File(pickedimage.path);
    } else {
      pickedimage = await ImagePicker().getImage(source: ImageSource.gallery);
      image = File(pickedimage.path);
    }
    setState(() {
      _image = image;
    });
  }

  File previewImage() {
    return _image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PDF Scanner")),
      body: Container(
        child: Image.file(_image, height: 300.0, width: 300.0),
      ),
    );
  }
}
