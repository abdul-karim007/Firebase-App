import 'package:class3julyfirebase/firebase_options.dart';
import 'package:class3julyfirebase/pages/home.dart';
import 'package:class3julyfirebase/pages/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  var password = prefs.getString('password');
  print(email);
  print(password);
  runApp(MaterialApp(
    home: email == null || password == null ? SignIn() : Home(),
    debugShowCheckedModeBanner: false,
  ));
}
