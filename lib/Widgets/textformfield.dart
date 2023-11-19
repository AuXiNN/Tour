import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    Key? key,
    required this.hinttext,
    required this.mycontroller,
    required this.validator,
    this.obscureText = false, // Default value for obscureText
  }) : super(key: key);

  final String hinttext;
  final TextEditingController mycontroller;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  Widget build(context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      controller: mycontroller,
      decoration: InputDecoration(
        hintText: hinttext,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: Colors.grey,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
        filled: true,
        fillColor: const Color.fromARGB(255, 239, 234, 234),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
