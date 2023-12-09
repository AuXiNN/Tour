// ThingsToDoPage.dart

import 'package:flutter/material.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:tour/Pages/ThingsToDoDetails.dart';

class ThingsToDoPage extends StatelessWidget {
  final String city;
  ThingsToDoPage({required this.city});

  static List<ThingsToDoDetails> _generateThingsToDoList(String city) {
    switch (city) {
      case 'Amman':
        return [
          ThingsToDoDetails(
            imagePath: 'images/' + city + '1.png',
            description: 'The Royal Automobile Museum',
          ),
          ThingsToDoDetails(
            imagePath: 'images/' + city + '2.png',
            description: 'AlHussein Public Parks',
          ),
          ThingsToDoDetails(
            imagePath: 'images/' + city + '3.png',
            description: 'Abdali Boulevard',
          ),
          ThingsToDoDetails(
            imagePath: 'images/' + city + '4.png',
            description: 'Amman Citadel',
          ),
          ThingsToDoDetails(
            imagePath: 'images/' + city + '5.png',
            description: 'The Jordan Museum',
          ),
          ThingsToDoDetails(
            imagePath: 'images/' + city + '6.png',
            description: 'Roman Theatre',
          ),
        ];
      case 'Aqaba':
        return [
          ThingsToDoDetails(
            imagePath: 'images/$city+1.png',
            description: 'Enjoy water activities in $city',
          ),
          ThingsToDoDetails(
            imagePath: 'images/$city+2.png',
            description: 'Relax on beautiful beaches in $city',
          ),
        ];

      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    List<ThingsToDoDetails> thingsToDoList = _generateThingsToDoList(city);

    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        backgroundColor: AppColors.buttomcolor,
        centerTitle: true,
        title: Text(
          'Things To Do In $city',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white), // Set back button color
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Here Are Places In $city That You Can Enjoy:',
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: List.generate(thingsToDoList.length, (index) {
                  ThingsToDoDetails thingToDo = thingsToDoList[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigate to a new page when image is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ThingsToDoDetails(
                            imagePath: thingToDo.imagePath,
                            description: thingToDo.description,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          thingToDo.imagePath,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          thingToDo.description,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
