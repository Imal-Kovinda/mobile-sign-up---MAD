import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth.dart';

class GoogleSignIn extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  get _googleSignIn => null;

  Future googleLogin() async {
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    // notifyListeners();
  }

  //signIn function
  Future<void> signIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (e) {
      print('Error singing in $e');
    }
  }
}

// class _GoogleSignInState extends State<GoogleSignIn> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp();
//   }
// }
