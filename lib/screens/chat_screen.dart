import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kuunga_app/decorations/message_text.dart';

import '../decorations/single_message.dart';

class ChatScreen extends StatefulWidget {
  final User? user;
  final String? friendId;
  final String? nickName;
  final String friendImage;

  const ChatScreen({
    super.key,
    this.user,
    required this.friendId,
    required this.nickName,
    required this.friendImage,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final textController = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          const CircleAvatar(
            backgroundImage:
                AssetImage('assets/images/IMG_20220523_100525_738.jpg'),
            radius: 25,
          ),
          const SizedBox(width: 15),
          Center(
            child: Text(
              widget.nickName.toString(),
              style: const TextStyle(fontSize: 20),
            ),
          )
        ],
      )),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 680,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Chat Collection')
                      .doc(widget.user!.email)
                      .collection('messages')
                      .doc(widget.friendId)
                      .collection('Chats')
                      .orderBy('date', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: Text('say hi'),
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          reverse: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            bool isMe = snapshot.data!.docs[index]
                                    ['SenderId'] ==
                                widget.user!.email;
                            return SingleMessage(
                                message: snapshot.data!.docs[index]['msg'],
                                isMe: isMe);
                          });
                    } else {
                      return const Center(
                        child: SpinKitDancingSquare(color: Colors.yellow),
                      );
                    }
                  }),
            ),
            MessageTextField(
              currentId: widget.user!.email,
              friendId: widget.friendId,
              nickName: widget.nickName,
            )
          ],
        ),
      ),
    );
  }
}
