import 'package:flutter/material.dart';
import '../util/textFields.dart';

void main() => runApp(const LoginPage());

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: const PhoneField(),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: NormalTextField("hallochen"),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: EmailValidation(),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: const PasswordFieldClass(),
            ),
          ],
        ),
      ),
    );
  }
}
