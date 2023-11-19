import 'package:flutter/material.dart';
import 'package:tour/hotel/components/bottomBar.dart';

class HotelSystem extends StatelessWidget {
  const HotelSystem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CusBottomNavigationBar(),
    );
  }
}
