import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

uploadImage(img) async {
  // Initialize Firebase once again
  await Firebase.initializeApp();
  var random = new Random();
  var rand = random.nextInt(1000000000);
  // Give the image a random name
  String name = "image:$rand";
  try {
    await firebase_storage.FirebaseStorage.instance
        // Give the image a name
        .ref('$name.jpg')
        // Upload image to firebase
        .putFile(img);
    print("Uploaded image");
  } on firebase_core.FirebaseException catch (e) {
    print(e);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;
  final picker = ImagePicker();

  getImage() async {
    // You can also change the source to gallery like this: "source: ImageSource.camera"
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image has been selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _image == null
            ? Center(
                child: ElevatedButton(
                  child: Icon(Icons.add_a_photo_outlined),
                  onPressed: () => getImage(),
                ),
              )
            : Center(child: Image.file(_image)),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.upload),
        onPressed: () {
          if (_image != null) {
            return uploadImage(_image);
          }
        },
      ),
    );
  }
}
