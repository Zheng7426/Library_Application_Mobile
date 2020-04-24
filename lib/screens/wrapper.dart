import 'package:flutter/material.dart';
import 'package:library_application_mobile/shared/globals.dart' as globals;
import 'package:library_application_mobile/shared/loading.dart';
import 'package:library_application_mobile/library/library.dart';
import 'package:library_application_mobile/screens/home/home.dart';
import 'package:library_application_mobile/services/http_service/http_request.dart';
import 'package:library_application_mobile/screens/authenticate/login_page.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    globals.httpService = HttpService();

    return FutureBuilder<bool>(
      future: Library.loadUserCredential(),
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          if (globals.userCredential != null &&
              globals.userCredential["email"] != null &&
              globals.userCredential["password"] != null) {
            return Home(needToken: true);
          } else {
            return LoginPage();
          }
        } else {
          return Loading();
        }
      },
    );
  }
}
