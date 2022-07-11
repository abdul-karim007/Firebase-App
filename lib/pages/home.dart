import 'package:class3julyfirebase/constants/clr.dart';
import 'package:class3julyfirebase/functions/textField.dart';
import 'package:class3julyfirebase/pages/loginPage.dart';
import 'package:class3julyfirebase/pages/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  TextEditingController cont1 = TextEditingController();
  TextEditingController cont2 = TextEditingController();
  TextEditingController cont3 = TextEditingController();

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'full_name': cont1.text, // John Doe
          'company': cont2.text, // Stokes and Sons
          'age': cont3.text // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Colorconst.bgcolor),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SafeArea(
                child: Text(
              'To-Do App',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w600),
            )),
            customTextField(context, cont1, 'Full Name'),
            customTextField(context, cont2, 'Company'),
            customTextField(context, cont3, 'Age'),
            ElevatedButton(
              child: Text('AddUsers'),
              onPressed: () {
                addUser();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
                textStyle:
                    MaterialStateProperty.all(TextStyle(color: Colors.white)),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Product()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  textStyle:
                      MaterialStateProperty.all(TextStyle(color: Colors.white)),
                ),
                child: Text('View saved data')),
            ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('email');
                  prefs.remove('password');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignIn()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  textStyle:
                      MaterialStateProperty.all(TextStyle(color: Colors.white)),
                ),
                child: Text('Log Out'))
          ],
        ),
      ),
    );
  }
}
