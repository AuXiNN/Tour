import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:tour/Pages/FavoriteList.dart';
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
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteList(),
                ),
              );
              break;
            case 2:
              // Check if the user is logged in
              if (FirebaseAuth.instance.currentUser == null) {
                Fluttertoast.showToast(
                  msg: "Please log in to access your profile.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              }
              break;
            // Add cases for other indices if needed
          }
        });
  }
}
