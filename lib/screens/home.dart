import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kuunga_app/screens/chat_screen.dart';
import 'package:kuunga_app/screens/search_screen.dart';
import 'package:provider/provider.dart';

import '../decorations/styles.dart';

class Home extends StatefulWidget {
  final String? nickName;
  const Home({super.key, this.nickName});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final FirebaseAutheticate _firebaseAccess = FirebaseAutheticate();
  // CollectionReference user = FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    final jay = Provider.of<User?>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Padding(
              padding: const EdgeInsets.fromLTRB(120, 0, 0, 0),
              child: Text(widget.nickName.toString()))),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: 760,
          decoration: Styles.bgColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Chat Collection')
                    .where('id', isNotEqualTo: jay!.email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    Center(
                      child: Text(
                        "Something went wrong",
                        style: Styles.headLine1,
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return SizedBox(
                      height: 700,
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var friends = snapshot.data!.docs[index];
                            // var friendId = snapshot.data!.docs[index]['id'];
                            // var lastMsg = snapshot.data!.docs[index]['date'];
                            return ListTile(
                                leading: const CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/IMG_20220523_100525_738.jpg'),
                                  radius: 40,
                                ),
                                title: Text(friends['nickName']),
                                subtitle: SizedBox(
                                    child: Text(
                                  friends['id'],
                                  overflow: TextOverflow.ellipsis,
                                )),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            ChatScreen(
                                          user: jay,
                                          friendImage: friends['image'],
                                          nickName: friends['nickName'],
                                          friendId: friends['id'],
                                        ),
                                      ));
                                });
                          }),
                    );
                  }
                  return const Center(
                    child: SpinKitDancingSquare(color: Colors.yellow),
                  );
                },
              ),
              SizedBox(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const SearchScreen()));
                  },
                  icon: const Icon(Icons.search),
                  label: const Text('search chat'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
