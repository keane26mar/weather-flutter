import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_2/facility.dart';
import 'package:project_2/facility_class.dart';
import 'package:project_2/firestore_service.dart';
import 'package:project_2/main.dart';
import 'package:project_2/notification_api.dart';

class CalenderScreen extends StatefulWidget {



  static String routeName = '/Calender';



  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}




class _CalenderScreenState extends State<CalenderScreen> {


  @override
  void initState() {
    super.initState();
    NotificationApi.init();
  }


  var form = GlobalKey<FormState>();
  String? booking_description;
  String? booking_rate;

  DateTime date = DateTime.now();

  // method to add bookings
  void saveBooking() {
    bool isValid = form.currentState!.validate();
    if (isValid) {
      form.currentState!.save();
      print(booking_description);
      print(booking_rate);
      print(date);

      //access the firestore service
      FirestoreService fsService = FirestoreService();
      // function to addbooking with the selected fields
      fsService.addBooking(booking_description, booking_rate, date);

      FocusScope.of(context).unfocus();
      // Resets the form
      form.currentState!.reset();

      // Shows a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
      Text('Bookings Has Been Successfully Added!'),));
    }
  }

  // function to access date picker
  Future<DateTime?> pickdate() =>
      showDatePicker
        (context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010),
        lastDate: DateTime(2023),
      );

  //function to access time picker
  Future<TimeOfDay?> picktime() => showTimePicker
    (context: context,
      initialTime: TimeOfDay(hour: date.hour, minute: date.minute)
  );




  @override
  Widget build(BuildContext context) {
    //modalRoute used navigate an object to another page
    facility selectedfacility = ModalRoute.of(context)?.settings.arguments as facility;

    //used to make screen responsive
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    final hours = date.hour.toString().padLeft(2, '0');
    final minutes = date.minute.toString().padLeft(2 , '0');

    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Add Bookings'),
        ),
      body: isPortrait ? Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: form,
          child: Column(
            children: <Widget> [
              SizedBox(height: 10,),
             Row(
               children: [
               Text('Choosen facility:', style: TextStyle(fontSize: 15),)
               ],
             ),
              TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  disabledBorder: InputBorder.none,
                ),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                initialValue: selectedfacility.description,
                onSaved: (value) { booking_description = value as String; },

              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text('Total Cost:', style: TextStyle(fontSize: 15),)
                ],
              ),
              SizedBox(height: 10,),
              TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  disabledBorder: InputBorder.none,
                ),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                initialValue: '\$' + selectedfacility.bookingRates,
                onSaved: (value) { booking_rate = value as String; },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // presentTimePicker(context);
                    final time  = await picktime();
                    if(time == null) return;

                    final newDateTime = DateTime(
                      date.year,
                      date.month,
                      date.day,
                      time.hour,
                      time.minute,
                    );
                      setState(() {
                        date = newDateTime;
                      });
                    }, child: Text("Select Time"),
                  ),
                  ElevatedButton(onPressed: () async {
                    final selectdatetime = await pickdate();
                    if(selectdatetime == null) return;

                    final newDateTime = DateTime(
                      selectdatetime.year,
                      selectdatetime.month,
                      selectdatetime.day,
                      date.hour,
                      date.minute
                    );
                    setState(() {
                      date = newDateTime;
                    });
                  } , child: Text('Select Date')),
                ],
              ),
              SizedBox(height:10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150,
                    height: 50,
                    color: Colors.grey,
                    child: Center(
                      child: Text(DateFormat.jm().format(date)
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    color: Colors.grey,
                    child: Center(
                        child: Text(DateFormat('dd/MM/yyyy').format(date),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height:50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style:  ElevatedButton.styleFrom(
                        minimumSize: Size(150, 50),
                        primary: Color(0xff03AC13),
                        onPrimary: Colors.white,
                      ),
                      child: Text('Proceed', style: TextStyle(fontWeight:
                      FontWeight.bold)),
                      onPressed: () {showDialog(builder: (context) => Dialog(
                        child: Column(
                          children: [
                            SizedBox(height: 12,),
                            Text(
                              'Booking Details', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, decoration: TextDecoration.underline,),
                            ),
                            SizedBox(height: 20,),
                                Text('Facility:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,) ),
                                SizedBox(height: 15,),
                                Text(selectedfacility.description, style: TextStyle(fontSize: 20)),
                            SizedBox(height: 15,),
                            Text('Date:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,) ),

                            SizedBox(height: 15,),

                            Text(DateFormat('dd/MM/yyyy').format(date),style: TextStyle(fontSize: 20)  ),

                            SizedBox(height: 15,),

                            Text('Time:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,) ),

                            SizedBox(height: 15,),

                            Text( DateFormat.jm().format(date), style: TextStyle(fontSize: 20) ,),

                            SizedBox(height: 15,),
                            Text('Total fare:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,) ),
                            SizedBox(height: 15,),
                            Text('\$' + selectedfacility.bookingRates, style: TextStyle(fontSize: 20)),
                            SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //   Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen()));
                                ElevatedButton(style:  ElevatedButton.styleFrom(
                            minimumSize: Size(125, 50),
                        primary: Color(0xff03AC13),
                        onPrimary: Colors.white,
                      ), onPressed: () {
                                  NotificationApi.showNotification(
                                      title: 'Bookings',
                                      body:'A new booking has been succesfully booked',
                                      payload: 'Bookings'
                                  );
                                  saveBooking();
                                  Navigator.of(context).pushNamed(MainScreen.routeName);
                                  }
                                 , child: Text('confirm')),
                                ElevatedButton(style:  ElevatedButton.styleFrom(
                                  minimumSize: Size(125, 50),
                                  primary: Color(0xffff0000),
                                  onPrimary: Colors.white,
                                ) ,onPressed: (){
                                  Navigator.of(context).pop();
                                }, child: Text('Cancel') ),
                              ],
                            )
                          ],
                        ) ,
                      ), context: context);
                      }
                      ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(150, 50),
                      primary: Color(0xffFF0000),
                      onPrimary: Colors.white,
                    ),
                    child: Text('Cancel', style: TextStyle(fontWeight:
                    FontWeight.bold)),

                    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => FacilityScreen()));},)
      // saveBooking;
      ],
              ),
            ],
          ),
        ),
      ): Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text('Choosen facility:', style: TextStyle(fontSize: 15),),
                  ],
                ),
                TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                  ),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  initialValue: selectedfacility.description,
                  onSaved: (value) { booking_description = value as String; },

                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Text('Total Cost:', style: TextStyle(fontSize: 15),)
                  ],
                ),
                SizedBox(height: 5,),
                TextFormField(
                  enabled: false,
                  decoration: InputDecoration(
                    disabledBorder: InputBorder.none,
                  ),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  initialValue: '\$' + selectedfacility.bookingRates,
                  onSaved: (value) { booking_rate = value as String; },
                ),


              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // presentTimePicker(context);
                        final time  = await picktime();
                        if(time == null) return;

                        final newDateTime = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          time.hour,
                          time.minute,
                        );
                        setState(() {
                          date = newDateTime;
                        });
                      }, child: Text("Select Time"),
                    ),
                    ElevatedButton(onPressed: () async {
                      final selectdatetime = await pickdate();
                      if(selectdatetime == null) return;

                      final newDateTime = DateTime(
                          selectdatetime.year,
                          selectdatetime.month,
                          selectdatetime.day,
                          date.hour,
                          date.minute
                      );
                      setState(() {
                        date = newDateTime;
                      });
                    } , child: Text('Select Date')),

                  ],
                ),
                SizedBox(height:10),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 150,
                      height: 50,
                      color: Colors.grey,
                      child: Center(
                        child: Text(DateFormat.jm().format(date)
                        ),
                      ),
                    ),
                    Container(
                      width: 150,
                      height: 50,
                      color: Colors.grey,
                      child: Center(
                        child: Text(DateFormat('dd/MM/yyyy').format(date),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height:50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style:  ElevatedButton.styleFrom(
                          minimumSize: Size(150, 50),
                          primary: Color(0xff03AC13),
                          onPrimary: Colors.white,
                        ),
                        child: Text('Proceed', style: TextStyle(fontWeight:
                        FontWeight.bold)),
                        onPressed: () {showDialog(builder: (context) => Dialog(
                          child: Column(
                            children: [
                              SizedBox(height: 12,),
                              Text(
                                'Booking Details', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, decoration: TextDecoration.underline,),
                              ),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Facility:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,) ),
                                  SizedBox(height: 10,),
                                  Text('Date:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,) ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(selectedfacility.description, style: TextStyle(fontSize: 20)),
                                  SizedBox(height: 10,),
                                  Text(DateFormat('dd/MM/yyyy').format(date),style: TextStyle(fontSize: 20)  ),
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Time:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,) ),
                                  SizedBox(height: 10,),
                                  Text('Total fare:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,) ),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text( DateFormat.jm().format(date), style: TextStyle(fontSize: 20) ,),
                                  SizedBox(height: 10,),
                                  Text('\$' + selectedfacility.bookingRates, style: TextStyle(fontSize: 20)),
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  //   Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentScreen()));
                                  ElevatedButton(style:  ElevatedButton.styleFrom(
                                    minimumSize: Size(125, 50),
                                    primary: Color(0xff03AC13),
                                    onPrimary: Colors.white,
                                  ), onPressed: () {saveBooking();
                                  Navigator.of(context).pushNamed(MainScreen.routeName);
                                  NotificationApi.showNotification(
                                      title: 'notifications',
                                      body:'A new booking has been succesfully booked',
                                      payload: 'notifications'
                                  );
                                  }
                                      , child: Text('confirm')),
                                  ElevatedButton(style:  ElevatedButton.styleFrom(
                                    minimumSize: Size(125, 50),
                                    primary: Color(0xffff0000),
                                    onPrimary: Colors.white,
                                  ) ,onPressed: (){
                                    Navigator.of(context).pop();
                                  }, child: Text('Cancel') ),
                                ],
                              )
                            ],
                          ) ,
                        ), context: context);
                        }
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(150, 50),
                        primary: Color(0xffFF0000),
                        onPrimary: Colors.white,
                      ),
                      child: Text('Cancel', style: TextStyle(fontWeight:
                      FontWeight.bold)),

                      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => FacilityScreen()));},)
                    // saveBooking;
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}