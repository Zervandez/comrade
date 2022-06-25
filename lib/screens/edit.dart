import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class EditPage extends StatelessWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Comrade',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Flutter App"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          "Availability",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Center(
                                  child: Text(
                                "     ",
                              )),
                            ),
                            Expanded(
                              child: Center(child: Text("From")),
                            ),
                            Expanded(
                              child: Center(child: Text("To")),
                            ),
                          ],
                        ),
                      ),
                      TimeFieldRow("Monday"),
                      TimeFieldRow("Tuesday"),
                      TimeFieldRow("Wednesday"),
                      TimeFieldRow("Thursday"),
                      TimeFieldRow("Friday"),
                      TimeFieldRow("Saturday"),
                      TimeFieldRow("Sunday"),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Card(
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "Personal Data",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Divider(),
                        Row(
                          children: [
                            Expanded(
                              child: Center(
                                  child: Text(
                                "Gender",
                                style: TextStyle(fontSize: 16),
                              )),
                            ),
                            Expanded(
                              child: DropdownItemState(dropdownItems),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Center(
                                  child: Text(
                                "City",
                                style: TextStyle(fontSize: 16),
                              )),
                            ),
                            Expanded(
                              child: DropdownItemState(dropdownItemsCity),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Center(
                                  child: Text(
                                "Categories",
                                style: TextStyle(fontSize: 16),
                              )),
                            ),
                            Expanded(
                              child: DropdownItemState(dropdownItemsCategories),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Confirm"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BasicTimeField extends StatelessWidget {
  final format = DateFormat("HH:mm");

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}

class TimeFieldRow extends StatelessWidget {
  final String day;

  TimeFieldRow(this.day);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: Center(
            child: Text(
              day,
              style: TextStyle(fontSize: 15),
            ),
          )),
          Expanded(
            child: BasicTimeField(),
          ),
          VerticalDivider(),
          Expanded(
            child: BasicTimeField(),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}

class DropdownItemState extends StatefulWidget {
  List<DropdownMenuItem<String>> liste;

  DropdownItemState(this.liste);

  @override
  State<DropdownItemState> createState() => DropdownItemStateState();
}

class DropdownItemStateState extends State<DropdownItemState> {
  String selectedValue = "Unpicked";

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.none)),
          border: OutlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.none)),
        ),
        value: selectedValue,
        onChanged: (String? newValue) {
          setState(() {
            selectedValue = newValue!;
          });
        },
        items: widget.liste);
  }
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Not picked"), value: "Unpicked"),
    DropdownMenuItem(child: Text("Female"), value: "Female"),
    DropdownMenuItem(child: Text("Male"), value: "Male"),
    DropdownMenuItem(child: Text("Other"), value: "Other"),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get dropdownItemsCity {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Not picked"), value: "Unpicked"),
    DropdownMenuItem(child: Text("Frankfurt"), value: "Frankfurt"),
    DropdownMenuItem(child: Text("Offenbach"), value: "Offenbach"),
    DropdownMenuItem(child: Text("Berlin"), value: "Berlin"),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get dropdownItemsCategories {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Not picked"), value: "Unpicked"),
    DropdownMenuItem(child: Text("Soccer"), value: "Soccer"),
    DropdownMenuItem(child: Text("Badminton"), value: "Badminton"),
    DropdownMenuItem(child: Text("Jogging"), value: "Jogging"),
  ];
  return menuItems;
}
