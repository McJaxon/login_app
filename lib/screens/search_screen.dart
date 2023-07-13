import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kuunga_app/decorations/styles.dart';
import 'package:kuunga_app/screens/chat_screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // final FireStoreAuth _accessFireStore = FireStoreAuth();
  List<Map> searchResults = [];
  bool isLoading = false;

  void _onsearch() async {
    setState(() {
      searchResults = [];
      isLoading = true;
    });
    //  await _accessFireStore.chatFirestore
    await FirebaseFirestore.instance
        .collection('Chat Collection')
        .where('id', isEqualTo: _searchController.text)
        .get()
        .then((value) {
      if (value.docs.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('no user found')));
        setState(() {
          isLoading = false;
        });
        return;
      }
      for (var user in value.docs) {
        if (user.data()['id'] != user) {
          searchResults.add(user.data());
        }
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final jay = Provider.of<User?>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('search')),
      body: Container(
        decoration: Styles.bgColor,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                        controller: _searchController,
                        decoration: Styles.decorations.copyWith(
                            label: const Text('Enter friend\'s email'))),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      _onsearch();
                    },
                    child: const Icon(Icons.search))
              ],
            ),
            if (searchResults.isNotEmpty)
              Expanded(
                  child: ListView.builder(
                      itemCount: searchResults.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: const CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/images/IMG_20220523_100525_738.jpg'),
                            radius: 30,
                          ),
                          title: Text(searchResults[index]['nickName']),
                          subtitle: Text(searchResults[index]['id']),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                _searchController.text = '';
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                      builder: (context) => ChatScreen(
                                          user: jay,
                                          friendId: searchResults[index]['id'],
                                          nickName: searchResults[index]
                                              ['nickName'],
                                          friendImage: searchResults[index]
                                              ['image'])));
                            },
                            icon: const Icon(Icons.message),
                          ),
                        );
                      }))
            else if (isLoading = true)
              const Center(
                  child: Center(
                child: SpinKitFadingCircle(
                  color: Colors.yellow,
                ),
              ))
          ],
        ),
      ),
    );
  }
}
