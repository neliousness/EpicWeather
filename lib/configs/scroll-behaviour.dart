import 'package:flutter/material.dart';

/// Author Nelio Lucas
/// Date 10/20/2021

class NoGlowScroll extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
