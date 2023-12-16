import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:tour/Widgets/BottomNavigationBar.dart';

import '../Widgets/ListViewOfPlaces.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 100.0,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: const Image(
                        image: AssetImage('images/TouristsHavingFun.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Explore Jordan's rich history",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: AppColors.buttomcolor,
                              fontWeight: FontWeight.bold,
                              fontSize: 23,
                            ),
                          ),
                        ),
                        const SizedBox(height: 90),
                        Text(
                          "Captivating culture, and breathtaking",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Text(
                          "landscapes with our immersive",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Text(
                          " and personalized tour app",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 90),
              Text(
                'Select The Place You Wish To Explore:',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: AppColors.buttomcolor,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: 400,
                child: const ListViewOfCities(
                  imagesPaths: [
                    'images/jordan.jpg',
                    'images/Aqaba.png',
                    'images/Jerash.jpg',
                    'images/AjlounCastle.jpg',
                    'images/petra.webp',
                    'images/deadsea.jpg',
                    'images/wadirum.jpg',
                  ],
                  itemNames: [
                    'Amman',
                    'Aqaba',
                    'Jerash',
                    'Ajloun',
                    'Petra',
                    'Dead Sea',
                    'Wadi Rum',


                    // Add more item names as needed
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}



    // return Scaffold(
    //   backgroundColor: AppColors.backgroundcolor,
    //   body: Column(
    //     children: [
    //       Stack(
    //         children: [
    //           Container(
    //             height: 300,
    //             decoration: BoxDecoration(
    //               borderRadius: BorderRadius.circular(30.0),
    //               boxShadow: const [
    //                 BoxShadow(
    //                   color: Colors.black,
    //                   blurRadius: 100.0,
    //                 ),
    //               ],
    //             ),
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.circular(30.0),
    //               child: const Image(
    //                 image: AssetImage('images/TouristsHavingFun.jpg'),
    //                 fit: BoxFit.cover,
    //               ),
    //             ),
    //           ),
    //           Positioned(
    //             top: 80,
    //             left: 20,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   "Explore Jordan's rich history",
    //                   style: GoogleFonts.poppins(
    //                     textStyle: const TextStyle(
    //                       color: AppColors.buttomcolor,
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: 23,
    //                     ),
    //                   ),
    //                 ),
    //                 const SizedBox(height:90),
    //                 Text(
    //                   "Captivating culture, and breathtaking",
    //                   style: GoogleFonts.poppins(
    //                     textStyle: const TextStyle(
    //                       color: Color.fromARGB(255, 255, 255, 255),
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: 15,
    //                     ),
    //                   ),
    //                 ),
    //                 Text(
    //                   "landscapes with our immersive",
    //                   style: GoogleFonts.poppins(
    //                     textStyle: const TextStyle(
    //                       color: Color.fromARGB(255, 255, 255, 255),
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: 15,
    //                     ),
    //                   ),
    //                 ),
    //                 Text(
    //                   " and personalized tour app",
    //                   style: GoogleFonts.poppins(
    //                     textStyle: const TextStyle(
    //                       color: Color.fromARGB(255, 255, 255, 255),
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: 15,
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Positioned(
    //             top: 20,
    //             right: 20,
    //             child: IconButton(
    //               icon: Icon(Icons.logout),
    //               onPressed: () {
    //                 // Implement logout functionality here
    //                 // For example, you can navigate to the login screen
    //                 Navigator.of(context).pushReplacementNamed("login");
    //               },
    //             ),
    //           ),
    //         ],
    //       ),
    //       const SizedBox(height: 90),
    //       Text(
    //         'Selecting The Place You Wish To Explore:',
    //         style: GoogleFonts.poppins(
    //           textStyle: const TextStyle(
    //             fontWeight: FontWeight.bold,
    //             fontSize: 18,
    //             color: AppColors.buttomcolor,
    //           ),
    //         ),
            
    //       ),
    //       const Expanded(
    //         child: SizedBox(
    //           child: ListViewOfPlaces(
    //             imagesPaths: [
    //               'images/petra.webp',
    //               'images/wadirum.jpg',
    //               'images/deadsea.jpg',
    //               'images/RomanTheatre.jpg',
    //               'images/Jerash.jpg',
    //               'images/AjlounCastle.jpg',

    //             ],
    //             itemNames: [
    //               'Petra',
    //               'Wadi Rum',
    //               'Dead Sea',
    //               'Roman Theatre',
    //               'Jerash',
    //               'Ajloun Castle',
    //               // Add more item names as needed
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );