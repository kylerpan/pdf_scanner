import 'package:flutter/material.dart';
import 'package:pdfScanner/image_preview.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // to access camera
  File _image;

  Future getImage(bool isCamera) async {
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
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ImagePreview()));
  }

  // to get the degrees for offset
  double getRadiansFromDegrees(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  // to create the menu animation
  AnimationController animationController;
  Animation degOneTranslationAnimation;
  Animation rotationAnimation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTranslationAnimation =
        Tween(begin: 0.0, end: 1.0).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  var icon = Icons.add;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PDF Scanner")),
      body: Column(
        children: <Widget>[
          Text("hello world"),
          // _image == null
          //     ? Container()
          //     : Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => ImagePreview())),
          // Container() : Image.file(_image, height: 300.0, width: 300.0)
          // RaisedButton(
          //   onPressed: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => ImagePreview()));
          //   },
          // ),
        ],
      ),
      floatingActionButton: Stack(
        alignment: Alignment.bottomRight,
        children: <Widget>[
          IgnorePointer(
            child: Container(
              // color: Colors.black.withOpacity(0.5),
              height: 175.0,
              width: 55.0,
            ),
          ),
          Transform.translate(
            offset: Offset.fromDirection(getRadiansFromDegrees(270),
                degOneTranslationAnimation.value * 130),
            child: Transform(
              transform: Matrix4.rotationZ(
                  getRadiansFromDegrees(rotationAnimation.value)),
              alignment: Alignment.center,
              child: Container(
                height: 50.0,
                child: FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.blueGrey,
                  child: Icon(
                    Icons.insert_drive_file,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    getImage(false);
                  },
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset.fromDirection(getRadiansFromDegrees(270),
                degOneTranslationAnimation.value * 70),
            child: Transform(
              transform: Matrix4.rotationZ(
                  getRadiansFromDegrees(rotationAnimation.value)),
              alignment: Alignment.center,
              child: Container(
                height: 50.0,
                child: FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.blueGrey,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    getImage(true);
                  },
                ),
              ),
            ),
          ),
          Transform(
            transform: Matrix4.rotationZ(
                getRadiansFromDegrees(rotationAnimation.value)),
            alignment: Alignment.center,
            child: FloatingActionButton(
              heroTag: null,
              child: Icon(
                icon,
              ),
              onPressed: () {
                if (animationController.isCompleted) {
                  animationController.reverse();
                  icon = Icons.add;
                } else {
                  animationController.forward();
                  icon = Icons.close;
                }
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
