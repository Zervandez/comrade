import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comrade/models/event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../widgets/single_event_feed.dart';

class Feed extends StatefulWidget {
  Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<Object> _eventsList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEventsList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text('Feed'),
      ),
      body: ListView.builder(
        itemCount: _eventsList.length,
        itemBuilder: (context, index) {
          Event e = _eventsList[index] as Event;
          return Card(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(4),
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/sabba_profile_pic.jpg'),
                          fit: BoxFit.cover,
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          e.title.toString(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('author')
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Future getEventsList() async {
    //final uid = FirebaseAuth.instance.currentUser?.uid;
    var data = await FirebaseFirestore.instance
        .collection('Events')
        .orderBy('date')
        .get();

    setState(() {
      _eventsList =
          List.from(data.docs.map((data) => Event.fromSnapshot(data)));
    });
  }
}
