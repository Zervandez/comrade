import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType textInputType = TextInputType.text;
  final int maxLines = 1;

  const CustomTextField(
      {Key? key,
      required this.controller,
      required this.hint,
      TextInputType? textInputType,
      int? maxLines})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.textInputType,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          hintText: widget.hint,
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
}
