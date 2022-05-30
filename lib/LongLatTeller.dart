import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lab9/LocationScreen.dart';
import 'dart:convert';
class LonLatTeller extends StatefulWidget {
  var latitude;
  var status;
  var longitude;
  LonLatTeller(this.latitude, this.longitude, this.status);
  @override
  State<LonLatTeller> createState() => _LonLatTellerState();
}

class _LonLatTellerState extends State<LonLatTeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text("WEATHER TELLER"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text("Latitude:          ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              Text(widget.latitude.toString()),
            ],
          ),
          Row(
            children: [
              Text("Longitude:       ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              Text(widget.longitude.toString()),
            ],
          ),
          Row(
            children: [
              Text("Status:             ",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              Text(widget.status.toString()),
            ],
          ),
          TextButton(
              onPressed: () async {
                var lat = widget.latitude;
                var lon = widget.longitude;
               // networkhelper network=networkhelper());
                dynamic jsonData = await GetData(Uri.parse(
                    "http://api.openweathermap.org/data/2.5/weather?units=metric&lat=$lat&lon=$lon&appid=931e8bdeccb205992200128a5f3a3e95"));
                // print(jsonData);
                var cityName = jsonData['name'].toString();
                //print(cityName);
                 Navigator.push(context, MaterialPageRoute(builder: ((context) => LocationScreen(JsonData: jsonData)),),);
              },
              child: Text("Get Weather"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white70),
              ))
        ],
      ),
    );
  }

  Future GetData(Uri uri) async {
    Response response = await get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }
}
