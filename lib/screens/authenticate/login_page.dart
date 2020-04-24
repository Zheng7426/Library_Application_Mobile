import 'package:library_application_mobile/shared/globals.dart' as globals;
import 'package:library_application_mobile/shared/loading.dart';
import 'package:library_application_mobile/library/library.dart';
import 'package:flutter/material.dart';
import 'package:library_application_mobile/screens/home/home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Loading()
        : MaterialApp(
            home: Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                children: <Widget>[
                  /*-- header --*/
                  globals.headerHpl(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50.0, 8.0, 50.0, 6.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 100),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(labelText: 'Email'),
                        ),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(labelText: 'Password'),
                        ),
                        SizedBox(height: 20),
                        globals.styledRaisedButton(
                          "Log In",
                          18.0,
                          Colors.blue,
                          Colors.white,
                          () async {
                            var email = _emailController.text;
                            var password = _passwordController.text;
                            setState(() => _isLoading = true);
                            // get user token
                            Map<String, dynamic> result =
                                await Library.getUserToken(email, password);
                            if (Library.checkUserToken(result, context)) {
                              // save user credentials to persistent storage
                              Library.setUserCredential(email, password);
                              Library.saveUserCredential();
                              // get user info with email
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(needToken: false),
                                ),
                              );
                            } else {
                              setState(() => _isLoading = false);
                            }
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
