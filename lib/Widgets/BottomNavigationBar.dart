import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:tour/Pages/FavoriteList.dart';
import 'package:tour/Pages/ProfilePage.dart';
import 'package:tour/Pages/homepage.dart';
import 'package:tour/Pages/Login.dart'; // Import your Login page
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

class BottomNav extends StatefulWidget {
  final int? currentIndex; // Make currentIndex nullable
  final bool isHomeEnabled;

  const BottomNav({
    Key? key, 
    this.currentIndex, // It can be null now
    this.isHomeEnabled = false
  }) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  void _onItemTapped(int index) {
 if (widget.isHomeEnabled && index == 0) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
      return;
    }

     if (index != widget.currentIndex) {
      switch (index) {
        case 0:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
          break;
        case 1:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) =>  FavoriteList()),
          );
          break;
        case 2:
          if (FirebaseAuth.instance.currentUser == null) {
            Fluttertoast.showToast(
              msg: "Please log in to access your profile.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
            );
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Login()),
            );
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }
          break;
        // Add cases for other indices if needed
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favourites',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: widget.currentIndex ?? 0, // Use 0 if currentIndex is null
      selectedItemColor: AppColors.buttomcolor,
      onTap: _onItemTapped,
    );
  }
}
