import 'package:flutter/material.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:tour/Pages/ProfilePage.dart';
import 'package:tour/Pages/homepage.dart';
import 'package:tour/Pages/Login.dart'; // Import your Login page
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;

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
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.buttomcolor,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          switch (_currentIndex) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
              break;
            case 2:
              // Check if the user is logged in
              if (FirebaseAuth.instance.currentUser == null) {
                // Navigate to the Login page and clear all previous routes
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                  (Route<dynamic> route) => false, // This condition always returns false, so it removes all previous routes
                );
              } else {
                // If logged in, navigate to the Profile page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(),
                  ),
                );
              }
              break;
            // Add cases for other indices if needed
          }
        });
  }
}
