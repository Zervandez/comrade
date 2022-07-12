import 'package:comrade/profile/edit_profile.dart';
import 'package:comrade/screens/add_event.dart';
import 'package:comrade/screens/feed.dart';
import 'package:comrade/profile/profile.dart';
import 'package:comrade/screens/register/register.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    Feed(),
    AddEvent(),
    UserProfile(),
    RegisterPage(),
    EditProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _navigateBottomBar,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.feed), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
          ]),
    );
  }
}
