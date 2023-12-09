
import 'package:flutter/material.dart';

class HotelRoomsPage extends StatelessWidget {
  final String hotelName;

  const HotelRoomsPage({Key? key, required this.hotelName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rooms at $hotelName'),
      ),
      body: Center(
        child: Text(
          'List of rooms for $hotelName will be displayed here.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
