import 'package:flutter/material.dart';

class WeatherTile extends StatelessWidget {
  IconData? icon;
  String title;
  String subTitle;

  WeatherTile({@required this.icon, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.purple)

        ],
      ),
      title: Text(title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600 ),) ,
      subtitle: Text(subTitle, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),) ,
    );
  }
}
