import 'package:flutter/material.dart';

import 'package:comrade/profile/edit_profile.dart';
import 'package:comrade/profile/profile.dart';
import 'package:comrade/screens/add_event.dart';
import 'package:comrade/screens/feed.dart';
import 'package:comrade/screens/register/register.dart';

class HomePage extends StatefulWidget {
  int selectedIndex;
  HomePage({
    Key? key,
    this.selectedIndex = 0,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _navigateBottomBar(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    Feed(),
    AddEvent(),
    UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[widget.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.selectedIndex,
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
