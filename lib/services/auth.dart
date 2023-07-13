// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// enum status {
//   uninitialized,
//   authenticated,
//   authenticating,
//   authenticateError,
//   uuthenticateCanceled,
// }

// class AuthProvider extends ChangeNotifier {
//   final GoogleSignIn googleSignIn;
//   final FirebaseAuth firebaseAuth;
//   final FirebaseFirestore firebaseFirestore;
//   final SharedPreferences prefs;
//   Status get status => status;
//   AuthProvider({
//     required this.firebaseAuth,
//     required this.firebaseFirestore,
//     required this.googleSignIn,
//     required this.prefs,
//   });
//   String? getUserFirebase(User? user) {
//     return prefs.getString(user!.uid);
//   }

//   Future googleUser(dynamic user) async {
//     try {
//       bool results = await googleSignIn.isSignedIn();
//       if (googleUser && prefs.getString(user)?. isEmpty == true) {
//         return true;
//       }
//     } catch (e) {}
//   }
// }
