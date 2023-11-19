import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:tour/Widgets/ListViewOfPlaces.dart';

class ArchaeologicalSitesList extends StatelessWidget {
  final List<String> imagesPaths;
  final List<String> siteNames;

  const ArchaeologicalSitesList({
    required this.imagesPaths,
    required this.siteNames,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          'Archaeological Sites: ',
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.buttomcolor,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 150, // Adjust the height according to your preference
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imagesPaths.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Handle the tap event for each site image
                  print('Tapped on: ${siteNames[index]}');
                  // Implement navigation or other actions as needed
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Container(
                        width: 120, // Adjust the image width as needed
                        height: 120, // Adjust the image height as needed
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage(imagesPaths[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        siteNames[index],
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 30,)
      ],
    );
  }
}
