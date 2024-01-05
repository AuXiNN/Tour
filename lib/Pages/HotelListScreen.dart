import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:tour/Pages/HotelBooking.dart';
import 'package:tour/Widgets/BottomNavigationBar.dart';
import 'package:url_launcher/url_launcher.dart';

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
  final Set<String> userFavorites =
      {}; 

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
  void initState() {
    super.initState();
    updateFavorites();
  }

  Future<void> updateFavorites() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String userEmail = currentUser.email!;
      var favoritesSnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userEmail)
          .collection('favorites')
          .get();

      setState(() {
        userFavorites.clear();
        for (var doc in favoritesSnapshot.docs) {
          userFavorites.add(doc.id); // Assuming the doc ID is the hotel ID
        }
      });
    }
  }

  void toggleFavoriteHotel(String hotelId, String hotelName) async {
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
        .collection('favorites');

    bool isCurrentlyFavorite = userFavorites.contains(hotelId);

    if (isCurrentlyFavorite) {
      // If it's currently a favorite, remove it
      favoritesRef.doc(hotelId).delete();
      userFavorites.remove(hotelId);
      Fluttertoast.showToast(
        msg: "$hotelName has been removed from Favorites",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      // If it's not a favorite, add it
      favoritesRef.doc(hotelId).set({
        'name': hotelName,
        // You can add more hotel details if needed
      });
      userFavorites.add(hotelId);
      Fluttertoast.showToast(
        msg: "$hotelName has been added to Favorites",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }

    setState(() {
 
    });
  }

  @override
  Widget build(BuildContext context) {
    String collectionName = _getCollectionName(widget.city);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hotel List',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.buttomcolor,
        centerTitle: true,
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
                child: Text(
                  option == SortOption.rating ? 'Sort by Rating' : 'Sort A-Z',
                  style:
                      const TextStyle(color: Color.fromARGB(255, 141, 105, 91)),
                ),
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
                                Stack(
                                  alignment: Alignment
                                      .topRight, // Align the icon to the top right
                                  children: [
                                    // Hotel Image
                                    FutureBuilder<String>(
                                      future: _storage
                                          .ref(
                                              '$collectionName/${hotelData['image']}')
                                          .getDownloadURL(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<String> urlSnapshot) {
                                        if (urlSnapshot.connectionState ==
                                                ConnectionState.done &&
                                            urlSnapshot.hasData) {
                                          return Image.network(
                                            urlSnapshot.data!,
                                            height:
                                                250.0, // Set your preferred height
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          );
                                        } else {
                                          return CircularProgressIndicator(); // Or some placeholder widget
                                        }
                                      },
                                    ),

                                    // Favorite Icon Button
                                    IconButton(
                                      icon: Icon(
                                        userFavorites.contains(hotel.id)
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: Colors.red,
                                      ),
                                      onPressed: () => toggleFavoriteHotel(
                                          hotel.id, hotelData['name']),
                                    ),
                                  ],
                                ),
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
                                      const SizedBox(
                                          width:
                                              8), // Spacing between the stars and the rating number
                                      Text(
                                        '$rating', // Display the rating number
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
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
bottomNavigationBar: BottomNav(isHomeEnabled: true)  // If this is the third tab
    );
  }
}

class HotelDetailsScreen extends StatelessWidget {
  final String hotelId;
  final String collectionName;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  HotelDetailsScreen({required this.hotelId, required this.collectionName});

  Future<List<String>> _getHotelImages(String hotelStorageFolder) async {
    final ListResult result = await _storage.ref(hotelStorageFolder).listAll();
    List<String> urls = [];
    for (var ref in result.items) {
      String url = await ref.getDownloadURL();
      urls.add(url);
    }
    return urls;
  }

  void _makePhoneCall(String phoneNumber) async {
    String formattedNumber = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    final Uri uri = Uri.parse('tel:$formattedNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('Could not call $formattedNumber'); // Debug statement
    }
  }

 Future<void> _launchURL(String url) async {
  try {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      Fluttertoast.showToast(
        msg: "Could not launch the URL",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  } catch (e) {
    Fluttertoast.showToast(
      msg: "An error occurred: $e",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
  
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: FutureBuilder<DocumentSnapshot>(
          future: _firestore.collection(collectionName).doc(hotelId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Text(
                data['name'] ??
                    'Hotel Details', // Display the hotel name, fallback to 'Hotel Details' if name is not found
                style: const TextStyle(color: Colors.white),
              );
            } else {
              return const Text('Loading...',
                  style: TextStyle(color: Colors.white));
            }
          },
        ),
        backgroundColor: AppColors.buttomcolor,
      ),
      backgroundColor: const Color.fromARGB(255, 248, 225, 218),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            StreamBuilder<DocumentSnapshot>(
              stream: _firestore
                  .collection(collectionName)
                  .doc(hotelId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!.data() != null) {
                  var hotelData = snapshot.data!.data() as Map<String, dynamic>;
                  String phone =
                      hotelData['phone'] ?? ''; // Retrieve phone number
                  String website =
                      hotelData['website'] ?? ''; // Retrieve website URL
                  String storagePath;

                  if (hotelData['name'] == 'Amman Marriott Hotel') {
                    storagePath = 'marriot_hotel';
                  } else if (hotelData['name'] == 'Amman Paradise Hotel') {
                    storagePath = 'paradise_hotel';
                  } else if (hotelData['name'] == 'Le Royal Hotel') {
                    storagePath = 'le_royal_hotel';
                  } else if (hotelData['name'] == 'DownTown Hotel') {
                    storagePath = 'downtown_hotel';
                  } else if (hotelData['name'] == 'InterContinental Aqaba') {
                    storagePath = 'Intercontinental_aqaba_hotel';
                  } else if (hotelData['name'] == 'Mövenpick Aqaba') {
                    storagePath = 'movenpick_aqaba_hotel';
                  } else if (hotelData['name'] ==
                      'DoubleTree by Hilton Aqaba') {
                    storagePath = 'doubletree_hilton_aqaba_hotel';
                  } else if (hotelData['name'] == 'Mass Paradise Hotel') {
                    storagePath = 'mass_paradise_hotel';
                  } else if (hotelData['name'] == 'Dream House Hotel') {
                    storagePath = 'dream_house_hotel';
                  } else if (hotelData['name'] == 'Jerash City View') {
                    storagePath = 'jerash_city_view_hotel';
                  } else if (hotelData['name'] == 'Ajloun Forest') {
                    storagePath = 'ajloun_forest_hotel';
                  } else if (hotelData['name'] == 'Petra Moon Luxury Hotel') {
                    storagePath = 'petra_moon_luxury_hotel';
                  } else if (hotelData['name'] ==
                      'The Old Village Hotel & Resort') {
                    storagePath = 'old_village_petra_hotel';
                  } else if (hotelData['name'] == 'Seven Wonders Luxury Camp') {
                    storagePath = 'seven_wonders_luxury_camp_hotel';
                  } else if (hotelData['name'] == 'Petra Elite Hotel') {
                    storagePath = 'petra_elite_hotel';
                  } else if (hotelData['name'] == 'Hilton Dead Sea') {
                    storagePath = 'hilton_dead_sea_hotel';
                  } else if (hotelData['name'] == 'Mövenpick Dead Sea') {
                    storagePath = 'movenpick_deadsea_hotel';
                  } else if (hotelData['name'] ==
                      'Kempinski Hotel Ishtar Dead Sea') {
                    storagePath = 'kempinski_hotel_ishtar_deadsea';
                  } else if (hotelData['name'] ==
                      'Holiday Inn Resort Dead Sea') {
                    storagePath = 'holiday_inn_deadsea_hotel';
                  } else if (hotelData['name'] == 'Rum Angel Camp') {
                    storagePath = 'rum_angel_camp_hotel';
                  } else if (hotelData['name'] == 'Star Camp') {
                    storagePath = 'star_camp_hotel';
                  } else if (hotelData['name'] == 'Rum Oasis Luxury Camp') {
                    storagePath = 'rum_oasis_luxury_camp';
                  } else {
                    storagePath =
                        'default_images'; // default path if hotel name doesn't match
                  }

                  return FutureBuilder<List<String>>(
                    future: _getHotelImages(storagePath),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<String>> imageSnapshot) {
                      if (imageSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!imageSnapshot.hasData ||
                          imageSnapshot.data!.isEmpty) {
                        return const Center(child: Text('No images available'));
                      }
                      return Column(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 200.0,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              aspectRatio: 16 / 9,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              viewportFraction: 0.8,
                            ),
                            items: imageSnapshot.data!.map((url) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Image.network(url,
                                      fit: BoxFit.cover,
                                      width: double.infinity);
                                },
                              );
                            }).toList(),
                          ),

                          const SizedBox(
                              height:
                                  30), // Space between CarouselSlider and TextButton widgets
                          // Rest of your code goes here...
                          if (phone
                              .isNotEmpty) // Check if the phone number is not empty
                            TextButton(
                              onPressed: () => _makePhoneCall('tel:$phone'),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.phone,
                                      color: AppColors.buttomcolor),
                                  const SizedBox(width: 5),
                                  Text(
                                    phone,
                                    style: const TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: AppColors.buttomcolor,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (website
                              .isNotEmpty) // Check if the website URL is not empty
                            TextButton(
                              onPressed: () => _launchURL(website),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.public,
                                      color: AppColors.buttomcolor),
                                  SizedBox(width: 5),
                                  Text(
                                    'Visit Website',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: AppColors.buttomcolor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (hotelData['email'] != null &&
                              hotelData['email']
                                  .isNotEmpty) // New check for email
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.email,
                                      color: AppColors.buttomcolor),
                                  SizedBox(width: 5),
                                  Text(
                                    hotelData['email'], // Display the email
                                    style: TextStyle(
                                      color: AppColors.buttomcolor,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      );
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Rooms:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection(collectionName)
                  .doc(hotelId)
                  .collection('rooms')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var rooms = snapshot.data!.docs;
                  return ListView.builder(
                    shrinkWrap: true, // Add shrinkWrap
                    physics:
                        const NeverScrollableScrollPhysics(), // Add this to ensure the list doesn't scroll separately
                    itemCount: rooms.length,
                    itemBuilder: (context, index) {
                      var room = rooms[index];
                      var roomData = room.data() as Map<String, dynamic>;
                      num oldPrice = roomData['oldPrice'] ?? roomData['price'];
                      num newPrice = roomData['newPrice'] ?? roomData['price'];
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
                            const Text('Price is for one night.',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            
                            const SizedBox(height: 5),
                                  Text(
                                        'Price: ${newPrice} JD',
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                              ),
                                              const SizedBox(height: 5),
                                   if (newPrice != oldPrice) // Check if there is a discount (yes/no)
                                    Text(
                                      'Old Price: ${oldPrice} JD',
                                      style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.red,
                                      decoration: TextDecoration.lineThrough,
                                        ),
                                          ),    
                            ElevatedButton(
                              onPressed: () {
                                // Check if the user is logged in
                                User? currentUser =
                                    FirebaseAuth.instance.currentUser;
                                if (currentUser != null) {
                                  // If the user is logged in, navigate to the BookingScreen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookingScreen(
                                        hotelId: hotelId,
                                        roomType: roomData['type'],
                                        price: roomData['price'],
                                      ),
                                    ),
                                  );
                                } else {
                                  // If the user is not logged in, show a dialog
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Login Required'),
                                        content: const Text(
                                            'You must be logged in to book a room.'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary:
                                    const Color(0xFF3A1B0F), // Background color
                              ),
                              child: const Text(
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
          ],
        ),
      ),
bottomNavigationBar:BottomNav(isHomeEnabled: true)  // If this is the third tab
    );
  }
}
