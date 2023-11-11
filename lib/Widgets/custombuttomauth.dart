import 'package:flutter/material.dart';
import 'package:tour/AppColors/colors.dart';

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
      color: AppColors.buttomcolor,
      child:  Text(title),
    );
  }
}
