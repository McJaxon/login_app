import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kuunga_app/services/isaac2.dart';

class FireStoreAuth extends ChangeNotifier {
  // final userUid = FirebaseAuth.instance.currentUser!.uid;
  // final userEmail = FirebaseAuth.instance.currentUser!.email;
  CollectionReference chatFirestore =
      FirebaseFirestore.instance.collection('Chat Collection');

  Future snapShot(
      String? email, String name, String image, String date, String uid) {
    return chatFirestore.doc().set({
      'id': FirebaseAuth.instance.currentUser!.email,
      'nickName': '',
      'image': image,
      'date': DateTime.now().hour.toString(),
      'uid': FirebaseAuth.instance.currentUser!.uid
    });
  }

  List<Isaac> oscarListFromSnapShot(dynamic snapshot) {
    return snapshot.docs.map((docs) {
      return snapshot != null
          ? Isaac(
              uid: docs.data['uid'] ?? '',
              id: docs.data['id'] ?? '',
              name: docs.data['nickName'] ?? '',
              image: docs.data['image'] ?? '',
              date: docs.data['date'] ?? '',
            )
          : null;
    }).toList();
  }

  Stream<List<Isaac>> get streamer {
    return chatFirestore
        .snapshots()
        .map((dynamic snapshot) => oscarListFromSnapShot(snapshot));
  }
}
