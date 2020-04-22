import 'package:library_application_mobile/screens/authenticate/verifier.dart';
import 'package:library_application_mobile/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:library_application_mobile/screens/authenticate/verifier.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Wrapper(),
      //home: VerifyForm(),
    );
  }
}

//void main() {
//  runApp(MaterialApp(
//    title: 'Navigation Basics',
//    home: FirstRoute(),
//  ));
//}

