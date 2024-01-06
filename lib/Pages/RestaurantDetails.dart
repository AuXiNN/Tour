import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:tour/Widgets/BottomNavigationBar.dart';

class RestaurantDetails extends StatefulWidget {
  final String restaurantId;
  final String restaurantName;

  RestaurantDetails({required this.restaurantId, required this.restaurantName});

  @override
  _RestaurantDetailsState createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  late DateTime _selectedDate;
  int _numberOfPersons = 2;
  DateTime? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundcolor,
        appBar: AppBar(
          title: Text(
            widget.restaurantName, // Use the restaurant name as the title
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: AppColors.buttomcolor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text('Select Date:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              InkWell(
                onTap: () => _selectDate(context),
                child: const Row(
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(width: 8),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Person: $_numberOfPersons',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  ElevatedButton(
                    onPressed: () {
                      _showNumberOfPersonsDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttomcolor,
                    ),
                    child: const Text('Change Number of Persons',
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Times:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: _calculateNumberOfTimeSlots(),
                  itemBuilder: (context, index) {
                    DateTime startTime = DateTime(_selectedDate.year,
                        _selectedDate.month, _selectedDate.day, 16, 0);
                    DateTime tableTime =
                        startTime.add(Duration(minutes: 15 * index));
                    bool isSelected = _selectedTime == tableTime;
                    return GestureDetector(
                      onTap: () {
                        _toggleTimeSelection(tableTime);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? AppColors.buttomcolor
                              : Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            '${tableTime.hour}:${tableTime.minute}',
                            style: TextStyle(
                                color:
                                    isSelected ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _reserveTable(widget.restaurantId);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttomcolor,
                  ),
                  child: const Text('Book Table',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const BottomNav(isHomeEnabled: true));
  }

  int _calculateNumberOfTimeSlots() {
    return 20;
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _selectedTime =
            null; // Reset the selected time when a new date is picked
      });
    }
  }

  void _showNumberOfPersonsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Number of Persons'),
          content: DropdownButton<int>(
            value: _numberOfPersons,
            onChanged: (value) {
              setState(() {
                _numberOfPersons = value!;
              });
              Navigator.of(context).pop();
            },
            items: [1, 2, 3, 4, 5, 6, 7].map((int value) {
              return DropdownMenuItem<int>(
                value: value,
                child: Text('$value'),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void _toggleTimeSelection(DateTime time) {
    setState(() {
      if (_selectedTime == time) {
        _selectedTime = null; // Deselect if the same time is tapped again
      } else {
        _selectedTime = time; // Update to the new selected time
      }
    });
  }

  void _reserveTable(String restaurantId) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      Fluttertoast.showToast(
        msg: "You must be logged in to book a table",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }

    // Retrieve user's first name and last name
    String firstName = ''; // Placeholder for first name
    String lastName = ''; // Placeholder for last name
    var userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser.email) // Using UID to identify the user document
        .get();

    if (userDoc.exists) {
      firstName = userDoc.data()?['first_name'] ??
          ''; // Replace 'firstName' with your field name
      lastName = userDoc.data()?['last_name'] ??
          ''; // Replace 'lastName' with your field name
    }

    if (_selectedTime != null) {
      // Format the reservation time as a string (e.g., "18:45")
      String formattedTime = DateFormat('HH:mm').format(_selectedTime!);

      // Reference to the user's table bookings in Firestore
      var tableBookingsRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(currentUser.email) // Use the user's email
          .collection('table_bookings');

      await tableBookingsRef.add({
        'restaurantId': restaurantId,
        'reservationTime': formattedTime, // Store the formatted time
        'reservationDate': _selectedDate, // Store the selected date
        'numberOfPersons': _numberOfPersons,
        'firstName': firstName, // Add the first name
        'lastName': lastName, // Add the last name
      });

      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Table Reserved'),
            content: const Text('Your table has been successfully reserved.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      // Clear the selected time
      setState(() {
        _selectedTime = null;
      });
    } else {
      // Show error dialog if no time is selected
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content:
                const Text('Please select a time before booking the table.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
