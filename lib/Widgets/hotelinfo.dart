import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:tour/Pages/HotelRoomsPage.dart';

class HotelInfo extends StatelessWidget {
  final String name;
  final String location;
  final double rating;
  final String image;

  const HotelInfo({
    Key? key,
    required this.name,
    required this.location,
    required this.rating,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HotelRoomsPage(hotelName: name),
        ),
      );
        print('Hotel $name clicked!');
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              image,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    location,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      RatingBar.builder(
                        itemSize: 20,
                        initialRating: rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          // Handle rating update
                        },
                      ),
                      Text('$rating'),
                    ],
                  ),
                  SizedBox(height: 8),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
