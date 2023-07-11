import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const LocationScreen({super.key, required this.data});

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String backgroundImageUrl = '${widget.data['weather'][0]['main']}-weather';
    String fullURL = 'https://source.unsplash.com/random/?$backgroundImageUrl';

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(fullURL),
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(.5),
              BlendMode.lighten,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 64.h),
              Icon(Icons.sunny, size: 128.w),
              SizedBox(height: 64.h),
              Row(
                children: [
                  Text(
                    ((widget.data['main']['temp'] - 272.15).round()).toString(),
                    style: TextStyle(
                        fontSize: 128.sp, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '°',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 64.sp),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          'now',
                          style: TextStyle(
                              letterSpacing: 12.w,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Text(
                'Grab sunglasses',
                style: TextStyle(fontSize: 50.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24.h),
              Text(
                'it\'s super ${widget.data['weather'][0]['main']} in ${widget.data['name']}',
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.r),
                  color: const Color(0xff7CCCC9),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '07h 12min',
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.sunny,
                          size: 32.w,
                          color: Colors.white,
                        ),
                        SizedBox(width: 24.w),
                        Text('before sunrise',
                            style: TextStyle(
                                fontSize: 20.sp, color: Colors.white)),
                      ],
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
