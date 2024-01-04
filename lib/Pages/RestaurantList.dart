import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:tour/Pages/RestaurantDetails.dart';
import 'package:tour/Widgets/BottomNavigationBar.dart';

enum SortOption { alphabetically, rating }

class RestaurantList extends StatefulWidget {
  final String city;

  RestaurantList({required this.city});

  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  SortOption _sortOption = SortOption.alphabetically;

  Stream<QuerySnapshot> _restaurantStream() {
    Query query = FirebaseFirestore.instance.collection(_getCollectionName());
    switch (_sortOption) {
      case SortOption.alphabetically:
        query = query.orderBy('name');
        break;
      case SortOption.rating:
        query = query.orderBy('rating', descending: true);
        break;
    }
    return query.snapshots();
  }

  String _getCollectionName() {
    switch (widget.city.toLowerCase()) {
      case 'amman':
        return 'amman_restaurants';
      case 'aqaba':
        return 'aqaba_restaurants';
      case 'jerash':
        return 'jerash_restaurants';
      case 'ajloun':
        return 'ajloun_restaurants';
      case 'petra':
        return 'petra_restaurants';
      case 'dead sea':
        return 'deadsea_restaurants';
      case 'wadi rum':
        return 'wadirum_restaurants';
      default:
        return 'restaurants'; // Default collection
    }
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseStorage _storage = FirebaseStorage.instance;

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
        actions: <Widget>[
          DropdownButton<SortOption>(
            value: _sortOption,
            onChanged: (SortOption? newValue) {
              if (newValue != null) {
                setState(() {
                  _sortOption = newValue;
                });
              }
            },
            items: SortOption.values.map((SortOption option) {
              return DropdownMenuItem<SortOption>(
                value: option,
                child: Text(option == SortOption.alphabetically
                    ? 'Alphabetically'
                    : 'By Rating'),
              );
            }).toList(),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _restaurantStream(),
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
                    .ref('${_getCollectionName()}/${restaurant['image']}')
                    .getDownloadURL(),
                builder: (BuildContext context, AsyncSnapshot<String> imageSnapshot) {
                  if (imageSnapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (imageSnapshot.hasError) {
                    return const Text('Error loading image');
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
      bottomNavigationBar: const BottomNav(isHomeEnabled: true),
    );
  }
}
