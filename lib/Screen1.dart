import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'LongLatTeller.dart';
class Weather extends StatefulWidget {
  const Weather({ Key? key }) : super(key: key);

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  @override
  double? latitude;
  double? longitude;
  var status;
  void initState()
  {
    super.initState();
    getcurrentposition();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text("WEATHER TELLER"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      getcurrentposition();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              LonLatTeller(latitude, longitude,status),
                        ),
                      );
                    });
                  },
                  icon: Icon(
                    Icons.cloud_sync_rounded,
                    size: 70,
                    color: Colors.blue[400],
                  )),
            ),
            Text(
              "Get Latitude And Longitude",
              style: TextStyle(color: Colors.green[500]),
            ),
          ],
        ),
      ),
    );
  }

  void getcurrentposition() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) 
    {
        permission=await Geolocator.requestPermission();
        print(permission);
    }
      if(permission==LocationPermission.deniedForever)
      {
        status="Permission denied";
      } 
      else
    {
      status="Permission Granted";
    Position p = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    latitude = p.latitude;
    longitude = p.longitude;
    print(p.latitude);
    print(p.longitude);
    }
    
  }
  }
