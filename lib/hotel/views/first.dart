import 'package:flutter/material.dart';
import 'package:tour/hotel/components/hotelCard.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xfffff0f3),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                
                                Image.asset(
                                  'images/hotel.png',
                                  height: 6.h,
                                ),
                                SizedBox(
                                  width: 1.9.w,
                                ),
                                Text(
                                  "Hotels",
                                  style: GoogleFonts.oswald(
                                      textStyle: TextStyle(fontSize: 17.sp)),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 55.w,
                            ),
                            Icon(
                              Icons.account_circle_outlined,
                              size: 25.sp,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      color: Colors.white,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search For An Hotel',
                          // Add a clear button to the search bar
                          suffixIcon: IconButton(
                              icon: Icon(Icons.search), onPressed: () {}),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.5.h,
                  ),
                  Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Row(
                  children: [
                    Text(
                      'Sort By',
                      style: TextStyle(fontSize: 11.sp),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Text(
                      'Newest',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 11.sp),
                    ),
                    Icon(Icons.arrow_drop_down_outlined),
                    SizedBox(
                      width: 52.w,
                    ),
                    Container(
                        color: Colors.brown,
                        child: Icon(Icons.filter_alt_outlined)),
                  ],
                ),
              ),
              SizedBox(height: 2.5.h),
                  HotelInfo(name: "Movenpick Hotel", rating: 4.00, price: 200),
                  HotelInfo(name: "mariot Hotel", rating: 4.00, price: 200),
                  HotelInfo(name: "guest Hotel", rating: 4.00, price: 200),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
