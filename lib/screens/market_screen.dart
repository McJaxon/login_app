import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MarketScreen extends StatefulWidget {
  final User? currentUser;
  // final dynamic currentUser;
  const MarketScreen({super.key, this.currentUser});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  void _showDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1998),
        lastDate: DateTime(2050));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
            child: Text('Calendar'),
          ),
        ),
        body: Center(
          child: MaterialButton(
            onPressed: _showDatePicker,
            color: Colors.blueGrey,
            child: const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Choose Date',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
        ));
  }
}
