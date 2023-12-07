import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tour/AppColors/colors.dart';

import '../Widgets/BottomNavigationBar.dart';
import '../Widgets/hotelinfo.dart';

class HotelPage extends StatelessWidget {
  final String city;

  const HotelPage({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<HotelInfo> hotelsForCity = getHotelsForCity(city);

    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.buttomcolor,
            centerTitle: true,
            title: const Text(
              "Hotels",
              style: TextStyle(color: Colors.white),
            ),
            iconTheme:IconThemeData(color: Colors.white), // Set back button color
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          backgroundColor: const Color(0xfffff0f3),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 6.h),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      color: Colors.white,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search For A Hotel',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {},
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.5.h),
                  Padding(
                    padding: const EdgeInsets.only(left: 24),
                  ),
                  Column(
                    children: hotelsForCity.map((hotel) {
                      return HotelInfo(
                        name: hotel.name,
                        location: hotel.location,
                        rating: hotel.rating,
                        price: hotel.price,
                        image: hotel.image,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
                bottomNavigationBar: const BottomNav(),
        ),
      );
    });
  }
}

List<HotelInfo> getHotelsForCity(String city) {
  // Sample data (replace it with your actual data)
  Map<String, List<HotelInfo>> cityHotels = {
    'Amman': [
      const HotelInfo(
        name: "Petra Movenpick Hotel",
        location: "Amman, Jordan",
        rating: 4.00,
        price: 200,
        image: "images/moven.png",
      ),
      const HotelInfo(
        name: "Petra Guest House",
        location: "Amman, Jordan",
        rating: 4.00,
        price: 200,
        image: "images/guest.png",
      ),
      const HotelInfo(
        name: "Petra Marriott Hotel",
        location: "Amman, Jordan",
        rating: 4.00,
        price: 200,
        image: "images/mariot.png",
      ),
      const HotelInfo(
        name: "Petra Movenpick Hotel",
        location: "Amman, Jordan",
        rating: 4.00,
        price: 200,
        image: "images/moven.png",
      ),
      const HotelInfo(
        name: "Petra Guest House",
        location: "Amman, Jordan",
        rating: 4.00,
        price: 200,
        image: "images/guest.png",
      ),
      const HotelInfo(
        name: "Petra Marriott Hotel",
        location: "Amman, Jordan",
        rating: 4.00,
        price: 200,
        image: "images/mariot.png",
      ),
    ],
    'Aqaba': [
      const HotelInfo(
        name: "Ayla Hotel",
        location: "Aqaba, Jordan",
        rating: 4.00,
        price: 200,
        image: "images/moven.png",
      ),
      const HotelInfo(
        name: "Nigga House",
        location: "Aqaba, Jordan",
        rating: 4.00,
        price: 200,
        image: "images/guest.png",
      ),
      const HotelInfo(
        name: "Bitch Hotel",
        location: "Aqaba, Jordan",
        rating: 4.00,
        price: 200,
        image: "images/mariot.png",
      ),
    ],
    // Add entries for other cities
  };

  return cityHotels[city] ?? [];
}
