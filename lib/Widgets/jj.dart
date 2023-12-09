import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HotelListScreen(),
    );
  }
}

class HotelListScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('hotels').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var hotels = snapshot.data!.docs;
            return ListView.builder(
              itemCount: hotels.length,
              itemBuilder: (context, index) {
                var hotel = hotels[index];
                return ListTile(
                  title: Text(hotel['name']),
                  subtitle: Text(hotel['location']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HotelDetailsScreen(hotelId: hotel.id),
                      ),
                    );
                  },
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
    );
  }
}

class HotelDetailsScreen extends StatelessWidget {
  final String hotelId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  HotelDetailsScreen({required this.hotelId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: _firestore.collection('hotels').doc(hotelId).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var hotelData = snapshot.data!.data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${hotelData['name']} ',style: const TextStyle( fontWeight: FontWeight.bold, ),),
                      Text('Location: ${hotelData['location']}'),
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
              stream: _firestore.collection('hotels').doc(hotelId).collection('rooms').snapshots(),
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
                            color: Color.fromARGB(255, 244, 164, 96),
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.bed,size: 20,),
                                const SizedBox(width: 5),
                                Text('${roomData['Bed']}', style: const TextStyle( fontSize: 16,),),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Row(
                              children: [
                                Icon(Icons.coffee, size: 20,),
                                SizedBox(width: 5),
                                Text('Breakfast included', style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Row(
                              children: [
                                Icon(Icons.wifi,size:20),
                                SizedBox(width: 8),
                                Text('Free Wi-Fi ',style: TextStyle(fontSize: 12)),
                                Icon(Icons.balcony,size:20),
                                SizedBox(width: 8),
                                Text('Balcony ',style: TextStyle(fontSize: 12)),
                                Icon(Icons.pool,size:20),
                                SizedBox(width: 8),
                                Text('Pool view ',style: TextStyle(fontSize: 12)),
                                Icon(Icons.location_city,size:20),
                                SizedBox(width: 8),
                                Text('City View ',style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Row(
                              children: [
                                Icon(Icons.bathroom,size:20),
                                SizedBox(width: 3),
                                Text('Bath ',style: TextStyle(fontSize: 12)),
                                Icon(Icons.air,size:20),
                                SizedBox(width: 8),
                                Text('Air conditioning ',style: TextStyle(fontSize: 12)),
                                Icon(Icons.bathroom,size:20),
                                SizedBox(width: 8),
                                Text('Private bathroom ',style: TextStyle(fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 10),
                              Text('Price is for one night.', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            Text('Price: ${roomData['price']} JD',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                          
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
    );
  }
}