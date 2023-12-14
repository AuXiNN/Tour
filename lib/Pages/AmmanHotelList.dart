import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:tour/Pages/AmmanHotelsRoom.dart';

class AmmanHotelList extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         centerTitle: true,
        backgroundColor: AppColors.buttomcolor,
        title: const Text(
          'Hotel List',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('hotels').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          var hotels = snapshot.data!.docs;
          return Container(
            color: Color.fromARGB(255, 248, 225, 218),
            child: ListView.builder(
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                var hotel = hotels[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AmmanHotelsRoom(hotelId: hotel.id),
                      ),
                    );
                  },
                  child: FutureBuilder<DocumentSnapshot>(
                    future: hotel.reference.get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return ListTile(
                          title: Text('Error loading hotel'),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        var hotelData = snapshot.data!;
                        if (hotelData.exists) {
                          var name = hotelData['name'];
                          var location = hotelData['location'];
                          var image = hotelData['image'];
                          if (name != null &&
                              location != null &&
                              image != null) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: FutureBuilder<String>(
                                    future: _storage
                                        .ref('img/$image')
                                        .getDownloadURL(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<String> urlSnapshot) {
                                      if (urlSnapshot.hasError) {
                                        return Icon(Icons.error);
                                      }
                                      if (urlSnapshot.connectionState ==
                                          ConnectionState.done) {
                                        var imageUrl = urlSnapshot.data!;
                                        return Image.network(
                                          imageUrl,
                                          height: 200.0,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        );
                                      }
                                      return const CircularProgressIndicator();
                                    },
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Row(
                                  children: [
                                    Icon(Icons.location_on, size: 16, color: Colors.grey),
                                    SizedBox(width: 4),
                                    Text(
                                      location,
                                      style: const TextStyle(
                                        fontSize: 13.0,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                
                              ],
                            );
                          } else {
                            return const ListTile(
                              title: Text('Missing data in the document'),
                            );
                          }
                        } else {
                          return const ListTile(
                            title: Text('Document does not exist'),
                          );
                        }
                      }
                      return const ListTile(
                        title: Text('Loading hotel...'),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
