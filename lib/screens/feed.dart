import 'package:flutter/material.dart';
import '../widgets/single_event_feed.dart';

void main() => runApp(const Feed());
// The main() class is here for debbuging purposes

class Feed extends StatelessWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Frankfurt'),
          actions: [],
        ),
        body: Column(
          children: const [
            SingleEvent(),
            SingleEvent(),
            SingleEvent(),
            SingleEvent(),
          ],
        ),
      ),
    );
  }
}
