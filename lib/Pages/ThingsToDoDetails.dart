import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tour/Widgets/BottomNavigationBar.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkingHours {
  final String days;
  final String openTime;
  final String closeTime;

  WorkingHours(
      {required this.days, required this.openTime, required this.closeTime});
}

class ThingsToDoDetails extends StatelessWidget {
  final String name;
  final List<String> imagePaths;
  final String description;
  final String location;
  final List<WorkingHours> workingHours;
  bool isFavorite;

  ThingsToDoDetails({
    required this.name,
    required this.imagePaths,
    required this.description,
    required this.location,
    required this.workingHours,
    this.isFavorite = false,
  });

  void _openGoogleMapsApp(String locationName) async {
    final String encodedLocation = Uri.encodeComponent(locationName);
    final Uri googleMapsUri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$encodedLocation');

    if (await canLaunchUrl(googleMapsUri)) {
      await launchUrl(googleMapsUri);
    } else {
      throw 'Could not launch Google Maps for $locationName';
    }
  }

  // Function to check if the current time is within the working hours
  String _getCurrentStatus(String workingHours) {
    try {
      var format = DateFormat("h a"); // Correct format to parse the time
      List<String> times = workingHours.split('–');
      if (times.length != 2) {
        return "Invalid time format";
      }

      DateTime now = DateTime.now();
      DateTime openTime = format.parse(times[0]);
      DateTime closeTime = format.parse(times[1]);

      // Debugging
      print("Open Time: $openTime");
      print("Close Time: $closeTime");

      // Adjust the date part of openTime and closeTime to today
      openTime = DateTime(
          now.year, now.month, now.day, openTime.hour, openTime.minute);
      closeTime = DateTime(
          now.year, now.month, now.day, closeTime.hour, closeTime.minute);

      // Check if current time is within the working hours range
      if (now.isAfter(openTime) && now.isBefore(closeTime)) {
        return "Open";
      } else {
        return "Closed";
      }
    } catch (e) {
      print("Error parsing time: $e");
      return "Error in time data";
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
            const SizedBox(
              height: 10,
            ),
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
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (workingHours.isNotEmpty) ...[
                  const Text(
                    "Working Hours: ",
                    style: TextStyle(
                        color: AppColors
                            .buttomcolor, // Black color for "Working Hours"
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  ],
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: workingHours.map((wh) {
                            return Text(
                              "${wh.days}: ${wh.openTime.isNotEmpty ? wh.openTime : ''} ${wh.closeTime.isNotEmpty ? '- ' + wh.closeTime : ''}",
                              style: const TextStyle(fontSize: 14),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  const Text(
                    "About",
                    style: TextStyle(
                      color: AppColors.buttomcolor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
    bottomNavigationBar: const BottomNav(isHomeEnabled: true) 
    );
  }
}
