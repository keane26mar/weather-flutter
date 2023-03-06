import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_2/auth_screen.dart';
import 'package:project_2/auth_service.dart';
import 'package:project_2/bookings.dart';
import 'package:project_2/calender.dart';
import 'package:project_2/edit_booking.dart';
import 'package:project_2/edit_profile.dart';
import 'package:project_2/facility.dart';
import 'package:project_2/facility_info.dart';
import 'package:project_2/facility_list.dart';
import 'package:project_2/profile.dart';
import 'package:project_2/resetpassword.dart';
import 'package:project_2/weatherScreen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  AuthService authService = AuthService();


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FacilityList>(
          create: (ctx) =>FacilityList(),
        ),
      ],
    child: FutureBuilder(
        future: Firebase.initializeApp(),
      builder: (context, snapshot) => snapshot.connectionState ==
          ConnectionState.waiting ?
      Center(child: CircularProgressIndicator()) :
      StreamBuilder<User?>(
        stream: authService.getAuthUser(),
        builder: (context, snapshot) {
          return MaterialApp
            (
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: snapshot.connectionState == ConnectionState.waiting ?
          Center(child: CircularProgressIndicator()) :
          snapshot.hasData ? MainScreen() : AuthScreen(),
                routes: {
                  FacilityInfo.routeName: (_) {return FacilityInfo(); },
                  CalenderScreen.routeName: (_) {return CalenderScreen();},
                  BookingScreen.routeName: (_) {return BookingScreen();},
                  EditBookingsScreen.routeName: (_) {return EditBookingsScreen();},
                  AuthScreen.routeName : (_) { return AuthScreen(); },
                  EditProfileScreen.routeName : (_) {return EditProfileScreen();},
                  WeatherScreen.routeName : (_) {return WeatherScreen();},
                  ResetPasswordScreen.routeName : (_) { return ResetPasswordScreen(); }
                }
            );
        }
      ),
    ),
    );
  }
}


class MainScreen extends StatefulWidget {



  static String routeName = '/';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  //screens for bottom navigation bar
  int selectedIndex = 0;
  final screens = [
    FacilityScreen(),
    BookingScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff2832C2),
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.sports_basketball_rounded), label: 'Facility'),
          BottomNavigationBarItem(icon: Icon(Icons.book_online_outlined), label: 'Bookings'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle_rounded),label: 'Profile',)
        ],
      ),
    );
  }
}
