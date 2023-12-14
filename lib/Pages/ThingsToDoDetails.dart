import 'package:flutter/material.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tour/Widgets/BottomNavigationBar.dart';
import 'package:url_launcher/url_launcher.dart';

class ThingsToDoDetails extends StatelessWidget {
  final String name;
  final List<String> imagePaths;
  final String description;
  final String location;


  const ThingsToDoDetails({
    required this.name,
    required this.imagePaths,
    required this.description,
    required this.location,

  });

  void _openGoogleMapsApp(String locationName) async {
    // Encode the location name to be included in a URL
    final String encodedLocation = Uri.encodeComponent(locationName);

    // Create the URI for opening in Google Maps
    final Uri googleMapsUri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$encodedLocation');

    // Attempt to launch the URL
    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri);
    } else {
      throw 'Could not launch Google Maps for $locationName';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        backgroundColor: AppColors.buttomcolor,
        centerTitle: true,
        title: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white), // Set back button color
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: imagePaths
                  .map(
                    (imagePath) => Image.asset(
                      imagePath,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 2.0,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () => _openGoogleMapsApp(name),
                child: Text('Open in Google Maps'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttomcolor,
                  foregroundColor: AppColors.backgroundcolor,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
