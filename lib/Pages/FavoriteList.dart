import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:tour/Widgets/BottomNavigationBar.dart';

class FavoriteList extends StatefulWidget {
  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  late String userEmail;

  @override
  void initState() {
    super.initState();
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      Fluttertoast.showToast(
        msg: "Please log in to view favorites",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Future.microtask(() => Navigator.of(context).pushReplacementNamed('login'));
    } else {
      userEmail = currentUser.email!;
      _tabController = TabController(length: 3, vsync: this);
    }
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Favorites", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.buttomcolor,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Hotels'),
            Tab(text: 'Places'),
            Tab(text: 'Restaurants'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          FavoriteCategory(userEmail: userEmail, category: 'favorites', title: 'Hotels'),
          FavoriteCategory(userEmail: userEmail, category: 'favorites_places', title: 'Places'),
          FavoriteCategory(userEmail: userEmail, category: 'favorites_restaurants', title: 'Restaurants'),
        ],
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 1),
    );
  }
}

class FavoriteCategory extends StatelessWidget {
  final String userEmail;
  final String category;
  final String title;

  FavoriteCategory({required this.userEmail, required this.category, required this.title});

  void showRemoveConfirmationDialog(BuildContext context, String itemName, String docId) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.bottomSlide,
      title: 'Remove Favorite',
      desc: 'Are you sure you want to remove $itemName from your favorites?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        FirebaseFirestore.instance
            .collection('Users')
            .doc(userEmail)
            .collection(category)
            .doc(docId)
            .delete();
      },
    ).show();
  }

  

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(userEmail)
          .collection(category)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              "No Favorite $title",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          );
        }

        var favoriteDocs = snapshot.data!.docs;

        return ListView.builder(
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
                    icon: Icon(Icons.delete, color: Color.fromRGBO(221, 99, 68, 1)),
                    onPressed: () {
                      showRemoveConfirmationDialog(context, favorite['name'], favorite.id);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
