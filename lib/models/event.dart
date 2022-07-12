import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Event {
  String uid; // creator ID
  String title;
  String? description;
  TimeOfDay time;
  DateTime date;
  String city;
  String address;

  Event(
    this.uid,
    this.title,
    this.description,
    this.time,
    this.date,
    this.city,
    this.address,
  );

  Event.fromSnapshot(snapshot)
      : uid = snapshot.data()['uid'],
        title = snapshot.data()['title'],
        description = snapshot.data()['description'],
        time = TimeOfDay.fromDateTime(
            DateFormat.jm().parse(snapshot.data()['time'])),
        date = DateTime.parse(snapshot.data()['date']),
        city = snapshot.data()['city'],
        address = snapshot.data()['address'];

  Map<String, dynamic> toJson() => {
        'uid': uid.toString(),
        'title': title.toString(),
        'description': description.toString(),
        'time': time.hour.toString() + ':' + time.minute.toString() + ' PM',
        'date': date.toIso8601String(),
        'city': city.toString(),
        'address': address.toString(),
      };
}
