import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:tour/Pages/BookingHistoryScreen.dart';
import 'package:tour/Widgets/BottomNavigationBar.dart';
import 'package:tour/Widgets/TextBox.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  // current user
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //user
  final currentUser = FirebaseAuth.instance.currentUser!;

  //all users

  final userCollection = FirebaseFirestore.instance.collection("Users");

  String profileImageUrl = "";

  //signout method
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    // Navigate to login screen or home screen after signing out

    Fluttertoast.showToast(
      msg: "Signed Out",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    Navigator.of(context).pushReplacementNamed('login');
  }

  // edit field
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text(
          "Edit $field",
          style: const TextStyle(color: Colors.white),
        ),
        content: TextField(
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Enter New $field",
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          // cancel button
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          // save button
          TextButton(
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => Navigator.of(context).pop(newValue),
          )
        ],
      ),
    );

    // update in firestore
    if (newValue.trim().length > 0) {
      // only update if there is something in the textfield
      await userCollection.doc(currentUser.email).update({field: newValue});
    }
  }

  Future<void> uploadProfilePicture() async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        File imageFile = File(pickedFile.path);

        // Upload to Firebase Storage
        String fileName = 'profile_${currentUser.uid}';
        await FirebaseStorage.instance.ref(fileName).putFile(imageFile);
        final imageUrl =
            await FirebaseStorage.instance.ref(fileName).getDownloadURL();

        // Save image URL to Firestore
        await userCollection
            .doc(currentUser.email)
            .update({'profileImageUrl': imageUrl});

        // Update the profileImageUrl state to refresh UI
        setState(() {
          profileImageUrl = imageUrl;
        });
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error uploading image: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print("Error uploading image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.buttomcolor,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          //get user data
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            // Check if local state is empty and Firestore has a URL
            if (profileImageUrl.isEmpty &&
                userData['profileImageUrl']?.isNotEmpty == true) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  profileImageUrl = userData['profileImageUrl'];
                });
              });
            }

            return ListView(
              children: [
                const SizedBox(height: 50),

                // profile pic
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 130.0,
                      height: 130.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: profileImageUrl.isNotEmpty
                              ? NetworkImage(profileImageUrl) as ImageProvider
                              : const AssetImage(
                                  'images/default_profile_pic (2).png'),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 90,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.all(0), 
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.edit,
                              size: 22,
                              color: Colors.white), 
                          onPressed: uploadProfilePicture,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // user email
                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey[700], fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 50),

                // user details
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text('My Details',
                      style: TextStyle(color: Colors.grey[600], fontSize: 20)),
                ),

                //first_name
                MyTextBox(
                  text: userData['first_name'],
                  sectionName: 'First name',
                  onPressed: () => editField('first_name'),
                ),
                //last_name
                MyTextBox(
                  text: userData['last_name'],
                  sectionName: 'Last name',
                  onPressed: () => editField('last_name'),
                ),
                //bio
                MyTextBox(
                  text: userData['bio'],
                  sectionName: 'Bio',
                  onPressed: () => editField('bio'),
                ),

                const SizedBox(height: 30),

// Add the ElevatedButton.icon for

                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 26.0, horizontal: 50.0),
                  child: Container(
                    height: 50.0, // Set the height you want
                    width: double
                        .infinity, // You can set a specific width if needed
                    child: ElevatedButton(
                      onPressed: () {
                        var currentUser = FirebaseAuth.instance.currentUser;
                        if (currentUser != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingHistoryScreen(
                                userEmail: currentUser.email!,
                              ),
                            ),
                          );
                        } else {
                          // Handle the case where there is no logged-in user
                          print("No user is currently logged in.");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttomcolor,
                        foregroundColor: Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'View My Booking History',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 26.0, horizontal: 120.0),
                  child: Container(
                    width:
                        double.infinity, // Or set a specific width like 200.0
                    child: ElevatedButton.icon(
                      onPressed: _signOut,
                      icon: const Icon(Icons.logout, size: 18),
                      label: const Text('Sign out',
                          style: TextStyle(fontSize: 15)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(206, 112, 88, 1),
                        foregroundColor: Color.fromARGB(255, 255, 255, 255),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error${snapshot.error}',
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    bottomNavigationBar: const BottomNav(currentIndex: 2),
    );
  }
}

// return Scaffold(
//   backgroundColor: AppColors.backgroundcolor,
//   appBar: AppBar(
//     backgroundColor: AppColors.buttomcolor,
//     centerTitle: true,
//     title: const Text(
//       'Profile',
//       style: TextStyle(color: Colors.white),
//     ),
//     iconTheme: IconThemeData(color: Colors.white),
//   ),
//   body: SingleChildScrollView(
//     // Add SingleChildScrollView here
//     child: Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const CircleAvatar(
//               radius: 50,
//               backgroundImage: AssetImage('images/profilepic.png'),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'John Doe',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               'Software Developer',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey,
//               ),
//             ),
//             const SizedBox(height: 16),
//             const SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: () {
//                 // Handle edit profile button press
//               },
//               child: const Text('Edit Profile'),
//             ),
//           ],
//         ),
//       ),
//     ),
//   ),
//   bottomNavigationBar: const BottomNav(),
// );
