import 'package:flutter/material.dart';

class FormFieldLogin extends StatelessWidget {
  String hintName;
  IconData icon;
  TextEditingController controller;
  TextInputType inputType;
  bool isObscured;
  bool enableField;

  FormFieldLogin({
    super.key,
    required this.hintName,
    required this.icon,
    required this.controller,
    this.isObscured = false,
    this.inputType = TextInputType.text,
    this.enableField = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      obscureText: isObscured,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          //borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
        ),
        hintText: hintName,
        labelText: hintName,
        prefixIcon: Icon(icon),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Por favor Digite $hintName';
        }
        if ((hintName.contains('E-mail')) && !validateEmail(value)) {
          return 'Digite um email válido';
        }
        return null;
      },
    );
  }
}

validateEmail(String email) {
  final emailReg = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  return emailReg.hasMatch(email);
}
