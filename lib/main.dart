import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // In here, we check if the user is logged in and redirect accordingly

  Future<String> getAllUsers() async {
    var response = await http.get(Uri.parse('http://10.0.0.2:8000/users'));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Ya lost, bobby!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Comrade',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
            child: FutureBuilder<String>(
                future: getAllUsers(),
                builder: (context, snapshot) {
                  print(snapshot.data);
                  if (snapshot.hasData && snapshot.data != null) {
                    //return Text(snapshot.data);
                  }
                  return const CircularProgressIndicator();
                })),
      ),
    );
  }
}
