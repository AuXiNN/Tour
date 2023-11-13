import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tour/Widgets/ListViewOfPlaces.dart';

import '../Widgets/ListViewOfPlaces.dart'; // Import the ClickableImagesList class

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                      offset: Offset(0.0, 0.0),
                      blurRadius: 15.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: const Image(
                    image: AssetImage('images/deadsea.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 90,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Explore Jordan's rich history",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Captivating culture, and breathtaking",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 98, 77, 45),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Text(
                      "landscapes with our immersive",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 98, 77, 45),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Text(
                      " and personalized tour app",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color.fromARGB(255, 98, 77, 45),
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
         const Expanded(
            child: ListViewOfPlaces(
              imagesPaths: [
                'images/jordan.jpg',
                'images/jordan.jpg',
                'images/jordan.jpg',
                // Add more image URLs as needed
              ],
              itemNames: [
                'Item 1',
                'Item 2',
                'Item 3',
                // Add more item names as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
