import 'package:flutter/material.dart';
import 'package:kuunga_app/decorations/loading.dart';
import 'package:kuunga_app/decorations/styles.dart';
import 'package:kuunga_app/screens/profile_screen.dart';

import '../services/firebase_auth.dart';
// import 'package:kuunga_app/services/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback switchSignUp;
  const SignUpScreen({required this.switchSignUp, super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final FirebaseAutheticate _accessFirebase = FirebaseAutheticate();
  final _formKey = GlobalKey<FormState>();
  void displayMessage(String messages) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              messages,
              style: const TextStyle(color: Colors.red),
            ),
          );
        });
    Navigator.pop(context);
  }

  // final Authentication _controller = Get.put(Authentication());
  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            body: ListView(
            children: [
              Container(
                height: 880,
                padding: const EdgeInsets.all(10),
                decoration: Styles.bgColor,
                child: SizedBox(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        const SizedBox(
                            child: Icon(
                          Icons.heart_broken,
                          color: Colors.red,
                          size: 50,
                        )),
                        SizedBox(
                          child: Text(
                            'Welcome..',
                            style: Styles.headLine2
                                .copyWith(color: Styles.textColor),
                          ),
                        ),
                        Text(
                          'Get started now!',
                          style: Styles.headLine2
                              .copyWith(color: Styles.textColor),
                        ),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: TextFormField(
                                controller: emailController,
                                decoration: Styles.decorations
                                    .copyWith(label: const Text('Enter Email')),
                                validator: (val) {
                                  return val!.isEmpty ? 'Provide Email' : null;
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: TextFormField(
                                obscureText: true,
                                controller: passwordController,
                                decoration: Styles.decorations.copyWith(
                                    label: const Text('Create Password')),
                                validator: (val) {
                                  return val!.length < 7
                                      ? 'Invalid Password'
                                      : null;
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: TextFormField(
                                obscureText: true,
                                controller: confirmPasswordController,
                                decoration: Styles.decorations.copyWith(
                                    label: const Text('Confirm Password')),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          child: ElevatedButton(
                            onPressed: () {
                              if (passwordController.text !=
                                  confirmPasswordController.text) {
                                Navigator.pop(context);
                                displayMessage('Passwords dont match');
                                return;
                              }

                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });

                                _accessFirebase.createAccount(
                                    emailController.text,
                                    passwordController.text);
                                if (context.mounted) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              const ProfileScreen()));
                                } else {
                                  return setState(() {
                                    error =
                                        'could not sign in with credentials';
                                    loading = false;
                                  });
                                }

                                // print(email);
                                // print(password);
                              }
                            },
                            child: const Text('Sign Up'),
                          ),
                        ),
                        Text(
                          'or Sign up with ',
                          style: Styles.headLine2
                              .copyWith(color: Styles.textColor),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(
                              width: 100,
                            ),
                            ElevatedButton.icon(
                                icon: const Icon(Icons.phone),
                                onPressed: () {},
                                label: const Text('Phone')),
                            const SizedBox(
                              width: 10,
                            ),
                            ElevatedButton.icon(
                                icon: const Icon(Icons.facebook_outlined),
                                onPressed: () {},
                                label: const Text('FaceBook')),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account?'),
                            TextButton(
                                onPressed: widget.switchSignUp,
                                child: const Text('login Now'))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ));
  }
}
