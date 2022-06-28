import 'package:comrade/homepage.dart';
import 'package:comrade/screens/login/login.dart';
import 'package:comrade/screens/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final Auth _auth = Auth();
  final bool isLogged = await _auth.isLogged();
  final MyApp myApp = MyApp(
    initialRoute: isLogged ? '/homepage' : '/login',
  );
  runApp(myApp);
}

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> isLogged() async {
    try {
      final User? user = _firebaseAuth.currentUser;
      return user != null;
    } catch (e) {
      return false;
    }
  }
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  MyApp({required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CircularProgressIndicator(),
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: {
        '/login': (context) => LoginPage(),
        '/homepage': (context) => HomePage(),
      },
    );
  }
}
