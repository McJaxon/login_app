import 'package:flutter/material.dart';
import 'package:kuunga_app/decorations/loading.dart';
import 'package:kuunga_app/decorations/styles.dart';
import 'package:kuunga_app/screens/open_screen.dart';
import 'package:kuunga_app/services/firebase_auth.dart';

class LogInScreen extends StatefulWidget {
  final VoidCallback switchlogin;
  const LogInScreen({super.key, required this.switchlogin});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final String? nickName = '';
  String error = '';

  String email = '';

  String password = '';

  bool loading = false;

  final FirebaseAutheticate _firebaseAccess = FirebaseAutheticate();

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // void signIn() async {
  // showDialog(
  //   context: context,
  //     builder: (context) => const Center(
  //       child: CircularProgressIndicator(
  //          color: Colors.black,
  //   ),
  // ));
  //   try {
  //     UserCredential _results = await _firebaseAccess.signIn(
  //         _emailController.text, _passwordController.text);
  //     // User? _users = _results.user;
  //   } on FirebaseException catch (e) {
  //     Navigator.pop(context);
  //     return displayMessage('Couldn\'t signIn');
  //   }
  // }

  // void displayMessage(String messages) {
  //   showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             title: Text(
  //               messages,
  //               style: const TextStyle(color: Colors.red),
  //             ),
  //           ));
  // }
  // final Authentication _controller1 = Get.put(Authentication());
  @override
  Widget build(BuildContext context) {
    // final Authentication _controller = Get.find<Authentication>();
    // final _jay = Provider.of<User?>(context, listen: false);
    return loading
        ? const Loading()
        : Scaffold(
            body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              height: 880,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          AssetImage('assets/images/IMG_20230109_211418.jpg')),
                  color: Color.fromARGB(255, 224, 170, 170)),
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
                          'Welcome back, you\'ve been missed',
                          style: Styles.headLine1
                              .copyWith(color: Styles.textColor),
                        ),
                      ),
                      SizedBox(
                        child: Text(
                          'Please logIn',
                          style: Styles.headLine2
                              .copyWith(color: Styles.textColor),
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: TextFormField(
                                validator: (value) => value!.isEmpty
                                    ? 'Please provide Email'
                                    : null,
                                controller: emailController,
                                decoration: Styles.decorations.copyWith(
                                    label: const Text('Enter Email'))),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: TextFormField(
                                validator: (val) {
                                  return val!.length < 7
                                      ? 'Invalid Password'
                                      : null;
                                },
                                obscureText: true,
                                controller: passwordController,
                                decoration: Styles.decorations.copyWith(
                                    label: const Text('Enter Password'))),
                          ),
                        ],
                      ),
                      SizedBox(
                        child: ElevatedButton.icon(
                          label: const Text(
                            'login',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          icon: const Icon(Icons.lock_open_rounded),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              _firebaseAccess
                                  .signIn(emailController.text,
                                      passwordController.text)
                                  .then((results) {
                                if (results != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (context) =>
                                          const OpeningScreen(),
                                    ),
                                  );
                                }

                                return setState(() {
                                  error = 'could not sign in with credentials';
                                  loading = false;
                                });
                              });
                              // print(email);
                              // print(password);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                          child: Text(
                        'or login with ',
                        style: Styles.headLine2,
                      )),
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
                              icon: const Icon(
                                Icons.facebook_outlined,
                                color: Color.fromARGB(255, 5, 79, 139),
                              ),
                              onPressed: () {},
                              label: const Text('FaceBook')),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Not a member?..',
                            style: Styles.headLine2,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextButton(
                              onPressed: widget.switchlogin,
                              child: const Text(
                                'SignUp Now',
                                style: TextStyle(fontSize: 17),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ));
  }
}
