import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour/AppColors/colors.dart';

class AmmanHotelsRoom extends StatelessWidget {
  final String hotelId;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AmmanHotelsRoom({required this.hotelId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.buttomcolor,
        centerTitle: true,
        title: const Text(
          'Hotel Details',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
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
                      Text(
                        'Name: ${hotelData['name']} ',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
              stream: _firestore
                  .collection('hotels')
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
                            color: AppColors.accentColor,
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
