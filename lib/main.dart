import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import './homepage.dart';

void main() {
  // Make sure to initialize app
  WidgetsFlutterBinding.ensureInitialized();
  // Also with this 👇
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Let's create MyHomePage later.
      home: MyHomePage(),
    );
  }
}
