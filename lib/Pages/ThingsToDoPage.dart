// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:tour/Pages/ThingsToDoDetails.dart';
import 'package:tour/Widgets/BottomNavigationBar.dart';
import 'package:tour/Widgets/ThingsToDoDataProvider.dart';

class ThingsToDoPage extends StatefulWidget {
  final String city;

  ThingsToDoPage({required this.city});

  @override
  _ThingsToDoPageState createState() => _ThingsToDoPageState();
}

class _ThingsToDoPageState extends State<ThingsToDoPage> {
  late List<ThingsToDoDetails> thingsToDoList;
  late List<ThingsToDoDetails> filteredList;
  final Set<String> userFavorites = {}; // Set to store user's favorite place names

  @override
  void initState() {
    super.initState();
    thingsToDoList = ThingsToDoDataProvider.generateThingsToDoList(widget.city);
    filteredList = List.from(thingsToDoList);
    _updateFavorites();

  }

  Future<void> _updateFavorites() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String userEmail = currentUser.email!;
      var favoritesSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userEmail)
          .collection('favorites_places')
          .get();

      setState(() {
        userFavorites.clear();
        for (var doc in favoritesSnapshot.docs) {
          userFavorites.add(doc.id);
        }
        filteredList = List.from(thingsToDoList)
          ..forEach((thing) {
            thing.isFavorite = userFavorites.contains(thing.name);
          });
      });
    }
  }

  void _search(String query) {
    setState(() {
      filteredList = thingsToDoList
          .where((thingToDo) =>
              thingToDo.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

 void toggleFavorite(ThingsToDoDetails thingToDo) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      Fluttertoast.showToast(
        msg: "You must be logged in to add to favorites",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
    String userEmail = currentUser.email!;


    // Reference to the user's favorites in Firestore
     var favoritesRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(userEmail)
        .collection('favorites_places'); 

    setState(() {
      if (thingToDo.isFavorite) {
        // Remove from favorites
        favoritesRef.doc(thingToDo.name).delete();
        userFavorites.remove(thingToDo.name);
        Fluttertoast.showToast(
        msg: "${thingToDo.name} has been removed from Favorites",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      } else {
        // Add to favorites
        favoritesRef.doc(thingToDo.name).set({
          'name': thingToDo.name,
          // Add other details you want to store
        });
        userFavorites.add(thingToDo.name);
         Fluttertoast.showToast(
        msg: "${thingToDo.name} has been added to Favorites",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      }
      thingToDo.isFavorite = !thingToDo.isFavorite;
    });
  }

    

    // Update the local state to reflect the change


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        backgroundColor: AppColors.buttomcolor,
        centerTitle: true,
        title: Text(
          'Things To Do In ${widget.city}',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Here Are Places In ${widget.city} That You Can Enjoy Visiting:',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: _search,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        suffixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
// Inside the build method of _ThingsToDoPageState class, inside ListView.builder...
              Column(
                children: filteredList.map((thingToDo) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ThingsToDoDetails(
                            name: thingToDo.name,
                            imagePaths: thingToDo.imagePaths,
                            description: thingToDo.description,
                            location: thingToDo.location,
                            workingHours: thingToDo.workingHours,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.asset(
                              thingToDo.imagePaths.first,
                              width: double.infinity,
                              height: 250,
                              fit: BoxFit.cover,
                            ),
                            IconButton(
                              icon: Icon(
                                thingToDo.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                toggleFavorite(thingToDo);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          thingToDo.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppColors.buttomcolor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const SizedBox(width: 8),
                            const Icon(Icons.location_on,
                                color: Color(0xFF3A1B0F)),
                            const SizedBox(width: 6),
                            Text(
                              thingToDo.location,
                              style: const TextStyle(
                                  fontSize: 11, color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    bottomNavigationBar: const BottomNav(isHomeEnabled: true) 
    );
  }
}
