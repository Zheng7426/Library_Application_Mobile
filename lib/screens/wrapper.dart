import 'package:library_application_mobile/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:library_application_mobile/screens/authenticate/login_page.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<User>(context);
    final user = true;
    // return either the Home or Authenticate widget
    if (user == true) {
      return LoginPage();
    } else {
      return LoginPage();
    }
  }
}
