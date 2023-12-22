// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:tour/AppColors/colors.dart';
import 'package:tour/Pages/ThingsToDoDetails.dart';
import 'package:tour/Widgets/BottomNavigationBar.dart';
import 'package:tour/Widgets/ThingsToDoDataProvider.dart';

class ThingsToDoPage extends StatefulWidget {
  final String city;

  ThingsToDoPage({required this.city});

  @override
  _ThingsToDoPageState createState() => _ThingsToDoPageState();
}

class _ThingsToDoPageState extends State<ThingsToDoPage> {
  late List<ThingsToDoDetails> thingsToDoList;
  late List<ThingsToDoDetails> filteredList;

  @override
  void initState() {
    super.initState();
    thingsToDoList = ThingsToDoDataProvider.generateThingsToDoList(widget.city);
    filteredList = List.from(thingsToDoList);
  }

  

  void _search(String query) {
    setState(() {
      filteredList = thingsToDoList
          .where((thingToDo) =>
              thingToDo.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        backgroundColor: AppColors.buttomcolor,
        centerTitle: true,
        title: Text(
          'Things To Do In ${widget.city}',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Here Are Places In ${widget.city} That You Can Enjoy Visiting:',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: _search,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        suffixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: filteredList.map((thingToDo) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to a new page when image is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ThingsToDoDetails(
                            name: thingToDo.name,
                            imagePaths: thingToDo.imagePaths,
                            description: thingToDo.description,
                            location: thingToDo.location,
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          thingToDo.imagePaths.first,
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          thingToDo.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: AppColors.buttomcolor),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            const SizedBox(width: 8),
                            const Icon(Icons.location_on,
                                        color: Color(0xFF3A1B0F)),
                                    const SizedBox(width: 6),
                            Text(
                              '${thingToDo.location}', // Display the actual location
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                                
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 42), // Adjusted spacing
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
