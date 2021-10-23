import 'package:epic_weather/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Author Nelio Lucas
/// Date 10/23/2021

class ConditionBox extends StatefulWidget {
  final String asset;
  final String value;
  final String description;

  const ConditionBox(
      {Key? key,
      required this.value,
      required this.asset,
      required this.description})
      : super(key: key);

  @override
  _ConditionBoxState createState() => _ConditionBoxState();
}

class _ConditionBoxState extends State<ConditionBox> {
  late String asset;
  late String value;
  late String description;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    asset = widget.asset;
    value = widget.value;
    description = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 90,
        height: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/svgs/$asset.svg",
              width: 25,
              color: kAccentColor,
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text(
                "$value",
                style: TextStyle(color: Color(0xffADCDFE), fontSize: 16),
              ),
            ),
            Text(
              "$description",
              style: TextStyle(
                  color: Color(0xffADCDFE).withOpacity(0.6), fontSize: 12),
            )
          ],
        ),
        decoration: BoxDecoration(
            color: kPrimaryColor,
            border: Border.all(
              color: kAccentColor,
            ),
            shape: BoxShape.circle),
      ),
    );
  }
}
