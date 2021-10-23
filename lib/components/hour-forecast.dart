import 'package:epic_weather/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HourForecast extends StatefulWidget {
  final String asset;
  final String hour;
  final String temp;
  const HourForecast(
      {Key? key, required this.asset, required this.hour, required this.temp})
      : super(key: key);

  @override
  _HourForecastState createState() => _HourForecastState();
}

class _HourForecastState extends State<HourForecast> {
  late String asset;
  late String hour;
  late String temp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    asset = widget.asset;
    hour = widget.hour;
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
              "${formatHours(hour)}",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: kTextAccentColor),
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

  String formatHours(String time) {
    var timeArray = time.split(" ");
    var innerTimeArray = timeArray[1].split(":");
    return '${int.parse(innerTimeArray[0])}';
  }
}
