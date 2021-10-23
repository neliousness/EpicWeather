import 'package:epic_weather/util/constants.dart';
import 'package:epic_weather/views/detailed_weather/detailed_weather_view.dart';
import 'package:epic_weather/views/splash_screen/splash_screen_view.dart';
import 'package:epic_weather/views/summary_weather/summary_weather_view.dart';
import 'package:flutter/material.dart';

/// Author Nelio Lucas
/// Date 10/20/2021

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
      initialRoute: SplashScreenView.id,
      routes: {
        SplashScreenView.id: (context) => SplashScreenView(),
        SummaryWeatherView.id: (context) => SummaryWeatherView(),
        DetailedWeatherView.id: (context) => DetailedWeatherView()
      },
    );
  }
}
