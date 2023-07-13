import 'package:flutter/material.dart';

class SingleMessage extends StatelessWidget {
  final String message;
  final bool isMe;
  const SingleMessage({
    required this.isMe,
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          constraints: const BoxConstraints(maxWidth: 200),
          decoration: BoxDecoration(
              color: isMe ? Colors.blueGrey : Colors.orange,
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          child: Text(
            message,
            style: const TextStyle(color: Colors.white, fontSize: 17),
          ),
        )
      ],
    );
  }
}
