// import 'package:flutter/material.dart';

// class CardList extends StatefulWidget {
//   final int chatIndex = 0;
//   List<Map<String, dynamic>> chatList = [];
//   final String name;
//   final dynamic age;
//   final String location;
//   final String image;
//   CardList(
//       {required this.chatList,
//       required this.name,
//       required this.age,
//       required this.location,
//       required this.image,
//       super.key});

//   @override
//   State<CardList> createState() => _CardListState();
// }

// class _CardListState extends State<CardList> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 10,
//       child: Row(
//         children: <Widget>[
//           Container(
//               width: 80,
//               height: 80,
//               decoration: BoxDecoration(
//                   border: Border.all(color: Colors.black),
//                   shape: BoxShape.circle),
//               margin: const EdgeInsets.all(10),
//               child: CircleAvatar(
//                   backgroundImage:
//                       AssetImage('assets/images/${widget.image}'))),
//           Container(
//             margin: const EdgeInsets.only(right: 190),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.name,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.w800, fontSize: 18),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   widget.age.toString(),
//                   style: const TextStyle(
//                       fontWeight: FontWeight.w600, fontSize: 15),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   widget.location,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.w400, fontSize: 18),
//                 )
//               ],
//             ),
//           ),
//           const SizedBox(width: 10),
//           IconButton(
//             color: Colors.red,
//             icon: const Icon(Icons.delete),
//             onPressed: () {
//               setState(() {
//                 widget.chatList.removeAt(0);
//               });
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
