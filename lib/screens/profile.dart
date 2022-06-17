import 'package:flutter/material.dart';

void main() => runApp(UserProfile());
// The main() class is here for debbuging purposes

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.flag_sharp),
          title: const Text("Frankfurt"),
          actions: const [
            Text("M26"),
          ],
        ),
        body: Column(
          children: [
            Container(
              child: Image.asset("aa"),
            ),
            Container(
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              child: const Text(
                "@ag",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w100,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
