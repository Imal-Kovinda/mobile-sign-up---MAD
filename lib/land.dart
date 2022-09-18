import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';
import 'auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:googlesign/homepage.dart';

class LandState extends StatefulWidget {
  const LandState({Key? key}) : super(key: key);

  @override
  State<LandState> createState() => _LandState();
}

class _LandState extends State<LandState> {
  Future<FirebaseApp> _initializerFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  //google sign in

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Home();
          } else {
            return SignIn();
          }
        },
      ),
    );
  }
}
