import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class HotelInfo extends StatefulWidget {
  final String name;
  final double rating;
  final int price;

  const HotelInfo({
    Key? key,
    required this.name,
    required this.rating,
    required this.price,
  }) : super(key: key);

  @override
  State<HotelInfo> createState() => _HotelInfoState();
}

class _HotelInfoState extends State<HotelInfo> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 34),
      child: Row(
        children: [
          SizedBox(
            width: 33.w,
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Image.asset('images/moven.png'),
                const SizedBox(height: 8.0),
                Image.asset('images/mariot.png'),
                const SizedBox(height: 8.0),
                Image.asset('images/guest.png'),
              ],
            ),
          ),
          SizedBox(width: 4.5.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: GoogleFonts.oswald(),
              ),
              SizedBox(height: 3.h),
              Row(
                children: [
                  RatingBarIndicator(
                    rating: widget.rating,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Colors.yellowAccent,
                    ),
                    itemCount: 5,
                    itemSize: 1.h,
                    direction: Axis.horizontal,
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    '(${widget.rating} Rates)',
                    style: TextStyle(color: Colors.grey, fontSize: 6.sp),
                  )
                ],
              ),
            ],
          ),
          SizedBox(width: 21.w),
          Column(
            children: [
              Icon(
                Icons.favorite_border,
                size: 18.sp,
              ),
              SizedBox(height: 7.8.h),
              Text(
                "${widget.price} JOD",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

