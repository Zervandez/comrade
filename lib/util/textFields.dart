import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:passwordfield/passwordfield.dart';
import 'package:validation_textformfield/validation_textformfield.dart';

class CommradeTextField extends StatefulWidget {
  const CommradeTextField(
      {Key? key, required this.hintText, required this.password})
      : super(key: key);
  final String hintText;
  final bool password;

  @override
  State<CommradeTextField> createState() => _CommradeTextFieldState();
}

class _CommradeTextFieldState extends State<CommradeTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: widget.hintText,
      ),
      obscureText: widget.password,
    );
  }
}

//#######################

class NormalTextField extends StatelessWidget {
  final String inputText;

  NormalTextField(
    @required this.inputText,
  );

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: inputText,
      ),
    );
  }
}

class PhoneField extends StatelessWidget {
  const PhoneField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      decoration: InputDecoration(
        labelText: 'Phone Number',
        border: OutlineInputBorder(
          borderSide: BorderSide(),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      initialCountryCode: 'IN',
      onChanged: (phone) {
        print(phone.completeNumber);
      },
    );
  }
}

class EmailValidation extends StatelessWidget {
  final txtEmailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return EmailValidationTextField(
      whenTextFieldEmpty: "Please enter  email",
      validatorMassage: "Please enter valid email",
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          counterText: '',
          hintStyle: TextStyle(color: Colors.black, fontSize: 18.0)),
      textEditingController: txtEmailCtrl,
    );
  }
}

class PasswordFieldClass extends StatelessWidget {
  const PasswordFieldClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PasswordField(
      color: Colors.blue,
      passwordConstraint: r'.*[@$#.*].*',
      inputDecoration: PasswordDecoration(),
      hintText: 'must have special characters',
      border: PasswordBorder(
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue.shade100,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue.shade100,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(width: 2, color: Colors.red.shade200),
        ),
      ),
      errorMessage: 'Password must contain special character either . * @ # \$',
    );
  }
}
