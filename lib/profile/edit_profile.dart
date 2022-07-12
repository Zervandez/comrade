import 'dart:ffi';

import 'package:comrade/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() => const EditProfile();

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  String sex = 'M';

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> sex = [
      DropdownMenuItem(child: Text("F"), value: "M"),
      DropdownMenuItem(child: Text("F"), value: "F"),
    ];
    return sex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              CustomTextField(controller: nameController, hint: ' bla'),
              CustomTextField(
                controller: emailController,
                hint: 'email',
              ),
              CustomTextField(
                controller: passController,
                hint: 'pass',
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: DropdownButton(
                    value: sex,
                    onChanged: (String? newValue) {
                      setState(() {
                        sex = newValue!;
                      });
                    },
                    items: dropdownItems),
              ),
              Container(
                child: ElevatedButton(
                    onPressed: () => updateUser(
                        nameController, emailController, passController),
                    child: Text('UPDATE')),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () => deleteUser(),
                  child: Text('DELETE'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void updateUser(
  TextEditingController newName,
  TextEditingController newEmail,
  TextEditingController newPass,
) async {
  User? user = FirebaseAuth.instance.currentUser;
  await user!.updateDisplayName(newName.text);
  await user.updateEmail(newEmail.text);
  await user.updatePassword(newPass.text);
}

void deleteUser() {
  User? user = FirebaseAuth.instance.currentUser;
  user!.delete();
}
