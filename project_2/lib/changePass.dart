import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_2/auth_service.dart';

class ChangePass extends StatefulWidget {

  static String routeName = '/Changepassword';



  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {

  final _formkey = GlobalKey<FormState>();

  var newPassword = "";

  final newPasswordController = TextEditingController();

  final repeatPasswordController = TextEditingController();

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    newPasswordController.dispose();
  }

  //access the authService
  AuthService authService = AuthService();

  // change password method
  changePassword() async {
        try {
          // function to change password
          await currentUser!.updatePassword(newPassword);

          // function to logout after change password
          return authService.logOut().then((value) {
            FocusScope.of(context).unfocus();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Password updated successfully login again'),));
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed('/');
          });
        }
        // catch errors such as run time errors
        catch (error) {
          FocusScope.of(context).unfocus();
          String message = error.toString();
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message),));
        }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Image.network('https://i.postimg.cc/vTkJvdk1/Reset-password-rafiki.png', width: 250, height: 250,),
              TextFormField(
                controller: newPasswordController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)
                  ),
                  labelText: "New password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.security),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Please provide a password.';
                  else if (value.length < 6)
                    return 'Password must be at least 6 characters.';
                  else
                    return null;
                },
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                  style:  ElevatedButton.styleFrom(
                    minimumSize: Size(400, 50),
                  ),
                  child: Text('Save changes', style: TextStyle(fontWeight:
                  FontWeight.bold)),
                  onPressed: () {
                    if(_formkey.currentState!.validate()) {

                      setState(() {
                        newPassword = newPasswordController.text;
                      });
                    }
                    changePassword();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
