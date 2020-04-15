import 'package:library_application_mobile/models/user.dart';
import 'package:library_application_mobile/screens/authenticate/authenticate.dart';
import 'package:library_application_mobile/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<User>(context);

    // return either the Home or Authenticate widget
    /*if (user == null) {
      //return Authenticate();
      return Home();
    } else */{
      return Home();
    }
  }
}
