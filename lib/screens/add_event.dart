import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../homepage.dart';
import '../models/event.dart';
import '../widgets/custom_text_field.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  //DatabaseReference eventsReference = FirebaseDatabase.instance.ref('events');

  final uid = getRandomString(10);
  TextEditingController titleController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  String selectedCityValue = 'F';
  String selectedCategoryValue = 'Social';

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("F"), value: "F"),
      DropdownMenuItem(child: Text("OF"), value: "OF"),
      DropdownMenuItem(child: Text("MZ"), value: "MZ"),
      DropdownMenuItem(child: Text("WI"), value: "WI"),
      DropdownMenuItem(child: Text("DA"), value: "DA"),
      DropdownMenuItem(child: Text("HG"), value: "HG"),
    ];
    return menuItems;
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            CustomTextField(
              controller: titleController,
              hint: 'Enter title',
            ),
            CustomTextField(
              controller: descriptionController,
              hint: 'Describe the event.',
              textInputType: TextInputType.multiline,
              maxLines: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  child: Text('time?'),
                ),
                Text("${selectedTime.hour}:${selectedTime.minute}"),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('date?'),
                ),
                Text(
                    '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.all(5),
                  child: DropdownButton(
                      value: selectedCityValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCityValue = newValue!;
                        });
                      },
                      items: dropdownItems),
                ),
                Flexible(
                  child: CustomTextField(
                      controller: addressController,
                      hint: 'Enter event address'),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: DropdownButton(
                  value: selectedCategoryValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategoryValue = newValue!;
                    });
                  },
                  items: dropdownItemsCategories),
            ),
            ElevatedButton(
              onPressed: () {
                // events.push
                Event newEvent = Event(
                  uid.toString(),
                  titleController.text,
                  descriptionController.text,
                  selectedTime,
                  selectedDate,
                  selectedCityValue,
                  selectedCategoryValue,
                  addressController.text,
                );

                // get user id & push it t00
                // dynamic array with participants
                // or document in Firestore for participants

                FirebaseFirestore.instance
                    .collection('Events')
                    .add(newEvent.toJson())
                    .then((_) => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        ));
                // .then go to feed
                // & optionally hightlight the last added post for 1 sec
              },
              child: Text('POST EVENT'),
            )
          ],
        ),
      ),
    );
  }

// this is a custom Widget we have extracted in order to avoid repeating code
// in the parameters we see an example of optional parameter with a default value

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }

  void _selectDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((value) => {
          setState(() {
            if (value != null) selectedDate = value;
          })
        });
  }
}

String getRandomString(int len) {
  var random = Random.secure();
  var values = List<int>.generate(len, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}
