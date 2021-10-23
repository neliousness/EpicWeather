import 'package:epic_weather/util/constants.dart';
import 'package:epic_weather/util/weather-helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Author Nelio Lucas
/// Date 10/23/2021

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
  late String _asset;
  late String _time;
  late String _temp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _asset = widget.asset;
    _time = widget.time;
    _temp = widget.temp;
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
              "${WeatherHelper.formatTime(_time)}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kTextAccentColor,
                  fontSize: 12),
            ),
            SvgPicture.asset(
              "assets/svgs/$_asset.svg",
              width: 25,
              color: kTextAccentColor,
            ),
            Text(
              "$_temp",
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
