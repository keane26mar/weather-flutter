import 'package:flutter/material.dart';
import 'package:project_2/auth_service.dart';


class LoginForm extends StatefulWidget {

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String? email;
  String? password;


  var form = GlobalKey<FormState>();
  //method to login
  login() {
    bool isValid = form.currentState!.validate();

    if (isValid) {
      form.currentState!.save();
      //access authService
      AuthService authService = AuthService();
      //function to allow users to access to the app
      return authService.login(email, password).then((value) {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login successfully!'),));
      })
      //catch errors such as
       .catchError((error) {
        FocusScope.of(context).unfocus();
        String message = error.toString().contains('] ') ? error.toString().split('] ')[1] : 'An error has occurred.';
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),));
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Form(
      key: form,
      child: isPortrait ? Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network('https://i.postimg.cc/NfPkJShp/Computer-login-rafiki.png', width: 225, height: 225,),
          Text('Welcome Back!' , style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,), textAlign: TextAlign.center),
          SizedBox(height: 10),
          Text('Log in to your existing account!' , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,), textAlign: TextAlign.center),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16)
              ),
              labelText: "Email",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
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
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16)
              ),
              labelText: "Password",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.security),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null)
                return 'Please provide a password.';
              else if (value.length < 6)
                return 'Password must be at least 6 characters.';
              else
                return null;
            },
            onSaved: (value) {
              password = value;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: () { login(); }, child: Text('Login')),
        ],
      ) : Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network('https://i.postimg.cc/NfPkJShp/Computer-login-rafiki.png', width: 100, height: 100,),
                Text('Welcome Back!' , style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,), textAlign: TextAlign.center),
                SizedBox(height: 10),
                Text('Log in to your existing account!' , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,), textAlign: TextAlign.center),
                SizedBox(height: 10),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250,
                  child:  TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)
                      ),
                      labelText: "Email",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
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
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 250,
                  child:
                  TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)
                      ),
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.security),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null)
                        return 'Please provide a password.';
                      else if (value.length < 6)
                        return 'Password must be at least 6 characters.';
                      else
                        return null;
                    },
                    onSaved: (value) {
                      password = value;
                    },
                  ),
                ),
                SizedBox(height: 5),
                ElevatedButton(onPressed: () { login(); }, child: Text('Login')),
              ],
            ),
          )
        ],
      ),
    );
  }
}

