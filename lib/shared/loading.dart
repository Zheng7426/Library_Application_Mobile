import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:library_application_mobile/shared/globals.dart' as globals;

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(globals.color6),
      child: Center(
        child: SpinKitWanderingCubes(
          color: Colors.blue,
          size: 80.0,
        ),
      ),
    );
  }
}