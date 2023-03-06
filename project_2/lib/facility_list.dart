


import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:project_2/facility_class.dart';

class FacilityList with ChangeNotifier {
  List<facility> myFacility = [
    facility('https://i.postimg.cc/TYDx0KZP/basketball.jpg', 'Basketball Court', '9:00 am - 9:00 pm', 'shorturl.at/dpvQ0', '82016508' , 'sdaa@tp.edu.sg', '14.00'),
    facility('https://i.postimg.cc/65PpMsj9/school-gym-1.jpg', 'School Gym', '9:00 am - 6:00 pm', 'shorturl.at/dpvQ0', '88129072' , 'sdaa@tp.edu.sg', '12.00'),
    facility('https://i.postimg.cc/fRkMdHD6/swimming-pool-2.jpg', 'Swimming Pool', '9:00 am - 9:00 pm', 'shorturl.at/dpvQ0', '83892012', 'sdaa@tp.edu.sg', '8.00'),
    facility('https://i.postimg.cc/6p25g9TH/track.jpg', 'Stadium Track', '9:00 am - 9:30 pm', 'shorturl.at/dpvQ0', '81827823' , 'sdaa@tp.edu.sg', '12.00'),
    facility('https://i.postimg.cc/XvvMmL2n/badminton-court.jpg', 'Badminton Court', '9:00 am - 6:00 pm', 'shorturl.at/dpvQ0', '80678921' , 'sdaa@tp.edu.sg', '18.00'),
    facility('https://i.postimg.cc/fW1wdG8m/table-tennis.jpg', 'Table Tennis', '9:00 am - 9:00 pm', 'shorturl.at/dpvQ0', '80819852' , 'sdaa@tp.edu.sg', '18.00'),
  ];

  List<facility> getfacilityList() {
    return myFacility;
  }



}

