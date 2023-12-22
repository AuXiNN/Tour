import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tour/AppColors/colors.dart';

class ListViewOfCities extends StatelessWidget {
  final List<String> imagesPaths;
  final List<String> itemNames;

  const ListViewOfCities({
    Key? key,
    required this.imagesPaths,
    required this.itemNames,
  }) : super(key: key);

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
    return Column(
      children: List.generate(itemNames.length, (index) {
        return GestureDetector(
          onTap: () => handleImageClick(context, index),
          child: Card(
            child: Column(
              children: [
                Image.asset(
                  imagesPaths[index],
                  fit: BoxFit.cover,
                  height: 200, // Adjust the height as needed
                  width: double.infinity,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    itemNames[index],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttomcolor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
