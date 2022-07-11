import 'package:class3julyfirebase/constants/clr.dart';
import 'package:class3julyfirebase/functions/button.dart';
import 'package:class3julyfirebase/functions/textField.dart';
import 'package:class3julyfirebase/pages/home.dart';
import 'package:class3julyfirebase/pages/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
SharedPreferences? prefs;

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(Colorconst.bgcolor),
      appBar: AppBar(
        title: Text('Login Page'),
        backgroundColor: Colors.black,
      ),
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Enter ID and Password to Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            height: 80,
            width: double.infinity,
          ),
          Padding(
              padding: EdgeInsets.all(5.0),
              child: customTextField(
                  context, emailController, 'Enter your Email')),
          Padding(
              padding: EdgeInsets.all(5),
              child: customTextField(
                  context, passwordController, 'Enter Your Password')),
          custombutton(() async {
            try {
              UserCredential userCredential = await FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text);
              save(context);
            } on FirebaseAuthException catch (e) {
              if (e.code == 'user-not-found') {
                print('No user found for that email.');
              } else if (e.code == 'wrong-password') {
                print('Wrong password provided for that user.');
              }
            }
          }, 'Login', context),
          SizedBox(
            width: MediaQuery.of(context).size.width * .7,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 30.0,
                      width: 30.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/google.png'),
                            fit: BoxFit.cover),
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Sign In with Google",
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),

                // by onpressed we call the function signup function
                onPressed: () {
                  signInWithGoogle();
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Column(
              children: [
                Text(
                  'Don\'t have an account?',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                custombutton(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signup()),
                  );
                }, 'Sign Up', context)
              ],
            ),
          )
        ],
      ),
    );
  }

  save(context) async {
    await SharedPreferences.getInstance();
    prefs?.setString('email', emailController.text.toString());
    prefs?.setString('password', passwordController.text.toString());
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
