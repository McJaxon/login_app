import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kuunga_app/screens/open_screen.dart';
import 'package:kuunga_app/screens/register.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});
  @override
  Widget build(BuildContext context) {
    // const String nickName = '';
    final user = Provider.of<User?>(context);

    if (user == null) {
      return const RegisterScreen();
    } else {
      return const OpeningScreen();
    }
    //   body: StreamBuilder(
    //     stream: FirebaseAutheticate().streamer,
    //     builder: (context, snapshot) {
    //       print('xxxxxxx from wrapper $snapshot');
    //       if (snapshot.hasData) {
    //         return const OpeningScreen();
    //       } else {
    //         return const RegisterScreen();
    //       }
    //     },
    //   ),
    // );
  }
}
