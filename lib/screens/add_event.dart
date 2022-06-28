import 'package:flutter/material.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  TextEditingController titleController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: titleController,
          decoration: InputDecoration(hintText: 'Enter title'),
        ),
        TextField(
          controller: descriptionController,
          keyboardType: TextInputType.multiline,
          maxLines: 3,
          decoration: InputDecoration(hintText: 'Enter description'),
        ),
        TextField(
          controller: addressController,
          decoration: InputDecoration(hintText: 'Enter address'),
        ),
        ElevatedButton(
          onPressed: null,
          child: Text('POST EVENT'),
        )
      ],
    );
  }
}
