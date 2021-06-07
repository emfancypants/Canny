import 'package:Canny/Shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kLightBlue,
      child: Center(
        child: SpinKitFadingFour(
          color: Colors.blueGrey[700],
          size: 50.0,
        ),
      ),
    );
  }
}