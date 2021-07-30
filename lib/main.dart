/// Developer: Tin Huynh
/// Purpose: This is an online shopping app written in dart and flutter SDK
/// Developed on Android Studio 4.2.2
/// Version: 1.0
///
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:happy_shopy/screens/login_screen/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Happy Shopy',
      theme: ThemeData(primarySwatch: Colors.grey,),
      color: Colors.grey[200],
      home: LoginPage(),
    );
  }
}