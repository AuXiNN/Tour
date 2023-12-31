import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:tour/Widgets/BottomNavigationBar.dart';

class FavoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
// Check if a user is logged in
    User? currentUser = FirebaseAuth.instance.currentUser;

    // If no user is logged in, show toast and redirect to the login page
    if (currentUser == null) {
      Fluttertoast.showToast(
        msg: "Please log in to view favorites",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Future.microtask(
          () => Navigator.of(context).pushReplacementNamed('login'));
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    String userEmail = FirebaseAuth.instance.currentUser!.email!;
    void showRemoveConfirmationDialog(String placeName, String docId) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.question,
        animType: AnimType.bottomSlide,
        title: 'Remove Favorite',
        desc: 'Are you sure you want to remove $placeName from your favorites?',
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          FirebaseFirestore.instance
              .collection('Users')
              .doc(userEmail)
              .collection('favorites')
              .doc(docId)
              .delete();
        },
      ).show();
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Favorites",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.buttomcolor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(userEmail)
            .collection('favorites')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            // Display a message when there are no favorite places
            return Center(
              child: Text(
                "No Favorite Places",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            );
          }

          var favoriteDocs = snapshot.data!.docs;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    "Here's The Places You Liked:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: favoriteDocs.length,
                  itemBuilder: (context, index) {
                    var favorite = favoriteDocs[index];
                    return Container(
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: AppColors.buttomcolor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              favorite['name'],
                              style: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.accentColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete,
                                color: Color.fromRGBO(221, 99, 68, 1)),
                            onPressed: () {
                              // Function to remove the item from the favorites collection
                              showRemoveConfirmationDialog(
                                  favorite['name'], favorite.id);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
