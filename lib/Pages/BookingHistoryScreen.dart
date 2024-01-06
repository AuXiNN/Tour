import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:tour/Widgets/BottomNavigationBar.dart';

class BookingHistoryScreen extends StatefulWidget {
  final String userEmail;

  BookingHistoryScreen({required this.userEmail});

  @override
  _BookingHistoryScreenState createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: const Text(
          "Booking History",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: AppColors.buttomcolor,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Hotel Bookings'),
            Tab(text: 'Table Bookings'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildHotelBookings(),
          _buildTableBookings(),
        ],
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 2),
    );
  }

  Widget _buildHotelBookings() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.userEmail)
          .collection('bookedhotel')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              "No Hotel Bookings Found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          );
        }

        var bookings = snapshot.data!.docs;
        return ListView.builder(
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            var bookingData = bookings[index].data() as Map<String, dynamic>;
            var bookingId = bookings[index].id;
            String hotelId = bookingData['hotelId'];

            return FutureBuilder<DocumentSnapshot>(
              future: getHotelName(hotelId),
              builder: (context, hotelSnapshot) {
                if (!hotelSnapshot.hasData) {
                  return ListTile(
                    title: const Text("Loading hotel info..."),
                  );
                }

                Map<String, dynamic> hotelData =
                    hotelSnapshot.data!.data() as Map<String, dynamic>;
                String hotelName = hotelData['name'] ?? 'Unknown Hotel';
                String entryDate = dateFormatter
                    .format((bookingData['entryDate'] as Timestamp).toDate());
                String exitDate = dateFormatter
                    .format((bookingData['exitDate'] as Timestamp).toDate());

                return buildHotelBookingTile(bookingData, entryDate, exitDate,
                    hotelName, hotelId, bookingId);
              },
            );
          },
        );
      },
    );
  }

  Future<DocumentSnapshot> getHotelName(String hotelId) async {
    List<String> collections = [
      'hotels',
      'aqaba_hotels',
      'deadsea_hotel',
      'jerash_hotels',
      'petra_hotels',
      'ajloun_hotels',
      'wadirum_hotels',
    ];

    for (String collection in collections) {
      var doc = await FirebaseFirestore.instance
          .collection(collection)
          .doc(hotelId)
          .get();
      if (doc.exists) {
        return doc;
      }
    }
    throw Exception("Hotel not found in any collection");
  }

  Widget buildHotelBookingTile(
      Map<String, dynamic> bookingData,
      String entryDate,
      String exitDate,
      String hotelName,
      String hotelId,
      String bookingId) {
    var firstName = bookingData['firstName'] ?? 'N/A';
    var lastName = bookingData['lastName'] ?? 'N/A';
    var adults = bookingData['adults'];
    var children = bookingData['children'];
    var price = bookingData['price'];
    var roomType = bookingData['roomType'];

    // Build your ListTile or other widget using bookingData and the fetched hotelName
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.accentColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Hotel: $hotelName',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Room Type: ${bookingData['roomType']}',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Text(
                  'First Name: $firstName',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Text(
                  'Last Name: $lastName',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Text(
                  'Check-in: $entryDate',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Text(
                  'Check-out: $exitDate',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Text(
                  'Adults: $adults',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Text(
                  'Children: $children',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Text(
                  'Price: $price JOD',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () async {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.bottomSlide,
                  title: 'Cancel Booking',
                  desc: 'Are you sure you want to cancel?',
                  btnCancelOnPress: () {
                    // If 'No' pressed, do nothing
                  },
                  btnOkOnPress: () async {
                    // If 'Yes' pressed, proceed to cancel the booking
                    try {
                      await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(widget.userEmail)
                          .collection('bookedhotel')
                          .doc(bookingId)
                          .delete();

                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Booking cancelled successfully')),
                      );
                    } catch (e) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Failed to cancel booking')),
                      );
                    }
                  },
                ).show();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.buttomcolor,
              ),
              child: const Text('Cancel Booking'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableBookings() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.userEmail)
          .collection('table_bookings')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text(
              "No Table Bookings Found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          );
        }

        var bookings = snapshot.data!.docs;
        return ListView.builder(
          itemCount: bookings.length,
          itemBuilder: (context, index) {
            var bookingData = bookings[index].data() as Map<String, dynamic>;
            var bookingId = bookings[index].id;
            String restaurantId = bookingData['restaurantId'];

            return FutureBuilder<DocumentSnapshot>(
              future: getRestaurantName(restaurantId),
              builder: (context, restaurantSnapshot) {
                if (!restaurantSnapshot.hasData) {
                  return ListTile(
                    title: const Text("Loading restaurant info..."),
                  );
                }

                Map<String, dynamic> restaurantData =
                    restaurantSnapshot.data!.data() as Map<String, dynamic>;
                String restaurantName =
                    restaurantData['name'] ?? 'Unknown Restaurant';
                String reservationDate = dateFormatter.format(
                    (bookingData['reservationDate'] as Timestamp).toDate());
                String reservationTime = bookingData['reservationTime'];

                return buildBookingTile(bookingData, reservationDate,
                    reservationTime, restaurantName, bookingId);
              },
            );
          },
        );
      },
    );
  }

  Future<DocumentSnapshot> getRestaurantName(String restaurantId) async {
    // List of all restaurant collections
    List<String> collections = [
      'amman_restaurants',
      'aqaba_restaurants',
      'jerash_restaurants',
      'ajloun_restaurants',
      'petra_restaurants',
      'deadsea_restaurants',
      'wadirum_restaurants'
    ];

    for (String collection in collections) {
      var doc = await FirebaseFirestore.instance
          .collection(collection)
          .doc(restaurantId)
          .get();
      if (doc.exists) {
        return doc;
      }
    }
    throw Exception("Restaurant not found in any collection");
  }

  Widget buildBookingTile(
      Map<String, dynamic> bookingData,
      String reservationDate,
      String reservationTime,
      String restaurantName,
      String bookingId) {
    String firstName = bookingData['firstName'] ?? 'N/A';
    String lastName = bookingData['lastName'] ?? 'N/A';
    String numberOfPersons = bookingData['numberOfPersons'].toString();
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.accentColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Restaurant: $restaurantName',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'First Name: $firstName',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Text(
                  'Last Name: $lastName',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                 Text(
                  'Number of People: $numberOfPersons',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Text(
                  'Date: $reservationDate',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                Text(
                  'Time: $reservationTime',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                // Additional fields can be added here
              ],
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () async {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.warning,
                  animType: AnimType.bottomSlide,
                  title: 'Cancel Booking',
                  desc: 'Are you sure you want to cancel?',
                  btnCancelOnPress: () {
                    // If 'No' pressed, do nothing
                  },
                  btnOkOnPress: () async {
                    // If 'Yes' pressed, proceed to cancel the booking
                    try {
                      await FirebaseFirestore.instance
                          .collection('Users')
                          .doc(widget.userEmail)
                          .collection('table_bookings')
                          .doc(bookingId)
                          .delete();

                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Booking cancelled successfully')),
                      );
                    } catch (e) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Failed to cancel booking')),
                      );
                    }
                  },
                ).show();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppColors.buttomcolor,
              ),
              child: const Text('Cancel Booking'),
            ),
          ),
        ],
      ),
    );
  }
}
