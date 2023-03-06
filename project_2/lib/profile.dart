import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_2/AppDrawer.dart';
import 'package:project_2/auth_service.dart';
import 'package:project_2/edit_profile.dart';
import 'package:project_2/firestore_service.dart';
import 'package:project_2/user_class.dart';

class ProfileScreen extends StatefulWidget {

  static String routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  @override
  Widget build(BuildContext context) {

    //access the authService
    AuthService authService = AuthService();

    //method to logout
    logOut() {
      //function to logout
      return authService.logOut().then((value) {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logout successfully!'),));
      }).
      // catch errors such as run time errors
      catchError((error) {
        FocusScope.of(context).unfocus();
        String message = error.toString();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
        Text(message),));
      });
    }


    //access the firestore Service
    FirestoreService fsService = FirestoreService();

    //used for screen responsiveness
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: const Color(0xff2832C2),
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: StreamBuilder<List<user>>(
        stream: fsService.getProfile(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting ?
          Center(child: CircularProgressIndicator()) :
          isPortrait ? Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column (
              children: <Widget>
              [
                Stack(
                  children: [
                    Container(
                      child:
                      ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child: Image.network(snapshot.data![0].profileImage,
                            fit: BoxFit.cover,
                            width: 125, height: 125, ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                ListView(
                  children: [
                    Card(
                        child: ListTile(
                          leading: Icon(Icons.phone),
                          title:Text(snapshot.data![0].phone, style: TextStyle(fontSize: 20),) ,
                        )
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.email),
                        title: Text(snapshot.data![0].email, style: TextStyle(fontSize: 20),) ,
                      ),
                    ),
                    Card(
                        child: ListTile(
                          leading: Icon(Icons.person),
                          title: Text(snapshot.data![0].firstname, style: TextStyle(fontSize: 20),) ,
                        )
                    ),
                  ],
                  shrinkWrap: true,
                  reverse: true,
                  padding: EdgeInsets.all(10),
                ),
                SizedBox(height: 30,),
                Expanded(child:
                Column(
                  children: [
                    ElevatedButton(
                        style:  ElevatedButton.styleFrom(
                          minimumSize: Size(300, 50),
                          primary: Color(0xff03AC13),
                          onPrimary: Colors.white,
                        ),
                        child: Text('Edit Profile', style: TextStyle(fontWeight:
                        FontWeight.bold)),
                        onPressed: () {
                          Navigator.of(context).pushNamed(EditProfileScreen.routeName, arguments: snapshot.data![0]);
                          // Navigator.of(context).pushNamed(EditProfileScreen.routeName, arguments: snapshot.data![0]);
                        }),
                    SizedBox(height: 20,),
                    ElevatedButton(
                        style:  ElevatedButton.styleFrom(
                          minimumSize: Size(300, 50),
                          primary: Color(0xffff0000),
                          onPrimary: Colors.white,
                        ),
                        child: Text('LogOut', style: TextStyle(fontWeight:
                        FontWeight.bold)),
                        onPressed: () {
                          logOut();
                        }),
                  ],
                )
                )
              ]
            ),//Text(myUsers[0].username),
          ): Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child:
                      ClipOval(
                        child: Material(
                          color: Colors.transparent,
                          child: Image.network(snapshot.data![0].profileImage,
                            fit: BoxFit.cover,
                            width: 125, height: 125, ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width /3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20,),
                    ListView(
                      children: [
                        Card(
                            child: ListTile(
                              leading: Icon(Icons.phone),
                              title:Text(snapshot.data![0].phone, style: TextStyle(fontSize: 20),) ,
                            )
                        ),
                        Card(
                          child: ListTile(
                            leading: Icon(Icons.email),
                            title: Text(snapshot.data![0].email, style: TextStyle(fontSize: 20),) ,
                          ),
                        ),
                        Card(
                            child: ListTile(
                              leading: Icon(Icons.person),
                              title: Text(snapshot.data![0].firstname, style: TextStyle(fontSize: 20),) ,
                            )
                        ),
                      ],
                      shrinkWrap: true,
                      reverse: true,
                      padding: EdgeInsets.all(10),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width /3,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 30,),
                    ElevatedButton(
                        style:  ElevatedButton.styleFrom(
                          minimumSize: Size(300, 50),
                          primary: Color(0xff03AC13),
                          onPrimary: Colors.white,
                        ),
                        child: Text('Edit Profile', style: TextStyle(fontWeight:
                        FontWeight.bold)),
                        onPressed: () {

                          Navigator.of(context).pushNamed(EditProfileScreen.routeName, arguments: snapshot.data![0]);
                          // Navigator.of(context).pushNamed(EditProfileScreen.routeName, arguments: snapshot.data![0]);
                        }),
                    SizedBox(height: 20,),
                    ElevatedButton(
                        style:  ElevatedButton.styleFrom(
                          minimumSize: Size(300, 50),
                          primary: Color(0xffff0000),
                          onPrimary: Colors.white,
                        ),
                        child: Text('LogOut', style: TextStyle(fontWeight:
                        FontWeight.bold)),
                        onPressed: () {
                          logOut();
                        }),
                  ],
                ),
              )
            ],
          );
        },
      ),
      drawer: AppDrawer(),
    );

  }
}

