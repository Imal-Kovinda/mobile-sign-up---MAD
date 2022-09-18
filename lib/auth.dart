import 'package:autho/land.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';
import 'home.dart';
import 'land.dart';
import 'google.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  //edit
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  final db = FirebaseFirestore.instance;

  // get Provider => null;

  // get _googleSignIn => null;

  @override
  printText(String text) {
    final user = <String, dynamic>{"user name": text};

    db.collection("users").add(user).then((DocumentReference doc) =>
        print('DocumentSnapshot added with ID: ${doc.id}'));
    print(text);
  }

  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.only(top: 50.0, left: 10.0, right: 10.0),
              child: TextField(
                controller: _email,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 10.0, right: 10.0),
              child: TextField(
                obscureText: true,
                controller: _password,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
                height: 60,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  child: const Text('Sign In'),
                  onPressed: () {
                    login();
                    LandState();
                    print(_email.text);
                    print(_password.text);
                  },
                )),
            Container(
                height: 60,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton(
                  child: const Text('Sign Up'),
                  onPressed: () {
                    signupFun();
                    LandState();
                    print(_email.text);
                    print(_password.text);
                  },
                )),
            Container(
              padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
              child: Center(
                child: Text(
                  'OR',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
                height: 60,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: ElevatedButton.icon(
                    style: ButtonStyle(),
                    onPressed: () {
                      myGoogle();
                      // final provider =
                      //     Provider.of<GoogleSignIn>(context, listen: false);
                      // provider.googleLogin();
                      // GoogleSignIn();
                      print(_email.text);
                      print(_password.text);
                    },
                    icon: Icon(
                      Icons.login,
                      size: 20.0,
                    ),
                    label: Text('Google Sign In'))),
          ],
        ));
  }

  login() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  signupFun() async {
    printText('successfully signed up');
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  myGoogle() async {
    print('hi');
  }
}
