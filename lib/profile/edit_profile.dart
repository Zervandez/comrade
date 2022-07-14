import 'dart:ffi';

import 'package:comrade/homepage.dart';
import 'package:comrade/profile/profile.dart';
import 'package:comrade/screens/login/login.dart';
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
  final User? user = FirebaseAuth.instance.currentUser;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  String sex = 'M';

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> sex = [
      DropdownMenuItem(child: Text("M"), value: "M"),
      DropdownMenuItem(child: Text("F"), value: "F"),
    ];
    return sex;
  }

  void goToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage(
                selectedIndex: 2,
              )),
    );
  }

  void sendToLogin(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              CustomTextField(
                controller: nameController,
                hint: 'Enter new Name',
              ),
              CustomTextField(
                controller: emailController,
                hint: 'Enter new E-Mail',
              ),
              CustomTextField(
                controller: passController,
                hint: '',
              ),
              Container(
                margin: const EdgeInsets.all(5),
                child: DropdownButton(
                    value: sex,
                    onChanged: (String? newValue) {
                      setState(() {
                        sex = newValue!;
                      });
                    },
                    items: dropdownItems),
              ),
              ElevatedButton(
                  onPressed: () => {
                        updateUser(
                            nameController, emailController, passController),
                        goToProfile(),
                      },
                  child: Text('UPDATE')),
              ElevatedButton(
                onPressed: () => {
                  deleteUser(),
                  sendToLogin(context),
                },
                child: Text('DELETE'),
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
  if (newName.text.isNotEmpty) await user!.updateDisplayName(newName.text);
  if (newEmail.text.isNotEmpty) await user!.updateEmail(newEmail.text);
  if (newPass.text.isNotEmpty) await user!.updatePassword(newPass.text);
}

void deleteUser() {
  User? user = FirebaseAuth.instance.currentUser;
  user!.delete();
}
