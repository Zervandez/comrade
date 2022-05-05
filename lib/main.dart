import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

Future<void> main() async {
  runApp(const MyApp());

  // Open a connection (testdb should already exist)
  MySqlConnection.connect(ConnectionSettings(
          host: 'remotemysql.com',
          port: 3306,
          user: 'hCH4aiPp8x',
          password: 'KVnMFqzSfi',
          db: 'User'))
      .then((conn) {
    conn.query('select * from user').then((results) {
      List.from(results).forEach((row) {
        print('UserName: ${row[0]}, Password: ${row[1]}');
      });
      conn.close(); // closing database connection here
    });
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // In here, we check if the user is logged in and redirect accordingly

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Comrade',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Hallo'),
        ),
      ),
    );
  }
}
