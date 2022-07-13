import 'dart:html';
import 'dart:ui';

import 'package:comrade/homepage.dart';
import 'package:comrade/screens/feed.dart';
import 'package:comrade/screens/register/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    emailController.addListener(() => setState(() {}));
    passwordController.addListener(() => setState(() {}));
  }

  void sendToRegister(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  void goToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(
                selectedIndex: 2,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: EdgeInsets.only(top: 50),
          // margin: const EdgeInsets.all(10),
          height: 100.0,
          width: 100.0,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/comrade_logo.jpeg'),
              fit: BoxFit.cover,
            ),
            //shape: BoxShape.circle,
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: const Text(
            "Ein echtes soziales Netzwerk.",
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Column(
          children: [
            Container(
              child: RichText(
                text: TextSpan(
                    text: 'No account yet?',
                    style: TextStyle(color: Colors.blueAccent),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        sendToRegister(context);
                      }),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.go,
                controller: emailController,
                decoration: InputDecoration(
                  suffixIcon: emailController.text.isEmpty
                      ? Container(width: 0)
                      : IconButton(
                          onPressed: () => emailController.clear(),
                          icon: Icon(Icons.close),
                        ),
                  labelText: 'Enter your E-Mail',
                  hintText: "maxmusterman@web.de",
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    gapPadding: 0.0,
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red, width: 1.5),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: TextField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.go,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Enter your Password',
                    //hintText: "",
                    suffixIcon: passwordController.text.isEmpty
                        ? Container(width: 0)
                        : IconButton(
                            onPressed: () => passwordController.clear(),
                            icon: Icon(Icons.close),
                          ),

                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      gapPadding: 0.0,
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.red, width: 1.5),
                    ),
                  ),
                  onSubmitted: (_) => {
                        loginToFirebase(
                            emailController.text, passwordController.text),
                      }),
            ),
          ],
        ),
      ],
    ));
  }

  Future<void> loginToFirebase(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        goToProfile();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("User doesn't exist.")));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Wrong password provided for that user.")));
        //
      }
    }
  }
}
