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
      appBar: AppBar(
        backgroundColor: AppColors.backgroundcolor,
        title: Text(
          'Welcome To JoTour',
          style: GoogleFonts.barlow(
            textStyle: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.buttomcolor),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                "login",
                (route) => false,
              );
            },
            icon: const Icon(Icons.exit_to_app),
            color: AppColors.buttomcolor,
          )
        ],
      ),
      backgroundColor: AppColors.backgroundcolor,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Image.asset(
              'images/deadsea.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 16,
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
          const Positioned(
            top: 200,
            left: 20,
            child: Text(
              'Your Text Here',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
