import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_2/dateTime.dart';

import 'package:project_2/edit_booking.dart';
import 'package:project_2/firestore_service.dart';

import 'package:provider/provider.dart';

class BookingsList extends StatefulWidget {

  static String routeName = '/Booking-List';

  @override
  State<BookingsList> createState() => _BookingsListState();
}

class _BookingsListState extends State<BookingsList> {

  FirestoreService fsService = FirestoreService();

  //function to remove bookings
  void removeItem(String id) {
    showDialog<Null>(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              padding: EdgeInsets.all(30),
              height: 350,
              child: Column(
              children: [
                Image.asset('images/delete.png'),
                SizedBox(height: 20,),
                Text('Confirm Delete', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                SizedBox(height: 10,),
                Text('Are You sure you want to delete?', style: TextStyle(fontSize: 15), ),
                SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(style: ElevatedButton.styleFrom(
                        minimumSize: Size(100, 50),
                        primary: Color(0xffff0000),
                        onPrimary: Colors.white,
                      ),onPressed: () {
                        setState(() {
                          fsService.removeBooking(id);
                          // myBooking.removeBooking(i);
                        });
                        Navigator.of(context).pop();
                      }, child: Text('Delete')),
                      ElevatedButton(style: ElevatedButton.styleFrom(
                      minimumSize: Size(100, 50),
          primary: Color(0xffC0C0C0),
          onPrimary: Colors.white,
          ),onPressed: (){
                        Navigator.of(context).pop();
                      }, child: Text('Cancel')),
                    ],
                  ),
              ],
            ),
          ),
          );
        });
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
        child:  StreamBuilder<List<Booking>>(
          stream: fsService.getBookings(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            else {
              return ListView.builder(
                itemBuilder: (ctx, i) {
                  return Container(
                    height: 230,
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 200,
                                  child: Text('Facility:', style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  child: Text('Date:', style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 200,
                                      child: Text(
                                        // bookingList.getMyBooking()[i].booking_description,
                                          snapshot.data![i].booking_description,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Container(
                                      width: 120,
                                      child: Text(
                                          // DateFormat('dd/MM/yyyy').format(bookingList.getMyBooking()[i].date).toString(),
                                        DateFormat('dd/MM/yyyy').format(snapshot.data![i].date).toString(),
                                          style: TextStyle(fontSize: 20,)
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                Container(
                                  width: 200,
                                  child: Text('Time:', style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: 120,
                                  child: Text('Total fare:', style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 200,
                                      child: Text(
                                        // DateFormat.jm().format(bookingList.getMyBooking()[i].date).toString(),
                                          DateFormat.jm().format(snapshot.data![i].date).toString(),
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Container(
                                      width: 120,
                                      child: Text(
                                          // bookingList.getMyBooking()[i].booking_rate,
                                        snapshot.data![i].booking_rate,
                                          style: TextStyle(fontSize: 20,)
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(style: ElevatedButton.styleFrom(
                                  minimumSize: Size(150, 50),
                                  primary: Color(0xff03AC13),
                                  onPrimary: Colors.white,
                                ), onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      EditBookingsScreen.routeName,
                                      arguments: snapshot.data![i]);
                                }, child: Text('Edit')),
                                ElevatedButton(style: ElevatedButton.styleFrom(
                                  minimumSize: Size(150, 50),
                                  primary: Color(0xffff0000),
                                  onPrimary: Colors.white,
                                ), onPressed: () {
                                  // removeItem(i, bookingList);
                                  removeItem(snapshot.data![i].id);
                                }, child: Text('Delete'))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount:
                // bookingList.getMyBooking().length,
                snapshot.data!.length,
              );
            }
          }
        )

              );
            }
  }



