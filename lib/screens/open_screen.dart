import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuunga_app/decorations/styles.dart';
import 'package:kuunga_app/screens/check_profile.dart';
import 'package:kuunga_app/screens/forum.dart';
import 'package:kuunga_app/screens/home.dart';
import 'package:kuunga_app/screens/market_screen.dart';
import 'package:kuunga_app/screens/register.dart';
import 'package:kuunga_app/services/firebase_auth.dart';
import 'package:provider/provider.dart';

class OpeningScreen extends StatefulWidget {
  final String? nickName;
  final User? user;
  const OpeningScreen({this.user, this.nickName, super.key});

  @override
  State<OpeningScreen> createState() => _OpeningScreenState();
}

class _OpeningScreenState extends State<OpeningScreen> {
  final FirebaseAutheticate _firebaseAccess = FirebaseAutheticate();
  final Authentication controller1 = Get.put(Authentication());
  @override
  Widget build(BuildContext context) {
    // final Authentication controller = Get.find<Authentication>();
    final jay = Provider.of<User?>(context);
    return Scaffold(
        body: ListView(
      children: [
        Container(
          height: 880,
          decoration: Styles.bgColor,
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: [
                const SizedBox(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/IMG_love.jpg'),
                    radius: 150,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 600,
                        height: 70,
                        child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.telegram_sharp,
                              size: 39,
                              color: Color.fromARGB(255, 224, 170, 170),
                            ),
                            label: Text(
                              'Chats',
                              style: Styles.headLine2
                                  .copyWith(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute<void>(builder: (context) {
                                return Home(
                                  nickName: widget.nickName,
                                );
                              }));
                            }),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 600,
                        height: 70,
                        child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.text_snippet,
                              size: 39,
                              color: Color.fromARGB(255, 224, 170, 170),
                            ),
                            label: Text(
                              'Trends',
                              style: Styles.headLine2
                                  .copyWith(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute<void>(builder: (context) {
                                return Trends(
                                  currentUser: jay,
                                );
                              }));
                            }),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 600,
                        height: 70,
                        child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.calendar_month_outlined,
                              size: 39,
                              color: Color.fromARGB(255, 224, 170, 170),
                            ),
                            label: Text(
                              'Calender',
                              style: Styles.headLine2
                                  .copyWith(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute<void>(builder: (context) {
                                return MarketScreen(
                                  currentUser: jay,
                                );
                              }));
                            }),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                ElevatedButton.icon(
                    onPressed: () async {
                      await _firebaseAccess.signOut().then((value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterScreen()));
                      });
                    },
                    icon: const Icon(
                      Icons.logout_outlined,
                      size: 35,
                      color: Color.fromARGB(255, 224, 170, 170),
                    ),
                    label: Text(
                      'SignOut',
                      style: Styles.headLine2.copyWith(color: Colors.black),
                    ))
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
