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

  String selectedCityValue = 'All';
  String selectedCategoryValue = 'All';

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
            child: DropdownButtonFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(style: BorderStyle.none)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(style: BorderStyle.none)),
                ),
                value: selectedCityValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCityValue = newValue!;
                    getEventsList();
                  });
                },
                items: dropdownItemsCity),
          ),
          Expanded(
            child: DropdownButtonFormField(
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(style: BorderStyle.none)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(style: BorderStyle.none)),
                ),
                value: selectedCategoryValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCategoryValue = newValue!;
                    getEventsList();
                  });
                },
                items: dropdownItemsCategories),
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

      if (selectedCityValue != 'All') {
        _eventsList.retainWhere(
            (element) => element.city.toString() == selectedCityValue);
      }
      if (selectedCategoryValue != 'All') {
        _eventsList.retainWhere(
            (element) => element.category.toString() == selectedCategoryValue);
      }
    });
  }
}

List<DropdownMenuItem<String>> get dropdownItemsCategories {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("All"), value: "All"),
    DropdownMenuItem(child: Text("Soccer"), value: "Soccer"),
    DropdownMenuItem(child: Text("Badminton"), value: "Badminton"),
    DropdownMenuItem(child: Text("Jogging"), value: "Jogging"),
    DropdownMenuItem(child: Text("Yoga"), value: "Yoga"),
    DropdownMenuItem(child: Text("Social"), value: "Social"),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get dropdownItemsCity {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("All"), value: "All"),
    DropdownMenuItem(child: Text("Darmstadt"), value: "DA"),
    DropdownMenuItem(child: Text("Frankfurt"), value: "F"),
    DropdownMenuItem(child: Text("Mainz"), value: "MZ"),
    DropdownMenuItem(child: Text("Wiesbaden"), value: "WI"),
    DropdownMenuItem(child: Text("Offenbach"), value: "OF"),
    DropdownMenuItem(child: Text("Bad Homburg"), value: "HG"),
  ];
  return menuItems;
}
