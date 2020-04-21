import 'package:library_application_mobile/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Wrapper(),
    );
  }
}

//void main() {
//  runApp(MaterialApp(
//    title: 'Navigation Basics',
//    home: FirstRoute(),
//  ));
//}

