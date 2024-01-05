import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:tour/Widgets/BottomNavigationBar.dart'; // Import for date formatting

class BookingHistoryScreen extends StatelessWidget {
  final String userEmail;
  final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

  BookingHistoryScreen({required this.userEmail});

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
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Users')
            .doc(userEmail)
            .collection('bookedhotel')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No Booking Found",
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

              var entryDate =
                  dateFormatter.format((bookingData['entryDate'] as Timestamp).toDate());
              var exitDate =
                  dateFormatter.format((bookingData['exitDate'] as Timestamp).toDate());

              var roomType = bookingData['roomType'];
              var hotelId = bookingData['hotelId'];
              var adults = bookingData['adults'];
              var children = bookingData['children'];
              var price = bookingData['price']; 

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
                        'Room Type: $roomType',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                          // Display the price
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
                                    .doc(userEmail)
                                    .collection('bookedhotel')
                                    .doc(bookingId)
                                    .delete();

                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Booking cancelled successfully')),
                                );
                              } catch (e) {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Failed to cancel booking')),
                                );
                              }
                            },
                          ).show();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: AppColors.buttomcolor,
                        ),
                        child: const Text('Cancel Booking'),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 2),
    );
  }
}