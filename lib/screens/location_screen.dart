import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../services/networking.dart';

class LocationScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const LocationScreen({super.key, required this.data});

  @override
  LocationScreenState createState() => LocationScreenState();
}

class LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    getImage();
    super.initState();
  }

  Map<String, dynamic>? selectedCountry;
  bool isLoaded = false;
  ImageProvider _image = AssetImage('images/location_background.jpg');
  ImageProvider _networkImage =
      NetworkImage('https://source.unsplash.com/random/?city,nature');
  void getImage() {
    _networkImage
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((image, synchronousCall) {
      setState(() {
        isLoaded = true;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    String backgroundImageUrl =
        '${selectedCountry == null ? widget.data['weather'][0]['main'] : selectedCountry!['weather'][0]['main']}-weather';
    String fullURL = 'https://source.unsplash.com/random/?$backgroundImageUrl';

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: !isLoaded ? _image : _networkImage,
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        selectedCountry = null;
                      });
                    },
                    icon: Icon(
                      Icons.location_on,
                      size: 44.h,
                    )),
                IconButton(
                    onPressed: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode: false,
                        onSelect: (Country country) async {
                          NetworkHelper network = NetworkHelper(
                              url:
                                  'https://api.openweathermap.org/data/2.5/weather?q=${country.name}&appid=d33cd8a1b22dfe2c6c2c6584893c07a8');
                          selectedCountry = await network.getData();

                          setState(() {});
                        },
                      );
                    },
                    icon: Icon(
                      Icons.location_city,
                      size: 44.h,
                    )),
              ]),
              SizedBox(height: 64.h),
              Row(
                children: [
                  Text(
                    selectedCountry == null
                        ? ((widget.data['main']['temp'] - 272.15).round())
                            .toString()
                        : ((selectedCountry!['main']['temp'] - 272.15).round())
                            .toString(),
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
                'Grab Sunglasses',
                style: TextStyle(fontSize: 50.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24.h),
              Text(
                'it\'s super ${selectedCountry == null ? widget.data['weather'][0]['main'] : selectedCountry!['weather'][0]['main']} in ${selectedCountry == null ? widget.data['name'] : selectedCountry!['name']}',
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
  //
  // Future<void> setData(Country country) async {
  //   NetworkHelper network = NetworkHelper(
  //       url:
  //           'https://api.openweathermap.org/data/2.5/weather?q=${country.name}&appid=d33cd8a1b22dfe2c6c2c6584893c07a8');
  //   setState(() async {
  //     selectedCountry = await network.getData();
  //   });
  // }
}
