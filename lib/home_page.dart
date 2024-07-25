import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/search_page.dart';
import 'package:http/http.dart' as http;



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String location = 'sydney';
  double? temperature;
  final String key = 'b7e858e8f208308427e3567a1b9f9ca6';
  var locationData;

  Future <void>getLocationData()async{
    locationData = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$location&appid=$key&units=metric'));
    final locationDataParsed = jsonDecode(locationData.body);

   

    setState(() {
       temperature= locationDataParsed['main']['temp'];
       location = locationDataParsed['name'];
    });
  }

@override
  void initState() {
    getLocationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/home.jpg'),
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
                ElevatedButton
                (onPressed: ()async{
                  print ("getlocation data çagırılmadan once: $locationData" );

                  await getLocationData();
                  debugPrint("getlocation data çagırıldıktan sonra: $locationData");

                  final locationDataParsed = jsonDecode(locationData.body);


                  print(locationDataParsed);
                  print(locationDataParsed.runtimeType);

                  print(locationDataParsed['main']['temp']);


                    }, 
                child: Text("getLocationData")),
                   Text("$temperature C°",style: TextStyle(fontSize: 70,fontWeight: FontWeight.bold),),
                     Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                    Text(
                      location,
                      style: TextStyle(fontSize: 30),
                      ),
                      IconButton(onPressed: () {
                        Navigator.push(context,MaterialPageRoute(builder: (context)=> const SearchPage()));
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
}