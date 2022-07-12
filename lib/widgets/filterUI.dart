import 'package:flutter/material.dart';

class FilterUInew extends StatefulWidget {
  FilterUInew({Key? key}) : super(key: key);

  @override
  State<FilterUInew> createState() => _FilterUInewState();
}

class _FilterUInewState extends State<FilterUInew> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Filter",
            style: TextStyle(fontSize: 18),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Text(
                  "  Category",
                  style: TextStyle(fontSize: 16),
                ),
                width: 80,
              ),
              Expanded(
                child: DropdownItemState(dropdownItemsCategories),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Text(
                  "  City",
                  style: TextStyle(fontSize: 16),
                ),
                width: 80,
              ),
              Expanded(child: DropdownItemState(dropdownItemsCity)),
            ],
          ),
        ],
      ),
    );
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
    DropdownMenuItem(child: Text("All"), value: "All"),
    DropdownMenuItem(child: Text("Darmstadt"), value: "Darmstadt"),
    DropdownMenuItem(child: Text("Frankfurt"), value: "Frankfurt"),
    DropdownMenuItem(child: Text("Berlin"), value: "Berlin"),
  ];
  return menuItems;
}

class DropdownItemState extends StatefulWidget {
  List<DropdownMenuItem<String>> liste;

  DropdownItemState(this.liste);

  @override
  State<DropdownItemState> createState() => DropdownItemStateState();
}

class DropdownItemStateState extends State<DropdownItemState> {
  String selectedValue = "All";

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(style: BorderStyle.solid)),
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
