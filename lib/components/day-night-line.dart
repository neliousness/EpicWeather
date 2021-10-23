import 'package:epic_weather/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DayNightLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: SvgPicture.asset(
        "assets/svgs/curve.svg",
        width: MediaQuery.of(context).size.width,
        color: kAccentColor,
      ),
    );
  }
}
