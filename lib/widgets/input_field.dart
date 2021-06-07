import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

typedef void MyCallback(String value);

class InputFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String fieldName;
  final bool isPassword;
  final MyCallback onValueChanged;

  InputFieldWidget({this.controller, this.fieldName, this.isPassword = false, this.onValueChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value.isEmpty) return fieldName + ' is required';
          if (fieldName == "Email" && !EmailValidator.validate(value)) return 'This is not a valid email address';
          if (fieldName == "Username" && value.length < 3) return 'Your ' + fieldName.toString().toLowerCase() + ' must be atleast 3 characters long';
          if (fieldName == "Password" && value.length < 6) return 'Your ' + fieldName.toString().toLowerCase() + ' must be atleast 6 characters long';
          return null;
        },
        onChanged: (value) {
          onValueChanged(value);
        },
        obscureText: isPassword,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: fieldName,
          hintStyle: TextStyle(color: Colors.grey),
        ),
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
