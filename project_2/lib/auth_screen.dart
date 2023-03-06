import 'package:flutter/material.dart';
import 'package:project_2/auth_service.dart';
import 'package:project_2/login_form.dart';
import 'package:project_2/register_form.dart';
import 'package:project_2/resetpassword.dart';


class AuthScreen extends StatefulWidget {
  static String routeName = '/auth';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  //access the authService
  AuthService authService = AuthService();

  bool loginScreen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Facility app'),
      ),
      body: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: [
              loginScreen ? LoginForm() : RegisterForm(),
              loginScreen ? TextButton(onPressed: () {
                setState(() {
                  loginScreen = false;
                });
              }, child: Text('No account? Sign up here!')) :
              TextButton(onPressed: () {
                setState(() {
                  loginScreen = true;
                });
              }, child: Text('Exisiting user? Login in here!')),
              loginScreen ? TextButton(onPressed: () {
                Navigator.of(context).pushNamed(ResetPasswordScreen.routeName);
              }, child: Text('Forgotten Password')) : Center()
            ],
          )
      ),
    );
  }
}
