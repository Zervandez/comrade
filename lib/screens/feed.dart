import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comrade/models/event.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<Event> _eventsList = [];

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
          //_eventsList.retainWhere((element) => e.city.toString() == 'F');
          //if (e.city.toString() == 'F') updateFilter(_eventsList, index);

          return Card(
            child: Flexible(
              child: Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(4),
                          height: 40,
                          width: 40,
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
                            Text(e.uid),
                          ],
                        )
                      ],
                    ),
                    //  DESCRIPTION ROW
                    Row(
                      children: [
                        Text(
                          e.description.toString(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    //  ADDRESS ROWS
                    // TIME & STREET
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(e.time.hour.toString() +
                            ':' +
                            e.time.minute.toString()),
                        Text(e.address.toString()),
                      ],
                    ),
                    //  ADDRESS ROWS
                    // DATE & CITY
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(e.date.year.toString() +
                            ' ' +
                            e.date.day.toString() +
                            ' ' +
                            e.date.month.toString()),
                        Text(e.city.toString()),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future getEventsList() async {
    var data = await FirebaseFirestore.instance
        .collection('Events')
        .orderBy('date')
        .get();

    setState(() {
      _eventsList =
          List.from(data.docs.map((data) => Event.fromSnapshot(data)));
      _eventsList.retainWhere((element) => element.city.toString() == 'F');
    });
  }
}
