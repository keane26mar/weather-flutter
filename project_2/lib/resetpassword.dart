
import 'package:flutter/material.dart';
import 'package:project_2/auth_service.dart';

class ResetPasswordScreen extends StatefulWidget {
  static String routeName = '/reset-password';

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  String? email;

  var form = GlobalKey<FormState>();

  //method to reset password
  reset() {
    bool isValid = form.currentState!.validate();
    if (isValid) {
      form.currentState!.save();

      //access the authService
      AuthService authService = AuthService();

      //function to reset password
      return authService.forgotPassword(email).then((value) {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please check your email for to reset your password!'),));
        Navigator.of(context).pop();
      }).
      // catch errors such as run time errors
      catchError((error) {
        FocusScope.of(context).unfocus();
        String message = error.toString();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Auth App'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(label: Text('Email')),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null)
                    return "Please provide an email address.";
                  else if (!value.contains('@'))
                    return "Please provide a valid email address.";
                  else
                    return null;
                },
                onSaved: (value) {
                  email = value;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () { reset(); },
                  child: Text('Reset Password')),
            ],
          ),
        ),
      ),
    );
  }
}
