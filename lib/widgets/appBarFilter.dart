import 'package:flutter/material.dart';

class FilteringAppBar extends StatefulWidget {
  FilteringAppBar({Key? key}) : super(key: key);

  @override
  State<FilteringAppBar> createState() => _FilteringAppBarState();
}

class _FilteringAppBarState extends State<FilteringAppBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Expanded(
            child: DropdownItemState(dropdownItemsCategories),
          ),
          Expanded(
            child: DropdownItemState(dropdownItemsCity),
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
