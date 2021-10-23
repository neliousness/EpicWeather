import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:epic_weather/services/weather-service.dart';
import 'package:epic_weather/util/constants.dart';
import 'package:epic_weather/util/weather-helper.dart';
import 'package:epic_weather/views/summary_weather/summary_weather_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Author Nelio Lucas
/// Date 10/20/2021

class SplashScreenView extends StatefulWidget {
  static String id = "splash";

  const SplashScreenView({Key? key}) : super(key: key);

  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  var currentData;
  var subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initAnimation();
    checkNetwork();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Stack(
        children: [
          Center(
              child: SvgPicture.asset(
            "assets/svgs/cloud.svg",
            width: 150,
            color: kAccentColor.withOpacity(animation.value),
          )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Developed by Nelio Lucas',
                style: TextStyle(color: kAccentColor),
              ),
            ),
          )
        ],
      ),
    );
  }

  loadWeatherData() async {
    WeatherService service = WeatherService();
    dynamic weatherData = await service.fetchMultipleLocationWeather();
    if (weatherData != null) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => SummaryWeatherView(
                    weatherData: weatherData,
                  )));
    }
  }

  void initAnimation() {
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween<double>(begin: 0.1, end: 0.9).animate(controller);
    controller.repeat(reverse: true);
    animation.addListener(() {
      setState(() {});
    });
  }

  void checkNetwork() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        bool isDeviceConnected = await WeatherHelper.hasNetwork();
        if (isDeviceConnected) {
          print('Connected $isDeviceConnected');
          loadWeatherData();
        }
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    subscription.cancel();
    super.dispose();
  }
}
