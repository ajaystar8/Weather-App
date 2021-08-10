import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Weather App",
      home: Home(),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var weather;
  var weatherDesc;
  var humidity;
  var windSpeed;

  Future fetchWeatherData() async {
    final url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=Lucerne&units=metric&appid=ccec171336f990e362299d9bc4ff44e3");
    final response = await http.get(url);

    var data = jsonDecode(response.body);
    setState(() {
      this.temp = data["main"]["temp"];
      this.weather = data["weather"][0]["main"];
      this.weatherDesc = data["weather"][0]["description"];
      this.humidity = data["main"]["humidity"];
      this.windSpeed = data["wind"]["speed"];
    });
  }

  @override
  void initState() {
    super.initState();
    this.fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.teal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Currently in Lucerne",
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  temp != null ? temp.toStringAsFixed(0) + "℃" : "Loading",
                  style: TextStyle(fontSize: 50.0, color: Colors.white),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  temp != null ? weather.toString() : "Loading",
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: ListView(
                children: [
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.thermometerHalf,
                      size: 40.0,
                    ),
                    title: Text(
                      "Temperature",
                      style: TextStyle(fontSize: 25.0),
                    ),
                    trailing: Text(
                      temp != null ? temp.toStringAsFixed(0) + "℃" : "Loading",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.sun,
                      size: 40.0,
                    ),
                    title: Text(
                      "Weather",
                      style: TextStyle(fontSize: 25.0),
                    ),
                    trailing: Text(
                      temp != null ? weatherDesc.toString() : "Loading",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.cloudRain,
                      size: 40.0,
                    ),
                    title: Text(
                      "Humidity",
                      style: TextStyle(fontSize: 25.0),
                    ),
                    trailing: Text(
                      temp != null ? humidity.toString() + " %" : "Loading",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.wind,
                      size: 40.0,
                    ),
                    title: Text(
                      "Wind Speed",
                      style: TextStyle(fontSize: 25.0),
                    ),
                    trailing: Text(
                      temp != null ? windSpeed.toString() + " kph" : "Loading",
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
