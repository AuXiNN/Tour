import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:tour/Widgets/BottomNavigationBar.dart';

class RestaurantDetails extends StatefulWidget {
  final String restaurantId;

  RestaurantDetails({required this.restaurantId});

  @override
  _RestaurantDetailsState createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  late DateTime _selectedDate;
  int _numberOfPersons = 2;
  List<DateTime> _selectedTimes = [];

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
        title: const Text(
          'Availability',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: AppColors.buttomcolor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            InkWell(
              onTap: () => _selectDate(context),
              child: const Row(
                children: [
                  Icon(Icons.calendar_today),
                  SizedBox(width: 8),
                  Text('Select Date'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Person: $_numberOfPersons', style: const TextStyle(fontWeight: FontWeight.bold)),
                ElevatedButton(
                  onPressed: () {
                    _showNumberOfPersonsDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttomcolor,
                  ),
                  child: const Text('Change Number of Persons', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 16),
                const Text('Floor: 1', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Times:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: _calculateNumberOfTimeSlots(),
                itemBuilder: (context, index) {
                  DateTime startTime =
                      DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, 16, 0);
                  DateTime tableTime = startTime.add(Duration(minutes: 15 * index));
                  bool isSelected = _selectedTimes.contains(tableTime);
                  return GestureDetector(
                    onTap: () {
                      _toggleTimeSelection(tableTime);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? AppColors.buttomcolor : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          '${tableTime.hour}:${tableTime.minute}',
                          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _reserveTable(widget.restaurantId);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttomcolor,
              ),
              child: const Text('Book Table', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
            bottomNavigationBar: const BottomNav(isHomeEnabled: true) 

    );
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
        _selectedDate = picked!;
        _selectedTimes.clear();
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
            items: [2, 3, 4, 5].map((int value) {
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
      if (_selectedTimes.contains(time)) {
        _selectedTimes.remove(time);
      } else {
        _selectedTimes.add(time);
      }
    });
  }

  void _reserveTable(String restaurantId) async {
    if (_selectedTimes.isNotEmpty) {
      for (DateTime selectedTime in _selectedTimes) {
        int hour = selectedTime.hour;
        int numberOfTables = 20;
        int tableNumber = ((hour - 16) * numberOfTables / 4).floor() + 1;

        await FirebaseFirestore.instance.collection('table_boking').add({
          'restaurantId': restaurantId,
          'tableNumber': tableNumber,
          'reservationTime': selectedTime,
          'numberOfPersons': _numberOfPersons,
        });
      }
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
      setState(() {
        _selectedTimes.clear();
      });
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please select a time before booking the table.'),
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