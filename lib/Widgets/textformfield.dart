

import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
   const CustomTextForm({super.key, required this.hinttext, required this.mycontroller, required this.validator});
  

  final String hinttext;
  final TextEditingController mycontroller;
  final String? Function(String?)? validator;


  @override

  Widget build(context) {
    return TextFormField(
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