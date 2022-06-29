import 'package:flutter/material.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  TextEditingController titleController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();

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
            customTextfield(cityController, 'Enter city'),
            customTextfield(addressController, 'Enter event address'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _selectTime(context),
                  child: Text('time?'),
                ),
                Text("${selectedTime.hour}:${selectedTime.minute}"),
                ElevatedButton(
                  onPressed: () async {},
                  child: Text('date?'),
                ),
                Text(
                    '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
              ],
            ),
            ElevatedButton(
              onPressed: null,
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
    DateTime? newSelectedDate = showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: selectedDate,
      lastDate: DateTime(2100),
    ) as DateTime?;

    if (newSelectedDate != null) {
      setState(() {
        selectedDate = newSelectedDate;
      });
    }
  }
}
