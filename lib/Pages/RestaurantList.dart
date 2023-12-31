import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:tour/Pages/RestaurantDetails.dart';

class RestaurantList extends StatelessWidget {
  final String city; // Add this line

  final CollectionReference restaurants =
      FirebaseFirestore.instance.collection('amman_restaurants');
  final FirebaseStorage _storage = FirebaseStorage.instance;
  RestaurantList({required this.city}); // Constructor accepting city

  @override
  Widget build(BuildContext context) {
    String collectionName = '';
    if (city.toLowerCase() == 'amman') {
      collectionName = 'amman_restaurants';
    } else if (city.toLowerCase() == 'aqaba') {
      collectionName = 'aqaba_restaurants';
    } else if (city.toLowerCase() == 'jerash') {
      collectionName = 'jerash_restaurants';
    } else if (city.toLowerCase() == 'ajloun') {
      collectionName = 'ajloun_restaurants';
    } else if (city.toLowerCase() == 'petra') {
      collectionName = 'petra_restaurants';
    } else if (city.toLowerCase() == 'dead sea') {
      collectionName = 'deadsea_restaurants';
    } else if (city.toLowerCase() == 'wadi rum') {
      collectionName = 'wadirum_restaurants';
    }
    final CollectionReference restaurants =
        FirebaseFirestore.instance.collection(collectionName);
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        backgroundColor: AppColors.buttomcolor,
        centerTitle: true,
        title: Text(
          'Restaurants & Cafes',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: StreamBuilder(
        stream: restaurants.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          var restaurantList = snapshot.data!.docs;

          return ListView.builder(
            itemCount: restaurantList.length,
            itemBuilder: (context, index) {
              var restaurant =
                  restaurantList[index].data() as Map<String, dynamic>;

              return FutureBuilder(
                future: _storage
                    .ref('$collectionName/${restaurant['image']}')
                    .getDownloadURL(),
                builder: (BuildContext context,
                    AsyncSnapshot<String> imageSnapshot) {
                  if (imageSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (imageSnapshot.hasError) {
                    print('Error loading image: ${imageSnapshot.error}');
                    return const Text('Error loading image');
                  } else if (imageSnapshot.data == null) {
                    print('Image URL is null');
                    return const Text('Image not found');
                  } else {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RestaurantDetails(
                                  restaurantId: restaurantList[index].id,
                                ),
                              ),
                            );
                          },
                          child: Image.network(
                            imageSnapshot.data!,
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ListTile(
                          title: Text(restaurant['name'],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Classification: ${restaurant['classification']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text: 'Location: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: restaurant[
                                            'location']), // Normal weight for the actual location
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text: 'Working Hours: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: restaurant[
                                            'workingHours']), // Normal weight for the actual location
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text: 'Phone Number: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: restaurant[
                                            'phoneNumber']), // Normal weight for the actual location
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  RatingBar.builder(
                                    initialRating: double.parse(
                                        restaurant['rating'].toString()),
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 20.0,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 2.0),
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    onRatingUpdate: (rating) {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RestaurantDetails(
                                  restaurantId: restaurantList[index].id,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }
                },
              );
            },
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => AddRestaurantPage(),
      //       ),
      //     );
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
