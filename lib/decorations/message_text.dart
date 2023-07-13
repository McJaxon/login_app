import 'package:flutter/material.dart';
import 'package:kuunga_app/services/firestore.dart';

class MessageTextField extends StatefulWidget {
  final String? currentId;
  final String? friendId;
  final String? nickName;
  const MessageTextField(
      {required this.currentId,
      required this.friendId,
      this.nickName,
      super.key});
  @override
  State<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  final FireStoreAuth _accessFireStore = FireStoreAuth();
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final jay = Provider.of<Oscar?>(context);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextFormField(
            showCursor: true,
            cursorColor: Colors.black,
            maxLines: null,
            controller: _textController,
            decoration: InputDecoration(
                labelText: 'message mate',
                fillColor: Colors.grey,
                filled: true,
                border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 0),
                    gapPadding: 10,
                    borderRadius: BorderRadius.circular(25))),
          )),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () async {
              String messages = _textController.text;
              _textController.clear();
              // setState(() {
              //   String text = messages;
              // });

              await _accessFireStore.chatFirestore
                  .doc(widget.currentId)
                  .collection('messages')
                  .doc(widget.friendId)
                  .collection('Chats')
                  .add({
                'nickName': widget.nickName,
                'msg': messages,
                'date': DateTime.now().hour.toString(),
                'SenderId': widget.currentId,
                'receiverId': widget.friendId
              }).then((value) {
                _accessFireStore.chatFirestore
                    .doc(widget.currentId)
                    .collection('messages')
                    .doc(widget.friendId)
                    .set({'last_msg': messages});
              });
              await _accessFireStore.chatFirestore
                  .doc(widget.friendId)
                  .collection('messages')
                  .doc(widget.currentId)
                  .collection('Chats')
                  .add({
                'nickName': widget.nickName,
                'msg': messages,
                'date': DateTime.now().hour.toString(),
                'SenderId': widget.currentId,
                'receiverId': widget.friendId
              }).then((value) {
                _accessFireStore.chatFirestore
                    .doc(widget.friendId)
                    .collection('messages')
                    .doc(widget.currentId)
                    .set({'last_msg': messages});
              });
            },
            child: Container(
              padding: const EdgeInsets.all(7),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.blue),
              child: const Icon(Icons.forward_to_inbox, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
