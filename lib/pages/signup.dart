import 'package:class3julyfirebase/constants/clr.dart';
import 'package:class3julyfirebase/functions/button.dart';
import 'package:class3julyfirebase/functions/textField.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatelessWidget {
  TextEditingController emailco = TextEditingController();
  TextEditingController passco = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Colorconst.bgcolor),
      appBar: AppBar(
        title: Text('SignUp Page'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: 30,
            child: Text('Enter your name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                textAlign: TextAlign.left),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  fillColor: Colors.black,
                  hintText: 'Enter your Name'),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.center,
            height: 30,
            child: Text(
              'Enter your Email',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          customTextField(context, emailco, 'Enter your Email'),
          Container(
            alignment: Alignment.center,
            height: 30,
            child: Text(
              'Enter your Password',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          customTextField(context, passco, 'Enter your Password'),
          SizedBox(
            height: 10,
          ),
          custombutton(() async {
              try {
                UserCredential userCredential = await FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: emailco.text.toString(),
                        password: passco.text.toString());
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  print('The password provided is too weak.');
                } else if (e.code == 'email-already-in-use') {
                  print('The account already exists for that email.');
                }
              } catch (e) {
                print(e);
              }
            }, 'Confirm', context)
        ],
      ),
    );
  }
}
