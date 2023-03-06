
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


//properties for booking class
class Booking {
  String email;
  String id;
  String booking_description;
  String booking_rate;
  DateTime date;


  //the named parameters neccessary for the class to work as expected
  Booking ({required this.email,required this.id, required this.booking_description, required this.booking_rate,
  required this.date});

  //create new instance of type booking
  Booking.fromMap(Map <String, dynamic> snapshot,String id) :
        id = id,
        email = snapshot['email'] ?? '',
        booking_description = snapshot['booking_description'] ?? '',
        booking_rate = snapshot['booking_rate'] ?? '',
        date = (snapshot['date'] ?? Timestamp.now() as
        Timestamp).toDate();



}