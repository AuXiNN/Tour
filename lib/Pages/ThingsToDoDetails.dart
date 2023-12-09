import 'package:flutter/material.dart';
import 'package:tour/AppColors/colors.dart';

class ThingsToDoDetails extends StatelessWidget {
  final String imagePath;
  final String description;

  const ThingsToDoDetails(
      {super.key, required this.imagePath, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        backgroundColor: AppColors.buttomcolor,
        centerTitle: true,
        title: Text(
          description,
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white), // Set back button color
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Image.asset(
              imagePath,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

String removeExtension(String path) {
  return path.split('/').last.split('.').first;
}
