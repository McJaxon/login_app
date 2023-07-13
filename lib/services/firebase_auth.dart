// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kuunga_app/services/isaac.dart';

import 'firestore.dart';

// User? user = FirebaseAuth.instance.currentUser;
// String? chatId = user?.uid;

class FirebaseAutheticate extends ChangeNotifier {
  final FirebaseAuth autheticate = FirebaseAuth.instance;
  // String getUid() => autheticate.currentUser!.uid;

  Oscar? userFromFirebase(User? user) {
    return user != null ? Oscar(uid: user.uid, id: user.email) : null;
    // if (users != null) {
    //   return Oscar(uid: users.uid);
    // } else {
    //   return null;
    // }
  }

  Stream<User?> get streamer {
    return autheticate.authStateChanges().map((User? user) => user);
  }

  Future createAccount(String email, String password) async {
    try {
      UserCredential result = await autheticate.createUserWithEmailAndPassword(
          email: email, password: password);
      User? users = result.user;
      await FireStoreAuth()
          .snapShot(users!.email, 'nickName', 'image', 'date', users.uid);
      // .then((value) => FireStoreAuth()
      //     .chatFirestore
      //     .doc(users.email)
      //     .collection('messages')
      //     .doc()
      //     .collection('Chats'));
      return users;
    } catch (e) {
      print(e.toString());
    }
  }

  Future signWithPhone(dynamic phoneNumber) async {
    try {
      ConfirmationResult? results =
          await autheticate.signInWithPhoneNumber(phoneNumber);
      String user = results.verificationId;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential result = await autheticate.signInWithEmailAndPassword(
          email: email, password: password);
      User? users = result.user;
      FireStoreAuth()
          .chatFirestore
          .doc(users!.email)
          .collection('messages')
          .doc()
          .collection('Chats');
      return users;
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      await autheticate.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
