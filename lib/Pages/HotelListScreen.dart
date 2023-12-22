import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tour/Pages/HotelBooking.dart';
import 'package:tour/Widgets/BottomNavigationBar.dart';

enum SortOption { rating, alphabetically }

class HotelListScreen extends StatefulWidget {
  final String city;

  HotelListScreen({required this.city});

  @override
  _HotelListScreenState createState() => _HotelListScreenState();
}

class _HotelListScreenState extends State<HotelListScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  SortOption _sortOption = SortOption.rating;

  Stream<QuerySnapshot> _hotelStream(String collectionName) {
    if (_sortOption == SortOption.rating) {
      return _firestore
          .collection(collectionName)
          .orderBy('rating', descending: true)
          .snapshots();
    } else {
      return _firestore.collection(collectionName).orderBy('name').snapshots();
    }
  }

  String _getCollectionName(String city) {
    switch (city.toLowerCase()) {
      case 'amman':
        return 'hotels';
      case 'aqaba':
        return 'aqaba_hotels';
      case 'jerash':
        return 'jerash_hotels';
      case 'ajloun':
        return 'ajloun_hotels';
      case 'petra':
        return 'petra_hotels';
      case 'dead sea':
        return 'deadsea_hotel';
      case 'wadi rum':
        return 'wadirum_hotels';
      default:
        return 'hotels';
    }
  }

  @override
  Widget build(BuildContext context) {
    String collectionName = _getCollectionName(widget.city);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel List'),
        backgroundColor: const Color.fromARGB(255, 248, 225, 218),
        actions: [
          // Dropdown menu for sorting options
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
                child: Text(option == SortOption.rating
                    ? 'Sort by Rating'
                    : 'Sort A-Z'),
              );
            }).toList(),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _hotelStream(collectionName),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          var hotels = snapshot.data!.docs;

          return Container(
            color: const Color.fromARGB(255, 248, 225, 218),
            child: ListView.builder(
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                var hotel = hotels[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HotelDetailsScreen(
                            hotelId: hotel.id, collectionName: collectionName),
                      ),
                    );
                  },
                  child: FutureBuilder<DocumentSnapshot>(
                    future: hotel.reference.get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const ListTile(
                          title: Text('Error loading hotel'),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        var hotelData = snapshot.data!;
                        if (hotelData.exists) {
                          var name = hotelData['name'];
                          var location = hotelData['location'];
                          var image = hotelData['image'];
                          var rating = hotelData['rating'] ??
                              0.0; // Assuming 'rating' field exists
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
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: FutureBuilder<String>(
                                      future: _storage
                                          .ref('$collectionName/$image')
                                          .getDownloadURL(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<String> urlSnapshot) {
                                        if (urlSnapshot.hasError) {
                                          return const Icon(Icons.error);
                                        }
                                        if (urlSnapshot.connectionState ==
                                            ConnectionState.done) {
                                          var imageUrl = urlSnapshot.data!;
                                          return Image.network(
                                            imageUrl,
                                            height: 250.0,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          );
                                        }
                                        return const CircularProgressIndicator();
                                      },
                                    )),
                                const SizedBox(height: 8.0),
                                Center(
                                  child: Text(
                                    name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on,
                                        color: Color(0xFF3A1B0F)),
                                    const SizedBox(width: 6),
                                    Text(
                                      '${hotelData['location']}',
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16.0, top: 8.0),
                                  child: Row(
                                    children: [
                                      RatingBarIndicator(
                                        rating: rating,
                                        itemBuilder: (context, index) =>
                                            const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        itemCount: 5,
                                        itemSize: 20.0,
                                        direction: Axis.horizontal,
                                      ),
                                      SizedBox(
                                          width:
                                              8), // Spacing between the stars and the rating number
                                      Text(
                                        '$rating', // Display the rating number
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30.0,
                                )
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
      bottomNavigationBar: const BottomNav(),
    );
  }
}

class HotelDetailsScreen extends StatelessWidget {
  final String hotelId;
  final String collectionName;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  HotelDetailsScreen({required this.hotelId, required this.collectionName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Details'),
        backgroundColor: const Color.fromARGB(255, 248, 225, 218),
      ),
      backgroundColor: const Color.fromARGB(255, 248, 225, 218),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream:
                _firestore.collection(collectionName).doc(hotelId).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var hotelData = snapshot.data!.data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Center(
                        child: Text(
                          '${hotelData['name']} ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: Color(0xFF3A1B0F)),
                          const SizedBox(width: 6),
                          Text(
                            '${hotelData['location']}',
                            style: TextStyle(
                              fontSize:
                                  14, // Change this value to your desired font size
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Rooms:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection(collectionName)
                  .doc(hotelId)
                  .collection('rooms')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var rooms = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: rooms.length,
                    itemBuilder: (context, index) {
                      var room = rooms[index];
                      var roomData = room.data() as Map<String, dynamic>;
                      return ListTile(
                        title: Text(
                          'Type: ${roomData['type']}',
                          style: const TextStyle(
                            color: Color(0xFF3A1B0F),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.bed,
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '${roomData['Bed']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Row(
                              children: [
                                Icon(
                                  Icons.coffee,
                                  size: 20,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Breakfast included',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Row(
                              children: [
                                Icon(Icons.wifi, size: 20),
                                SizedBox(width: 8),
                                Text('Free Wi-Fi ',
                                    style: TextStyle(fontSize: 12)),
                                Icon(Icons.balcony, size: 20),
                                SizedBox(width: 8),
                                Text('Balcony ',
                                    style: TextStyle(fontSize: 12)),
                                Icon(Icons.pool, size: 20),
                                SizedBox(width: 8),
                                Text('Pool view ',
                                    style: TextStyle(fontSize: 12)),
                                Icon(Icons.location_city, size: 20),
                                SizedBox(width: 8),
                                Text('City View ',
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Row(
                              children: [
                                Icon(Icons.bathroom, size: 20),
                                SizedBox(width: 3),
                                Text('Bath ', style: TextStyle(fontSize: 12)),
                                Icon(Icons.air, size: 20),
                                SizedBox(width: 8),
                                Text('Air conditioning ',
                                    style: TextStyle(fontSize: 12)),
                                Icon(Icons.bathroom, size: 20),
                                SizedBox(width: 8),
                                Text('Private bathroom ',
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text('Price is for one night.',
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            Text(
                              'Price: ${roomData['price']} JD',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookingScreen(
                                      hotelId: hotelId,
                                      roomType: roomData['type'],
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF3A1B0F), // Background color
                              ),
                              child: Text(
                                'Book this Room',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
