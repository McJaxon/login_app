import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kuunga_app/decorations/loading.dart';
import 'package:kuunga_app/decorations/styles.dart';
import 'package:kuunga_app/screens/check_profile.dart';
import 'package:kuunga_app/screens/open_screen.dart';
import 'package:kuunga_app/services/firestore.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  final User? user;
  const ProfileScreen({this.user, super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  _ProfileScreenState() {
    _index = countries[0];
  }

  String? _index = '';
  int age = 0;
  String country = '';
  bool loading = false;
  final List countries = [
    'United Kingdom',
    'United States',
    'Uganda',
    'Kenyan',
    'Tanzania',
    'China',
    'South Africa',
    'Japan',
    'Nigeria',
    'Korea'
  ];
  final _formkey = GlobalKey<FormState>();

  // final FirebaseAutheticate _accessFirebase = FirebaseAutheticate();

  final FireStoreAuth _acccessFireStore = FireStoreAuth();

  String? error = '';
  final nickNameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();

  final Authentication controller1 = Get.put(Authentication());
  @override
  Widget build(BuildContext context) {
    // final Authentication controller = Get.find<Authentication>();
    final jay = Provider.of<User?>(context);
    return loading
        ? const Loading()
        : Scaffold(
            body: ListView(
            children: [
              Container(
                height: 900,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                    // backgroundBlendMode: BlendMode.darken,
                    color: Color.fromARGB(255, 224, 170, 170)),
                child: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Text(
                        'Create Bio',
                        style:
                            Styles.headLine1.copyWith(color: Styles.textColor),
                      ),
                      Text(
                        'to get started now!',
                        style:
                            Styles.headLine2.copyWith(color: Styles.textColor),
                      ),
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: TextFormField(
                                controller: nickNameController,
                                decoration: Styles.decorations
                                    .copyWith(label: const Text('Nick Name'))),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: TextFormField(
                              obscureText: true,
                              controller: ageController,
                              decoration: Styles.decorations
                                  .copyWith(label: const Text('Age')),
                              validator: (val) {
                                return val!.isEmpty
                                    ? 'Please provide with Age'
                                    : null;
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: TextFormField(
                              obscureText: true,
                              controller: phoneController,
                              decoration: Styles.decorations
                                  .copyWith(label: const Text('Phone Number')),
                              validator: (val) {
                                return val!.isEmpty ? 'Invalid Password' : null;
                              },
                            ),
                          ),
                          SizedBox(
                            child: DropdownButton(
                              alignment: Alignment.topRight,
                              value: _index,
                              underline: DecoratedBox(
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(style: BorderStyle.none))),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(40)),
                              icon: const Icon(Icons.arrow_drop_down),
                              dropdownColor:
                                  const Color.fromARGB(0, 24, 24, 24),
                              items: countries
                                  .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                        e,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      )))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  _index = val as String;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              // if (controller1.phoneController.text.isEmpty) {
                              //   SnackBar mySnackBar = const SnackBar(
                              //       content: Text("Please enter your number"));
                              //   ScaffoldMessenger.of(context)
                              //       .showSnackBar(mySnackBar);
                              // }

                              // dynamic results = await _accessFirebase
                              //     .signWithPhone(phoneNumberController);
                              setState(() {
                                loading = true;
                              });
                              _acccessFireStore.chatFirestore
                                  .doc(jay!.email)
                                  .update({
                                'nickName': nickNameController.text,
                              });
                              if (context.mounted) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            OpeningScreen(
                                              nickName: nickNameController.text,
                                              user: jay,
                                            )));
                              }
                              return;
                              // await _accessFirebase
                              //     .createAccount(
                              //         controller.emailController.text,
                              //         controller.passwordController.text)
                              //     .then((value) {
                              //   _acccessFireStore.chatFirestore
                              //       .doc(jay!.email)
                              //       .update({
                              //     'nickName':
                              //         controller.nickNameController.text,
                              //   });
                              //   if (value != null) {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute<void>(
                              //             builder: (BuildContext context) =>
                              //                 OpeningScreen(user: value)));
                              //   }
                              //   return setState(() {
                              //     error = 'could not sign in with credentials';
                              //     loading = false;
                              //   });
                              // });

                              // Phoenix.rebirth(context);
                            }
                          },
                          child: const Text('Continue'),
                        ),
                      ),
                      SizedBox(
                        child: TextButton.icon(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel_rounded,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'cancel',
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                    ],
                  ),
                ),
              )
            ],
          ));
  }
}
