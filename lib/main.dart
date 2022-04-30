import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // In here, we check if the user is logged in and redirect accordingly

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Comrade',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: null,
    );
  }
}
