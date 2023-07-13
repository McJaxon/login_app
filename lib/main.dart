import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:kuunga_app/screens/wrapper.dart';
import 'package:kuunga_app/services/firebase_auth.dart';
import 'package:kuunga_app/services/firestore.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FirebaseAutheticate()),
        ChangeNotifierProvider(create: (context) => FireStoreAuth()),
      ],
      child: Phoenix(
        child: MyApp(
          prefs: prefs,
        ),
      )));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  MyApp({required this.prefs, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Wrapper(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
    );
  }
}
