import 'package:flutter/material.dart';
import '../AppColors/colors.dart';
import '../Widgets/BottomNavigationBar.dart';
import 'HotelPage.dart';

class PlaceDesc extends StatefulWidget {
  final String imagePath;
  final String title;
  final String description;


  PlaceDesc({
    required this.imagePath,
    required this.title,
    required this.description,

  });

  @override
  _PlaceDescState createState() => _PlaceDescState();
}

class _PlaceDescState extends State<PlaceDesc> {
  late PageController _pageController;
  int _currentPage = 0;
  bool _showFullDescription = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _autoTransition();
  }

  void _autoTransition() {}

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _hotelsbutton() {
   Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => HotelPage(city: widget.title),
    ));

  }

  void _tribsbutton() {
    print('Navigate to trips page');
  }

  void _resandcafebutton() {
    print('Navigate to res page');
  }

  void _toggleDescription() {
    setState(() {
      _showFullDescription = !_showFullDescription;
    });
  }

  void _goToMap() {
    print('Navigate to the map');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  Image.asset(
                    widget.imagePath,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        
                        Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 100),
                      ],
                    ),
                    const SizedBox(
                        height: 20), //between Petra tours and hotels button
                    Text(
                      _showFullDescription
                          ? widget.description
                          : '${widget.description.substring(0, 150)}...',
                      style: const TextStyle(fontSize: 16),
                    ),

                    if (!_showFullDescription)
                      TextButton(
                        onPressed: _toggleDescription,
                        child: const Text(
                          '... Read More',
                          style: TextStyle(
                            color: AppColors.accentColor,
                          ),
                        ),
                      ),
                    const SizedBox(
                      height: 40,
                    ),
                   
                    const Text(
                      "Select one of the following options:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accentColor,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(5, 18, 20, 16),
                      child: TextButton(
                        onPressed: _hotelsbutton,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.buttomcolor),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.hotel,
                              size: 35,
                              color: Colors.white,
                            ),
                            SizedBox(width: 110),
                            Text(
                              'Hotels',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(5, 10, 20, 16),
                      child: TextButton(
                        onPressed: _tribsbutton,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.buttomcolor),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.list,
                              size: 35,
                              color: Colors.white,
                            ),
                            
                            SizedBox(width: 90),
                            Text(
                              'Things To Do',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(5, 10, 20, 16),
                      child: TextButton(
                        onPressed: _resandcafebutton,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColors.buttomcolor),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.local_cafe,
                              size: 35,
                              color: Colors.white,
                            ),
                            SizedBox(width: 70),
                            Text(
                              'Restaurant & Cafe',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}
