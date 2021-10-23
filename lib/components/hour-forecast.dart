import 'package:epic_weather/util/constants.dart';
import 'package:epic_weather/util/weather-helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HourForecast extends StatefulWidget {
  final String asset;
  final String time;
  final String temp;
  const HourForecast(
      {Key? key, required this.asset, required this.time, required this.temp})
      : super(key: key);

  @override
  _HourForecastState createState() => _HourForecastState();
}

class _HourForecastState extends State<HourForecast> {
  late String asset;
  late String time;
  late String temp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    asset = widget.asset;
    time = widget.time;
    temp = widget.temp;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 55,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "${WeatherHelper.formatTime(time)}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kTextAccentColor,
                  fontSize: 12),
            ),
            SvgPicture.asset(
              "assets/svgs/$asset.svg",
              width: 25,
              color: kTextAccentColor,
            ),
            Text(
              "$temp",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: kTextAccentColor),
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: kPrimaryColor,
            border: Border.all(color: kAccentColor),
            borderRadius: BorderRadius.circular(25)),
      ),
    );
  }
}
