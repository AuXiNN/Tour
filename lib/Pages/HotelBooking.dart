import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:tour/Widgets/CardNumberAndExpiryDate.dart';

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
  String selectedCountryCode = '+962'; // Default country code

  bool paymentMethod = false;
  bool showValidationMessage = false;
  bool showPaymentValidationMessage = false;

  DateTime? selectedEntryDate;
  DateTime? selectedExitDate;

  String? checkInDateValidationError;
  String? checkOutDateValidationError;

  List<String> adultOptions = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
  List<String> childOptions = ['None', '1', '2', '3', '4', '5'];

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Booking",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.buttomcolor,
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
                  DropdownButtonFormField<String>(
                    value: adultOptions.first, // Default value
                    decoration: const InputDecoration(
                      labelText: '* Number of Adults',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String? newValue) {
                      // Update the state with the new value
                      setState(() {
                        adultsController.text = newValue!;
                      });
                    },
                    items: adultOptions
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 50),
                  DropdownButtonFormField<String>(
                    value: childOptions.first, // Default value
                    decoration: const InputDecoration(
                      labelText: '* Number of Children',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String? newValue) {
                      // Update the state with the new value
                      setState(() {
                        childrenController.text =
                            newValue == 'None' ? '0' : newValue!;
                      });
                    },
                    items: childOptions
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 50),
                  const Text('* Check-in:',  style: TextStyle(fontWeight: FontWeight.bold),),
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
                  const Text('* Check-out:', style: TextStyle(fontWeight: FontWeight.bold),),
                  InkWell(
                    onTap: () => selectCheckOutDate(
                        context), // Corrected to call selectCheckOutDate
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
                              ? DateFormat('yyyy-MM-dd').format(
                                  selectedExitDate!) // Corrected to show selectedExitDate
                              : 'Select check-out Date',
                          style: TextStyle(
                            color: checkOutDateValidationError != null
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
                  const Text(
                    'First Name:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
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
                  const Text(
                    'Last Name:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
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
                  const Text(
                    'Email:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        DropdownButton<String>(
                          value: selectedCountryCode,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCountryCode = newValue!;
                              phoneController
                                  .clear(); // Clear phone number field on country change
                            });
                          },
                          items: countryCodeLength.keys
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        Expanded(
                          child: TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              hintText: 'Enter phone number',
                              errorText: showValidationMessage &&
                                      !_validatePhoneNumber(
                                          phoneController.text)
                                  ? 'Invalid phone number'
                                  : null,
                            ),
                          ),
                        ),
                      ],
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

  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && user.email != null) {
      // Fetch user data from Firestore
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.email)
          .get();

      if (userData.exists) {
        Map<String, dynamic> data = userData.data() as Map<String, dynamic>;
        setState(() {
          // Set data to controllers
          firstNameController.text = data['first_name'] ?? '';
          lastNameController.text = data['last_name'] ?? '';
          emailController.text = user.email ?? ''; // Email from Firebase Auth
        });
      }
    }
  }

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
    checkInDateValidationError = null;
    checkOutDateValidationError = null;

    if (adultsController.text.isEmpty ||
        childrenController.text.isEmpty ||
        selectedEntryDate == null ||
        selectedExitDate == null) {
      showValidationMessage = true;
    } else {
      showValidationMessage = false;
    }

    if (selectedEntryDate == null) {
      checkInDateValidationError = 'Please select a check-in date';
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

  bool _validatePaymentData() {
    // Implement validation logic here
    // Example:
    bool isCardNumberValid =
        cardNumberController.text.length == 19; // 16 digits plus 3 spaces
    bool isExpiryDateValid = _isValidExpiryDate(expiryDateController.text);
    bool isCvvValid = cvvController.text.length == 3;

    return isCardNumberValid && isExpiryDateValid && isCvvValid;
  }

  void showPaymentBottom() {
    showPaymentValidationMessage = false; // Reset validation flag

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows the sheet to expand to full height
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 16.0,
              // Adjust bottom padding dynamically to account for keyboard
              bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Enter Payment Card Data:'),
                const SizedBox(height: 20),
                TextField(
                  controller: cardNumberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CardNumberInputFormatter(),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                    hintText: 'XXXX XXXX XXXX XXXX',
                    border: OutlineInputBorder(),
                    errorText: cardNumberController.text.isEmpty
                        ? 'Card number is required'
                        : null,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: expiryDateController,
                  keyboardType: TextInputType.datetime,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                    LengthLimitingTextInputFormatter(5),
                    ExpiryDateInputFormatter(),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Expiry Date',
                    hintText: 'MM/YY',
                    border: OutlineInputBorder(),
                    errorText: expiryDateController.text.isEmpty
                        ? 'Expiry date is required'
                        : !_isValidExpiryDate(expiryDateController.text)
                            ? 'Invalid date'
                            : null,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: cvvController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  decoration: InputDecoration(
                    labelText: 'CVV',
                    hintText: 'XXX',
                    border: OutlineInputBorder(),
                    errorText: cvvController.text.isEmpty
                        ? 'CVV is required'
                        : cvvController.text.length != 3
                            ? 'Invalid CVV'
                            : null,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      showPaymentValidationMessage =
                          true; // Enable validation messages
                    });

                    // Check if payment data is valid
                    if (_validatePaymentData()) {
                      // Payment data is valid, proceed with saving
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
                        Navigator.pop(
                            context); // Close the modal after saving data
                      } catch (e) {
                        print('Error uploading user data: $e');
                      }
                    } else {
                      // Payment data is invalid, show error message or handle accordingly
                    }
                  },
                  child: const Text('Save Payment Data'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //methods
  void bookNow() async {
    setState(() {
      showValidationMessage = true; // Trigger validation messages
    });

    if (!_validatePhoneNumber(phoneController.text)) {
      // Show a toast message that the phone number is invalid
      Fluttertoast.showToast(
        msg: "Invalid phone number. Please enter a valid number.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return; // Stop the booking process
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Booking"),
          content: Text("Are you sure you want to book this room?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Confirm"),
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog

                try {
                  // Perform booking logic here
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
                    // Add other required fields
                  };
                  if (paymentMethod) {
                    userData.addAll({
                      'visaPayment': {
                        'cardNumber': cardNumberController.text,
                        'expiryDate': expiryDateController.text,
                        'cvv': cvvController.text,
                      },
                    });
                  }

                  await FirebaseFirestore.instance
                      .collection('Users')
                      .doc(FirebaseAuth.instance.currentUser?.email)
                      .collection('bookedhotel')
                      .add(userData);

                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Booking successful!")),
                  );

                  // Navigate to another screen or perform other actions
                } catch (e) {
                  // Handle errors
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to complete booking")),
                  );
                }
              },
            ),
          ],
        );
      },
    );
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
      });
    }
  }

  Future<void> selectCheckOutDate(BuildContext context) async {
    if (selectedEntryDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select check-in date first')),
      );
      return;
    }

    DateTime initialCheckOutDate =
        selectedExitDate ?? selectedEntryDate!.add(const Duration(days: 1));
    if (initialCheckOutDate.isBefore(selectedEntryDate!)) {
      initialCheckOutDate = selectedEntryDate!.add(const Duration(days: 1));
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialCheckOutDate,
      firstDate: selectedEntryDate!.add(const Duration(days: 1)),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedExitDate) {
      setState(() {
        selectedExitDate = picked;
      });
    }
  }

  Map<String, int> countryCodeLength = {
    '+962': 9, // Jordan: 9 digits after the country code
    '+1': 10, // USA and Canada
    '+44': 10, // UK
    '+61': 9, // Australia
    '+91': 10, // India
    '+49': 10, // Germany
    '+33': 9, // France
    '+55': 10, // Brazil
    '+27': 9, // South Africa
    '+39': 10, // Italy
    '+34': 9, // Spain
    '+7': 10, // Russia
    '+86': 11, // China
    '+81': 10, // Japan
    '+52': 10, // Mexico
    '+31': 9, // Netherlands
    '+46': 7, // Sweden (minimum length)
    '+47': 8, // Norway
    '+48': 9, // Poland
    '+82': 8, // South Korea (minimum length)
  };

  bool _validatePhoneNumber(String number) {
    int requiredLength = countryCodeLength[selectedCountryCode] ?? 0;
    return number.isNotEmpty && number.length == requiredLength;
  }

  bool _isValidExpiryDate(String date) {
    if (date.length != 5 || !date.contains('/')) return false;
    final parts = date.split('/');
    if (parts.length != 2) return false;

    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);

    if (month == null || month < 1 || month > 12) return false;

    // Get the last two digits of the current year
    int currentYearLastTwoDigits =
        int.parse(DateFormat('yy').format(DateTime.now()));

    // Check if the year part of the expiry date is valid
    if (year == null || year < currentYearLastTwoDigits) return false;

    return true;
  }
}
