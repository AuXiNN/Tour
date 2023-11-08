import 'package:flutter/material.dart';

class CustomButtomAuth extends StatelessWidget {
  const CustomButtomAuth({super.key, required this.onPressed, required this.title});

  final void Function () onPressed;
  final String title;

  @override
  Widget build(context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      height: 40,
      onPressed: onPressed,
      textColor: Colors.white,
      color: Colors.orange,
      child:  Text(title),
    );
  }
}
