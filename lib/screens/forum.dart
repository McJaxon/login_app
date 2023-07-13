import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kuunga_app/screens/news/article.dart';
import 'package:kuunga_app/screens/news/new_controller.dart';

class Trends extends StatefulWidget {
  final User? currentUser;
  // final dynamic currentUser;
  const Trends({
    super.key,
    this.currentUser,
  });

  @override
  State<Trends> createState() => _TrendsState();
}

class _TrendsState extends State<Trends> {
  final NewsController _newsController = Get.put(NewsController());
  var client = http.Client();
  Future<List<dynamic>> fetchNews() async {
    const apiKey = '19cff019148147adb11f03f19993e3ad';
    const apiUrl =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    final response = await client.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      // final jsonBody = json.decode(response.body);
      // final articles = jsonBody['articles'];
      return articlesFromJson(response.body);
    } else {
      throw Exception('No results');
    }
  }

  String currentUserUid = '';
  String currentUserName = '';

  CollectionReference user = FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: const Text('News Updates'),
        ),
        body: Obx(
          () => _newsController.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: _newsController.articles.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.purple)),
                      child: Center(
                        child: Text(
                          _newsController.articles[index].title!,
                          style: const TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w400),
                        ),
                      ),
                    );
                  }),
        ));
  }
}
