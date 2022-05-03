import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

Future<void> main() async {
  runApp(const MyApp());

  // Open a connection (testdb should already exist)
  final connection = await MySqlConnection.connect(ConnectionSettings(
    host: 'remotemysql.com',
    port: 3306,
    user: 'hCH4aiPp8x',
    password: 'KVnMFqzSfi',
    db: 'User',
  ));
  var results = await connection.query('select * from User');
  for (var row in results) {
    print('${row[0]}');
  }

  // Finally, close the connection
  //await connection.close();
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
