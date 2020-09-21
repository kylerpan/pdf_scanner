import 'package:flutter/material.dart';

class ImagePreview extends StatefulWidget {
  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PDF Scanner")),
      body: Container(
        child: Text('other thing'),
      ),
    );
  }
}
