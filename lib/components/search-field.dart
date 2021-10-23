import 'package:epic_weather/util/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final Function(String value) onChanged;
  SearchField({Key? key, required this.onChanged}) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late Function(String value) onChanged;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onChanged = widget.onChanged;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 18.0, right: 18, top: 12.0, bottom: 12.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: kAccentColor, width: 1),
            borderRadius: BorderRadius.circular(32)),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: TextField(
            style: TextStyle(color: klightTextColor),
            onChanged: onChanged,
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(
                Icons.search,
                color: Color(0xff727C8D),
              ),
              fillColor: kPrimaryColor,
              hintStyle: TextStyle(color: Color(0xff727C8D)),
              hintText: 'Search cities',
            ),
          ),
        ),
      ),
    );
  }
}
