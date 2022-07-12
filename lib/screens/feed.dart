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
  String city = 'F';

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
        automaticallyImplyLeading: false,
        actions: [
          Expanded(
            child: DropdownItemState(dropdownItemsCategories, city),
          ),
          Expanded(
            child: DropdownItemState(dropdownItemsCity, city),
          ),
        ],
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
      DropdownItemState dropdownItemState =
          DropdownItemState(dropdownItemsCity, city);
      _eventsList.retainWhere((element) => element.city.toString() == city);
    });
  }
}

List<DropdownMenuItem<String>> get dropdownItemsCategories {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("All"), value: "All"),
    DropdownMenuItem(child: Text("Soccer"), value: "Soccer"),
    DropdownMenuItem(child: Text("Badminton"), value: "Badminton"),
    DropdownMenuItem(child: Text("Jogging"), value: "Jogging"),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get dropdownItemsCity {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Darmstadt"), value: "DA"),
    DropdownMenuItem(child: Text("Frankfurt"), value: "F"),
    DropdownMenuItem(child: Text("Mainz"), value: "MZ"),
    DropdownMenuItem(child: Text("Wiesbaden"), value: "WI"),
    DropdownMenuItem(child: Text("Offenbach"), value: "OF"),
    DropdownMenuItem(child: Text("Bad Homburg"), value: "HG"),
  ];
  return menuItems;
}

class DropdownItemState extends StatefulWidget {
  List<DropdownMenuItem<String>> liste;
  String selectedValue;

  DropdownItemState(this.liste, this.selectedValue);

  @override
  State<DropdownItemState> createState() => DropdownItemStateState();
}

class DropdownItemStateState extends State<DropdownItemState> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.none)),
          border: OutlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.none)),
        ),
        value: widget.selectedValue,
        onChanged: (String? newValue) {
          setState(() {
            widget.selectedValue = newValue!;
          });
        },
        items: widget.liste);
  }
}
