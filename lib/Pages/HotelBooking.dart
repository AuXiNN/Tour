import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  final String hotelId;
  final String roomType;

  BookingScreen({required this.hotelId, required this.roomType});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int step = 1;
  TextEditingController adultsController = TextEditingController();
  TextEditingController childrenController = TextEditingController();
  TextEditingController entryController = TextEditingController();
  TextEditingController exitController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  bool paymentMethod = false;
  bool showValidationMessage = false;

  DateTime? selectedEntryDate;
  DateTime? selectedExitDate;

  String? checkInDateValidationError;
  String? checkOutDateValidationError;

  bool validateStep1() {
    return adultsController.text.isNotEmpty &&
        childrenController.text.isNotEmpty &&
        selectedEntryDate != null &&
        selectedExitDate != null;
  }

  bool validateStep2() {
    return firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty;
  }

  void moveToNextStep() {
    // Validate check-in and check-out dates
    if (selectedEntryDate == null) {
      checkInDateValidationError = 'Please select a check-in date';
    } else {
      checkInDateValidationError = null;
    }

    if (selectedExitDate == null) {
      checkOutDateValidationError = 'Please select a check-out date';
    } else {
      checkOutDateValidationError = null;
    }

    if (step == 1 &&
        validateStep1() &&
        checkInDateValidationError == null &&
        checkOutDateValidationError == null) {
      setState(() => step++);
    } else {
      setState(() {});
    }
  }

  void showPaymentBottom() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter Payment Card Data:'),
              const SizedBox(height: 20),
              TextField(
                controller: cardNumberController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Card Number',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: expiryDateController,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  labelText: 'Expiry Date',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: cvvController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  var userData = {
                    'hotelId': widget.hotelId,
                    'roomType': widget.roomType,
                    'adults': adultsController.text,
                    'children': childrenController.text,
                    'entryDate': selectedEntryDate,
                    'exitDate': selectedExitDate,
                    'firstName': firstNameController.text,
                    'lastName': lastNameController.text,
                    'email': emailController.text,
                    'phone': phoneController.text,
                    'paymentMethod': 'Visa',
                    'visaPayment': {
                      'cardNumber': cardNumberController.text,
                      'expiryDate': expiryDateController.text,
                      'cvv': cvvController.text,
                    },
                  };

                  try {
                    await FirebaseFirestore.instance
                        .collection('bookingrooms')
                        .add(userData);
                  } catch (e) {
                    print('Error uploading user data: $e');
                  }

                  Navigator.pop(context);
                },
                child: const Text('Save Payment Data'),
              ),
            ],
          ),
        );
      },
    );
  }

  void bookNow() async {
    if (validateStep1() && validateStep2()) {
      // User data
      var userData = {
        'hotelId': widget.hotelId,
        'roomType': widget.roomType,
        'adults': adultsController.text,
        'children': childrenController.text,
        'entryDate': selectedEntryDate,
        'exitDate': selectedExitDate,
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'paymentMethod': paymentMethod ? 'Visa' : 'Cash',
      };

      // Get current user
      User? currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        try {
          // Add booking data to the bookedhotel sub-collection of the current user
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(currentUser.email)
              .collection('bookedhotel')
              .add(userData);

          // Optional: Update global bookingrooms collection if needed
          // await FirebaseFirestore.instance.collection('bookingrooms').add(userData);

          Navigator.pop(context);
        } catch (e) {
          print('Error uploading user data: $e');
          return;
        }
      } else {
        print('User not logged in');
      }
    }
  }

  Future<void> selectCheckInDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEntryDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedEntryDate) {
      setState(() {
        selectedEntryDate = picked;
        selectedExitDate = null; // Reset the check-out date
        checkInDateValidationError = null;
      });
    }
  }

  Future<void> selectCheckOutDate(BuildContext context) async {
    if (selectedEntryDate == null) {
      setState(() {
        checkOutDateValidationError = 'Please select check-in date first';
      });
      return;
    }

    final DateTime initialCheckOutDate =
        selectedExitDate ?? selectedEntryDate!.add(const Duration(days: 1));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialCheckOutDate,
      firstDate: selectedEntryDate!.add(const Duration(days: 1)),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedExitDate) {
      setState(() {
        selectedExitDate = picked;
        checkOutDateValidationError = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking'),
        backgroundColor: const Color.fromARGB(255, 248, 225, 218),
      ),
      backgroundColor: const Color.fromARGB(255, 248, 225, 218),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (step == 1)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('* Number of Adults: '),
                  TextField(
                    controller: adultsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      errorText:
                          showValidationMessage && adultsController.text.isEmpty
                              ? 'Please enter the number of adults'
                              : null,
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Text('* Number of Children:'),
                  TextField(
                    controller: childrenController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      errorText:
                          showValidationMessage && adultsController.text.isEmpty
                              ? 'Please enter the number of Children'
                              : null,
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Text('Check-in:'),
                  InkWell(
                    onTap: () => selectCheckInDate(context),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          selectedEntryDate != null
                              ? DateFormat('yyyy-MM-dd')
                                  .format(selectedEntryDate!)
                              : 'Select check-in Date',
                          style: TextStyle(
                            color: checkInDateValidationError != null
                                ? Colors.red
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (checkInDateValidationError != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                      child: Text(
                        checkInDateValidationError!,
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  const SizedBox(height: 50),
                  const Text('Check-out:'),
                  InkWell(
                    onTap: () => selectCheckOutDate(context),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          selectedEntryDate != null
                              ? DateFormat('yyyy-MM-dd')
                                  .format(selectedEntryDate!)
                              : 'Select check-in Date',
                          style: TextStyle(
                            color: checkInDateValidationError != null
                                ? Colors.red
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (checkOutDateValidationError != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 8.0),
                      child: Text(
                        checkOutDateValidationError!,
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ),
                  const SizedBox(height: 50),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.25),
                    child: ElevatedButton(
                      onPressed: moveToNextStep,
                      child: const Text('Next',
                          style: TextStyle(color: Colors.white)),
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xFF3A1B0F)),
                    ),
                  ),
                ],
              ),
            if (step == 2)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('First Name:'),
                  TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text('Last Name:'),
                  TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text('Email:'),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text('Phone Number:'),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Select Payment Method:'),
                      Row(
                        children: [
                          Radio(
                            value: false,
                            groupValue: paymentMethod,
                            onChanged: (value) {
                              setState(() {
                                paymentMethod = value as bool;
                              });
                              if (paymentMethod) {
                                showPaymentBottom();
                              }
                            },
                          ),
                          const Text('Cash'),
                          const SizedBox(width: 16),
                          Radio(
                            value: true,
                            groupValue: paymentMethod,
                            onChanged: (value) {
                              setState(() {
                                paymentMethod = value as bool;
                              });
                              if (paymentMethod) {
                                showPaymentBottom();
                              }
                            },
                          ),
                          const Text('Visa'),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.25),
                        child: ElevatedButton(
                          onPressed: bookNow,
                          child: const Text('Book Now',
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFF3A1B0F)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
