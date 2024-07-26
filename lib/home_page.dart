import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/search_page.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String location = 'Sydney';
  double? temperature;
  final String key = 'b7e858e8f208308427e3567a1b9f9ca6';
  var locationData;
  String code = 'h                                                                                                                                                                                               ome';
  Position? devicePosition;
  Future <void>getLocationData()async{
    locationData = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$key&units=metric'));
    final locationDataParsed = jsonDecode(locationData.body);

   

    setState(() {
       temperature= locationDataParsed['main']['temp'];
       location = locationDataParsed['name'];
       code = locationDataParsed['weather'].first['main'];
    });
  }
 
   Future <void> getDevicePosition()async{
   devicePosition = await _determinePosition();
   print(devicePosition);


   }



@override
  void initState() {
    getDevicePosition();
    getLocationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration:  BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/$code.jpg'),
          fit: BoxFit.cover,
             ),
               ),
        
        child: (temperature==null)
        ? Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child : Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              Text('please wait, retrieving weather data'),
          ],
          ),
        ),
        )
        :Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
           
                   
                   Text("$temperature aC°",style: TextStyle(fontSize: 70,fontWeight: FontWeight.bold),),
                     Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                    Text(
                      location,
                      style: TextStyle(fontSize: 30),
                      ),
                      IconButton(onPressed: () async{
                        final selectedCity = await Navigator.push(context,MaterialPageRoute(builder: (context)=> const SearchPage()));
                        print(selectedCity);
                        location = selectedCity;
                        getLocationData();
                      }, 
                      icon: const Icon(Icons.search))
                  ],
                ),
            ],
                    ),
          )
       )
      );
  }

  

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
}