import 'package:flutter/material.dart';
import 'package:project_2/auth_service.dart';
import 'package:project_2/firestore_service.dart';

class RegisterForm extends StatefulWidget {

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String? email;
  String? password;
  String? confirmPassword;
  String? firstname;
  String? phone;
  String? profileImage;

  var form = GlobalKey<FormState>();

  //method to register account
  register() {
    bool isValid = form.currentState!.validate();

    if (isValid) {
      form.currentState!.save();

      //if form is valid, will check password and confirm passsword field does match or not
      if (password != confirmPassword) {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password and Confirm Password does not match!'),));
      }
      // access the authService
      AuthService authService = AuthService();
      //access the fireStore Service
      FirestoreService fsService = FirestoreService();

      //function to add register account
      fsService.addAccount(firstname, email, phone);

      //function to register for email and password
      return authService.register(email,password).then((value) {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User Registered successfully!'),));
      })
      // catch errors such as run time errors
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

    //used for screen responsiveness
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Form(
      key: form,
      child: isPortrait ? Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Lets Get started' , style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,), textAlign: TextAlign.center),
          SizedBox(height: 10),
          Text('create an account to access all the features' , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,), textAlign: TextAlign.center),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16)
              ),
              labelText: "Firstname",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) {
              if (value!.isEmpty)
                return "Plese provide a valid name";
            },
            onSaved: (value) {
              firstname = value;
            },
          ),
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
              labelText: "Phone",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.phone),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty)
                return "Please provide a valid phone no.";
              else if (value.length > 8)
                return 'Phone number cannot be more than 8 digits';
            },
            onSaved: (value) {
              phone = value;
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
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16)
              ),
              labelText: "Confirm Password",
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
              confirmPassword = value;
            },
          ),
          SizedBox(height: 10),
          ElevatedButton(onPressed: () { register(); }, child: Text('Register')),
        ],
      ): Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Lets Get started' , style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,), textAlign: TextAlign.center),
                SizedBox(height: 10),
                Text('create an account to access all the features' , style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,), textAlign: TextAlign.center),
                SizedBox(height: 10),
                SizedBox(
                  width: 250,
                  height: 45,
                  child:
                  TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)
                      ),
                      labelText: "Firstname",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value!.isEmpty)
                        return "Plese provide a valid name";
                    },
                    onSaved: (value) {
                      firstname = value;
                    },
                  ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  width: 250,
                  height: 45,
                  child:
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
                ),
                SizedBox(height: 10,)
              ],
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width / 3,
              padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 250,
                    height: 45,
                    child:
                    TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)
                        ),
                        labelText: "Phone",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty)
                          return "Please provide a valid phone no.";
                        else if (value.length > 8)
                          return 'Phone number cannot be more than 8 digits';
                      },
                      onSaved: (value) {
                        phone = value;
                      },
                    ),
                ),
                SizedBox(height: 10),
                SizedBox(
                    width: 250,
                    height: 45,
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
                SizedBox(height: 10),
                SizedBox(
                  width: 250,
                  height: 45,
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)
                      ),
                      labelText: "Confirm Password",
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
                      confirmPassword = value;
                    },
                  ),
                ),
              ],
            )
          ),
          Container(
            width: MediaQuery.of(context).size.width / 4,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                ElevatedButton(onPressed: () { register(); }, child: Text('Register')),
              ],
            ),
          )
        ],
      )
    );
  }
}
