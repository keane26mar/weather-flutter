import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_2/dateTime.dart';
import 'package:project_2/firestore_service.dart';
import 'package:project_2/notification_api.dart';

class EditBookingsScreen extends StatefulWidget {

  static String routeName = '/edit-bookings';

  @override
  State<EditBookingsScreen> createState() => _EditBookingsScreenState();
}

class _EditBookingsScreenState extends State<EditBookingsScreen> {

  @override
  void initState() {
    super.initState();
    // NotificationApi.init();
  }

  var editform = GlobalKey<FormState>();
  String? booking_description;
  String? booking_rate;
  DateTime? date;

//function to edit bookings
  void editbookings(String id) {
    bool isValid = editform.currentState!.validate();

    //if valid then initiate the function to edit booking
    if (isValid) {
      editform.currentState!.save();
      FirestoreService fsService = FirestoreService();
      fsService.editBooking(id, booking_description, booking_rate, date);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('booking edited successfully!'),));
      setState(() {
        Navigator.of(context).pop();
      });
    }

  }

  // function to access date picker
  void presentDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate:  DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2023),
    ).then((value) {
      if (value == null) return;
      setState(() {
        date = value;
      });
    });
  }
  // function to access time picker
  Future<TimeOfDay?> picktime() => showTimePicker
    (context: context,
      initialTime: TimeOfDay.now()
  );


  @override
  Widget build(BuildContext context) {

    //modalRoute used navigate an object to another page
    Booking selectedBooking = ModalRoute.of(context)?.settings.arguments as Booking;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Edit Bookings'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: editform,
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
                initialValue: selectedBooking.booking_description,
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
                initialValue: selectedBooking.booking_rate,
                onSaved: (value) { booking_rate = value as String; },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final time  = await picktime();
                      if(time == null) return;

                      final newDateTime = DateTime(
                        selectedBooking.date.year,
                        selectedBooking.date.month,
                        selectedBooking.date.day,
                        time.hour,
                        time.minute,
                      );
                      setState(() {
                        date = newDateTime;
                      });
                    }, child: Text("Select Time"),

                  ),
                  ElevatedButton(onPressed: () {presentDatePicker(context);} , child: Text('Select Date')),
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
                      child: Text(
                              date == null ? DateFormat.jm().format(selectedBooking.date) : DateFormat.jm().format(date!).toString()
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    color: Colors.grey,
                    child: Center(
                      child: Text(date == null ? DateFormat('dd/MM/yyyy').format(selectedBooking.date) : DateFormat('dd/MM/yyyy').format(date!),
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
                      onPressed: () {
                        editbookings(selectedBooking.id);
                        // NotificationApi.showNotification(
                        //     title: 'Bookings',
                        //     body:'time updated to:' + DateFormat.jm().format(date!).toString() + ' date updated to:' + DateFormat('dd/MM/yyyy').format(date!) ,
                        //     payload: 'Bookings'
                        // );
                        // saveForm(selectedExpense.id);
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
                    onPressed: () { Navigator.of(context).pop();},)
        // Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));
                  // saveBooking;
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
