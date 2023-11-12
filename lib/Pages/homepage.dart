import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:tour/Widgets/userprofile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: AppColors.backgroundcolor,
      body: Stack(
        children: [
          // Background image with rounded corners
          ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Container(
              width: double.infinity,
              child: Image.asset(
                'images/deadsea.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 50, // Adjust this value to move the profile picture down
            right: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed("homepage");
              },
              child: const CircleAvatar(
                backgroundImage: AssetImage('images/profilepic.png'),
                radius: 15,
              ),
            ),
          ),
          Positioned(
            top: 140,
            left: 10,
            child: Container(
              // Box with padding, black background, and rounded corners
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.barlow(
                    textStyle: const TextStyle(
                      color: Color.fromARGB(255, 113, 38, 9),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  children: const [
                    TextSpan(
                      text: "Explore Jordan's rich history,",
                    ),
                    TextSpan(
                      text: "\n",
                    ),
                    TextSpan(
                      text: "captivating culture, and",
                    ),
                    TextSpan(
                      text: "\n",
                    ),
                    TextSpan(
                      text: "breathtaking landscapes with our",
                    ),
                    TextSpan(
                      text: "\n",
                    ),
                    TextSpan(
                      text: "immersive and personalized tour app.",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
