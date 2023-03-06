import 'package:flutter/material.dart';
import 'package:project_2/AppDrawer.dart';
import 'package:project_2/booking_list.dart';
import 'package:project_2/dateTime.dart';
import 'package:project_2/facility_class.dart';
import 'package:project_2/firestore_service.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatelessWidget {

  static String routeName = '/bookings';
  @override
  Widget build(BuildContext context) {

    //access the fireStoreService
    FirestoreService fsService = FirestoreService();

    //used to make screen responsive
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return StreamBuilder<List<Booking>> (
      stream: fsService.getBookings(),
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.waiting ?
        Center(child: CircularProgressIndicator()) :
        Scaffold(
              backgroundColor: const Color(0xff2832C2),
              appBar: AppBar(
                title: Text('Bookings'),
              ),
              body: isPortrait ? Container(
                  alignment: Alignment.center,
                  child: snapshot.data!.length > 0 ? BookingsList() :
                  Column(
                    children: [
                      SizedBox(height: 20),
                      Image.asset('images/bookings.png', width: 300),
                      Text('No Bookings yet, add a new one today!', style: TextStyle(color: Colors.white, fontSize: 15)
                       ),
                    ],
                  )
              ): Row(
                children: [
                  Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 1,
                          alignment: Alignment.center,
                          child: snapshot.data!.length > 0 ? BookingsList() :
                          Column(
                            children: [
                              SizedBox(height: 20),
                              Image.asset('images/bookings.png', width: 200),
                              Text('No Bookings yet, add a new one today!', style: TextStyle(color: Colors.white, fontSize: 15)
                              ),
                            ],
                          )
                      )
                    ],
                  )
                ],
              ),
          drawer: AppDrawer(),
            );
      }
    );
  }
}
