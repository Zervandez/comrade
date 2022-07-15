import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comrade/models/event.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SingleEvent extends StatefulWidget {
  const SingleEvent(this.e);
  final Event e;

  @override
  State<SingleEvent> createState() => _SingleEventState();
}

class _SingleEventState extends State<SingleEvent> {
  String participants = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(String x) async {
      //DocumentSnapshot querySnapshot = await
      var data = await FirebaseFirestore.instance
          .collection('Participants')
          .doc(x)
          .collection('users')
          .get()
          .then((value) => value.docs.map((e) => e.data()).toList());
      print(data);
      participants = data.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
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
                        widget.e.title.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(widget.e.uid),
                    ],
                  )
                ],
              ),
              //  DESCRIPTION ROW
              Row(
                children: [
                  Text(
                    widget.e.description.toString(),
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
                  Text(widget.e.time.hour.toString() +
                      ':' +
                      widget.e.time.minute.toString()),
                  Text(widget.e.address.toString()),
                ],
              ),
              //  ADDRESS ROWS
              // DATE & CITY
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.e.date.year.toString() +
                      ' ' +
                      widget.e.date.day.toString() +
                      ' ' +
                      widget.e.date.month.toString()),
                  Text(widget.e.category.toString()),
                  Text(widget.e.city.toString()),
                ],
              ),

              Text(participants),
            ],
          ),
        ),
      ),
    );
  }
}
