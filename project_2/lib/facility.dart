

import 'package:flutter/material.dart';
import 'package:project_2/AppDrawer.dart';
import 'package:project_2/auth_service.dart';
import 'package:project_2/bookings.dart';
import 'package:project_2/facility_info.dart';
import 'package:project_2/facility_list.dart';
import 'package:project_2/firestore_service.dart';
import 'package:project_2/profile.dart';
import 'package:provider/provider.dart';


class FacilityScreen extends StatefulWidget {

  static String routeName = '/facility';

  @override
  State<FacilityScreen> createState() => _FacilityScreenState();
}



class _FacilityScreenState extends State<FacilityScreen> {



  // int to switch the screens in between
  int selectedIndex = 0;
  final screens = [
    FacilityScreen(),
    BookingScreen(),
    ProfileScreen(),
  ];

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

  @override
  Widget build(BuildContext context) {

    //provider used to obtain the properties of facility
    FacilityList myFacility = Provider.of<FacilityList>(context);

    //access the firestore Service
    FirestoreService fsService = FirestoreService();


        return Scaffold(
          backgroundColor: const Color(0xff2832C2),
          appBar: AppBar(
            title: FittedBox(child: Text(
                // snapshot.data![0].firstname,
                'Welcome user' )),
            actions: [
              IconButton(onPressed: ()=> logOut(), icon: Icon(Icons.logout))
            ],
          ),
          body: Container (
            padding: EdgeInsets.all(10),
                child: Column (
                  children: [
                   SizedBox(height: 20),
                   Row(
                     children: [
                       Text ('Tp school facilities',
                       style: TextStyle(
                         fontSize: 20.0,
                         fontWeight: FontWeight.bold,
                         color: Color(0xffffffff),
                       ),
                       ),
                     ],
                   ),
        SizedBox(height: 20),
                    Expanded
                      (child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        childAspectRatio: 11/10
                      ),
                        itemBuilder: (ctx, i ) {
                          // facility currentFacility = myFacility.getfacilityList()[i];
                          final currentFacility = myFacility.getfacilityList()[i];
                          return Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              child: Container(
                                color: Colors.white,
                                child: GestureDetector(
                               onTap: () {
                          Navigator.of(context).pushNamed(FacilityInfo.routeName,
                                  arguments: currentFacility);
                               },
                                  child: Stack(
                                      children: [
                                        Image.network(currentFacility.imageUrl),
                                        Positioned(
                                            child: Text (currentFacility.description, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                          bottom: 5,
                                          left: 10,
                                        )
                                      ],
                                  ),
                                ),
                              ),
                            ),

                          );
                        },
                        itemCount: myFacility.getfacilityList().length
                    ),
                    )

                ],

            ),
          ),
          drawer: AppDrawer(),
        );



  }










}









