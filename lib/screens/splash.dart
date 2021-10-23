import 'package:epic_weather/screens/weather.dart';
import 'package:epic_weather/service/weather-service.dart';
import 'package:epic_weather/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Splash extends StatefulWidget {
  static String id = "splash";

  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  var currentData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initAnimation();
    loadWeatherData();
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
              builder: (context) => Weather(
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

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}
