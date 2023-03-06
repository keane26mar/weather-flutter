

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_2/auth_service.dart';
import 'package:project_2/changePass.dart';
import 'package:project_2/firestore_service.dart';
import 'package:project_2/user_class.dart';



class EditProfileScreen extends StatefulWidget {

  static String routeName = '/edit-profile';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var form = GlobalKey<FormState>();




  FirestoreService fsService = FirestoreService();

  AuthService authService = AuthService();

  String? firstname;
  String? phone;
  File? userImage;

// method to edit profile
  void saveForm (context, String uid) {
    bool isValid = form.currentState!.validate();

    //if image is empty, alert user to include food image
    if(userImage == null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please include a food image!'),));
      return;
    }

    //if valid store the image and update the selected information
    if (isValid) {
      form.currentState!.save();
      FirebaseStorage.instance.ref().child(basename(userImage!.path)).
      putFile(userImage!).then((task) {
        task.ref.getDownloadURL().then((profileImage) {
          fsService.editProfile(uid, firstname, phone, profileImage);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('profile updated successfully!'),));
          setState(() {
            Navigator.of(context).pop();
          });
        });
      });
    }

  }

  //function to open image picker
  Future<void> pickImage() {
    ImageSource chosenSource = ImageSource.gallery;
    // ImageSource chosenSource = mode == 0 ? ImageSource.camera : ImageSource.gallery;
    return ImagePicker()
        .pickImage(source: chosenSource, maxWidth: 600, imageQuality: 50,
        maxHeight: 150)
        .then((imageFile) {
      if (imageFile != null) {
        setState(() {
          userImage = File(imageFile.path);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //provider used to obtain the properties of users
    user selecteduser = ModalRoute.of(context)?.settings.arguments as user;

    //var used for screen responsiveness
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: StreamBuilder<List<user>>(
        stream: fsService.getProfile(),
        builder: (context, snapshot) {
            return isPortrait? Container(
              padding: EdgeInsets.all(10),
              child: Form(
                key: form,
                child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            child:
                            ClipOval(
                              child: Material(
                                color: Colors.transparent,
                                child:
                                Container(
                                    width: 125,
                                    height: 125,
                                    decoration: BoxDecoration(color: Colors.grey),
                                    child:
                                    userImage != null ? FittedBox(fit: BoxFit.cover, child: Image.file(userImage!)) : Center()
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue
                                  ),
                                  child:
                                  IconButton(onPressed: () {
                                    pickImage();
                                  },
                                      icon: Icon(
                                        Icons.edit, color: Colors.white,)
                                  )
                                // Icon(Icons.edit, color: Colors.white),
                              ))
                        ],
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        initialValue: selecteduser.firstname,
                        decoration: InputDecoration(
                          labelText: "Firstname",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        onSaved: (value) { firstname = value as String;},
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        initialValue: selecteduser.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          enabled: false,
                          labelText: "Email",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Please Enter Your Email Field!";
                          else if (!RegExp(
                              "^[a-zA-Z0-9_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(
                              value))
                            return "Please Provide A Valid Email!";
                          else
                            return null;
                        },

                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        initialValue: selecteduser.phone,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Phone",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                        ),
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Please Enter Your Contact No Field!';
                          else if (value.length < 8)
                            return 'Number Must Be Of 8 Numeric Digits!';
                          else
                            return null;
                        },
                        onSaved: (value) { phone = value as String;},
                        // onSaved: (value) { booking_rate = value as String; },
                      ),

                      SizedBox(height: 20),
                      Column(
                        children: [

                          ElevatedButton
                          // editbookings(selectedBooking.id)
                            (onPressed: () {
                            saveForm(context, selecteduser.uid);
                          }, child: Text('Save changes'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(400, 50),
                              primary: Color(0xff03AC13),
                              onPrimary: Colors.white,
                            ),
                          ),
                          SizedBox(height: 20),
                          ElevatedButton
                            (onPressed: () {
                            Navigator.push(context,MaterialPageRoute(builder: (context) => ChangePass()));
                          },
                            child: Text('Update password'),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(400, 50),
                              primary: Color(0xff03AC13),
                              onPrimary: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ]
                ),
              ),
            ): Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            child:
                            ClipOval(
                              child: Material(
                                color: Colors.transparent,
                                // date == null ? DateFormat.jm().format(selectedBooking.date) : DateFormat.jm().format(date!).toString()
                                // snapshot.data![0].profileImage == '' ? 'https://i.postimg.cc/KctzHMqS/user.png' : selecteduser.profileImage,
                                // ListofUsers.myUsers[0].profileImage == '' ? 'https://i.postimg.cc/KctzHMqS/user.png' :ListofUsers.myUsers[0].profileImage,
                                child:
                                Container(
                                    width: 125,
                                    height: 125,
                                    decoration: BoxDecoration(color: Colors.grey),
                                    child:
                                    userImage != null ? FittedBox(fit: BoxFit.cover, child: Image.file(userImage!)) : Center()
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue
                                  ),
                                  child:
                                  IconButton(onPressed: () {
                                    pickImage();
                                  },
                                      icon: Icon(
                                        Icons.edit, color: Colors.white,)
                                  )
                                // Icon(Icons.edit, color: Colors.white),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        initialValue: selecteduser.firstname,
                        decoration: InputDecoration(
                          labelText: "Firstname",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        onSaved: (value) { firstname = value as String;},
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        initialValue: selecteduser.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          enabled: false,
                          labelText: "Email",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value!.isEmpty)
                            return "Please Enter Your Email Field!";
                          else if (!RegExp(
                              "^[a-zA-Z0-9_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(
                              value))
                            return "Please Provide A Valid Email!";
                          else
                            return null;
                        },

                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        initialValue: selecteduser.phone,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Phone",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                        ),
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Please Enter Your Contact No Field!';
                          else if (value.length < 8)
                            return 'Number Must Be Of 8 Numeric Digits!';
                          else
                            return null;
                        },
                        onSaved: (value) { phone = value as String;},
                        // onSaved: (value) { booking_rate = value as String; },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton
                      // editbookings(selectedBooking.id)
                        (onPressed: () {
                        saveForm(context, selecteduser.uid);
                      }, child: Text('Save changes'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(400, 50),
                          primary: Color(0xff03AC13),
                          onPrimary: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton
                        (onPressed: () {
                        // Navigator.of(context).pushReplacementNamed(ChangePass.routeName);
                        Navigator.pop(context);
                      },
                        child: Text('Update password'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(400, 50),
                          primary: Color(0xff03AC13),
                          onPrimary: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }
      ),
    );
  }
}


