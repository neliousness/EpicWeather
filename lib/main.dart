import 'package:epic_weather/screens/splash.dart';
import 'package:epic_weather/screens/weather.dart';
import 'package:epic_weather/util/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: kAppTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Splash.id,
      routes: {Splash.id : (context) => Splash(),
        Weather.id : (context) => Weather()},
    );
  }
}


