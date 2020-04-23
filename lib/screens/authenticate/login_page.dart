import 'package:library_application_mobile/shared/globals.dart' as globals;
import 'package:library_application_mobile/shared/loading.dart';
import 'package:library_application_mobile/library/library.dart';
import 'package:flutter/material.dart';
import 'package:library_application_mobile/screens/home/home.dart';
import 'package:library_application_mobile/services/http_service/http_request.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _is_loading = false;

  @override
  Widget build(BuildContext context) {
    globals.httpService = HttpService();

    return _is_loading
        ? Loading()
        : MaterialApp(
            home: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: <Widget>[
                  /*-- header --*/
                  globals.headerHpl(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 6.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(labelText: 'Email'),
                        ),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(labelText: 'Password'),
                        ),
                        globals.styledRaisedButton(
                          "Log In",
                          18.0,
                          Colors.blue,
                          Colors.white,
                          () async {
                            var email = _emailController.text;
                            var password = _passwordController.text;
                            setState(() => _is_loading = true);
                            Map<String, dynamic> result =
                                await Library.getUserToken(email, password);
                            if (Library.checkUserToken(result, context)) {

                            }
                            setState(() => _is_loading = false);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
