import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lab9/GetWeatherIcon.dart';
import 'LongLatTeller.dart';
import 'dart:convert';

class LocationScreen extends StatefulWidget {
  dynamic JsonData;
   LocationScreen({required this.JsonData});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double? temp;
  String? cityName;
  String? conditionIcon;
@override
void initState()
{
  super.initState();
  GetApi(widget.JsonData);
}
  void GetApi(dynamic jsonData)
  {
    temp = jsonData['main']['temp'];
  print(temp);
    int weathercode = jsonData['weather'][0]['id'];
    print(weathercode);
    WeatherModel model=WeatherModel();
    conditionIcon =model.getWeatherIcon(weathercode);
    print(conditionIcon);
    cityName = jsonData['name'].toString();
    print(cityName);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text("Temprature:"),
                Text("$temp"),
              ],
            ),
            Row(
              children: [
                Text("City Name:"),
                Text("$cityName"),
              ],
            ),
            Row(
              children: [
                Text("Weather Condition Icon:"),
                Text(conditionIcon.toString()),
              ],
            )
          ],
        ),
      ),
    );
  }
}