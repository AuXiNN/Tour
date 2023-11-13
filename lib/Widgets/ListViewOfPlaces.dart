import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListViewOfPlaces extends StatelessWidget {
  final List<String> imagesPaths;
  final List<String> itemNames;

  const ListViewOfPlaces({
    super.key,
    required this.imagesPaths,
    required this.itemNames,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: imagesPaths.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Handle click event, e.g., navigate to a new screen
              print('Clicked on ${itemNames[index]}');
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      imagesPaths[index],
                      height: 100,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    itemNames[index],
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
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
    );
  }
}
