import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tour/AppColors/colors.dart';

class ListViewOfCities extends StatelessWidget {
  final List<String> imagesPaths;
  final List<String> itemNames;

  const ListViewOfCities({
    required this.imagesPaths,
    required this.itemNames,
  });

  void handleImageClick(BuildContext context, int index) {
    print('Image clicked: ${itemNames[index]}');

    if (itemNames[index] == 'Amman') {
      Navigator.pushReplacementNamed(context, "amman");
    } 

    else if (itemNames[index] == 'Aqaba') {
      Navigator.pushReplacementNamed(context, "aqaba");
    } 

    else if (itemNames[index] == 'Petra') {
      Navigator.pushReplacementNamed(context, "petra");
    }

    else if (itemNames[index] == 'Dead Sea') {
      Navigator.pushReplacementNamed(context, "deadsea");
    }


    else if (itemNames[index] == 'Wadi Rum') {
      Navigator.pushReplacementNamed(context, "wadirum");
    }
  
    else if (itemNames[index] == 'Jerash') {
      Navigator.pushReplacementNamed(context, "jerash");
    }
        else if (itemNames[index] == 'Ajloun') {
      Navigator.pushReplacementNamed(context, "ajloun");
    }


  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Fixed height for each item
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Scroll horizontally
        itemCount: imagesPaths.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              handleImageClick(context, index);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0), // Add padding between items
              child: Column(
                children: [
                  Container(
                    width: 150, // Fixed width for the image
                    height: 150, // Fixed height for the image
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      image: DecorationImage(
                        image: AssetImage(imagesPaths[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 8), // Add space between image and text
                  Text(
                    itemNames[index],
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: AppColors.buttomcolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
