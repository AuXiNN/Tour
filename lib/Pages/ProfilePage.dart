import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tour/AppColors/colors.dart';
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


// Function to get the user's favorite hotels

Future<List<String>> getFavoriteHotels() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final userRef =
        FirebaseFirestore.instance.collection("Users").doc(user.email);

    // Get the list of favorite hotels
    final favoritesSnapshot =
        await userRef.collection("favorites").get();
    final favorites = favoritesSnapshot.docs.map((doc) => doc.id).toList();

    return favorites;
  }

  return [];
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

            return ListView(
              children: [
                const SizedBox(height: 50),

                // profile pic
                const Icon(
                  Icons.person,
                  size: 72,
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
                      style: TextStyle(color: Colors.grey[600])),
                ),

                //username
                MyTextBox(
                  text: userData['username'],
                  sectionName: 'username',
                  onPressed: () => editField('username'),
                ),

                //bio
                MyTextBox(
                  text: userData['bio'],
                  sectionName: 'bio',
                  onPressed: () => editField('bio'),
                ),

                const SizedBox(height: 50),





                

                // user posts
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
      bottomNavigationBar: const BottomNav(),
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