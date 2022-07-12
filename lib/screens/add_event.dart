import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../models/event.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  DatabaseReference eventsReference = FirebaseDatabase.instance.ref('events');

  final uid = FirebaseAuth.instance.currentUser?.uid;
  TextEditingController titleController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  String selectedValue = 'F';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            customTextfield(titleController, 'Name your event'),
            customTextfield(
              descriptionController,
              'Describe the event.',
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
                      value: selectedValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                      items: dropdownItems),
                ),
                Flexible(
                  child:
                      customTextfield(addressController, 'Enter event address'),
                )
              ],
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
                  selectedValue,
                  addressController.text,
                );

                // get user id & push it t00
                // dynamic array with participants
                // or document in Firestore for participants

                FirebaseFirestore.instance
                    .collection('Events')
                    .add(newEvent.toJson())
                    .then((value) => print('success!'));
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
  Widget customTextfield(TextEditingController controller, String hint,
      {TextInputType textInputType = TextInputType.text, int maxLines = 1}) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: TextField(
        controller: controller,
        keyboardType: textInputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: 0.0,
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.red, width: 1.5),
          ),
        ),
      ),
    );
  }

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
