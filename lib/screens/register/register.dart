import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comrade/models/user.dart' as Comrade;
import 'package:comrade/profile/edit_profile.dart';
import 'package:comrade/screens/login/login.dart';
import 'package:comrade/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../homepage.dart';

void main() => runApp(const RegisterPage());

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController birthYearController = TextEditingController();

  late Comrade.User user;

  String sex = 'M';
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> sex = [
      DropdownMenuItem(child: Text("M"), value: "M"),
      DropdownMenuItem(child: Text("F"), value: "F"),
    ];
    return sex;
  }

  void goToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  void signUp() async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passController.text,
          )
          .then((credential) async => {
                user = Comrade.User(
                  credential.user!.uid,
                  'profile picture urs',
                  nameController.text,
                  emailController.text,
                  birthYearController.text,
                  sex,
                ),
                await FirebaseFirestore.instance
                    .collection("Users")
                    .doc(user.uid.toString())
                    .set(user.toJson())
              });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passController.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              CustomTextField(
                controller: emailController,
                hint: 'Enter your email.',
              ),
              CustomTextField(
                controller: passController,
                hint: 'Create a password.',
              ),
              Container(
                margin: const EdgeInsets.all(5),
                child: DropdownButton(
                    value: sex,
                    onChanged: (String? newValue) {
                      setState(() {
                        sex = newValue!;
                      });
                    },
                    items: dropdownItems),
              ),
              CustomTextField(
                  controller: birthYearController, hint: 'year of birth'),
              ElevatedButton(
                onPressed: () => {
                  signUp(),
                  goToLogin(),
                },
                child: Text('SIGN UP'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
