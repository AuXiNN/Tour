import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  bool paymentMethod = false;

  DateTime? selectedEntryDate;
  DateTime? selectedExitDate;

  // Additional controllers for payment card data
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

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
    if (step == 1 && validateStep1()) {
      setState(() {
        step++;
      });
    } else if (step == 2 && validateStep2()) {
      setState(() {
        step++;
      });
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
                    
                    await FirebaseFirestore.instance.collection('bookingrooms').add(userData);
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
      // user data
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


      try {
        await FirebaseFirestore.instance.collection('bookingrooms').add(userData);
      } catch (e) {
        print('Error uploading user data: $e');
        return;
      }

      Navigator.pop(context);
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
                  const Text('Number of Adults:'),
                  TextField(
                    controller: adultsController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Text('Number of Children:'),
                  TextField(
                    controller: childrenController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(16.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Text('Check-in:'),
                  InkWell(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != selectedEntryDate) {
                        setState(() {
                          selectedEntryDate = pickedDate;
                        });
                      }
                    },
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
                              ? selectedEntryDate!.toLocal().toString().split(' ')[0]
                              : 'Select check-in Date',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Text('Check-out:'),
                  InkWell(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null && pickedDate != selectedExitDate) {
                        setState(() {
                          selectedExitDate = pickedDate;
                        });
                      }
                    },
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
                          selectedExitDate != null
                              ? selectedExitDate!.toLocal().toString().split(' ')[0]
                              : 'Select check-out Date',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.25),
                    child: ElevatedButton(
                      onPressed: moveToNextStep,
                      child: const Text('Next', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(primary: Color(0xFF3A1B0F)),
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
                          child: const Text('Book Now', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(primary: Color(0xFF3A1B0F)),
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
