import 'package:flutter/material.dart';
import 'package:project_2/auth_service.dart';
import 'package:project_2/bookings.dart';
import 'package:project_2/facility.dart';
import 'package:project_2/login_form.dart';
import 'package:project_2/main.dart';
import 'package:project_2/profile.dart';
import 'package:project_2/weatherScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';


class AppDrawer  extends StatelessWidget {




  @override
  Widget build(BuildContext context) {

    //access the authService
    AuthService authService = AuthService();

    //logout function
    logOut() {
      return authService.logOut().then((value) {
        FocusScope.of(context).unfocus();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logout successfully!'),));
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacementNamed('/');
      }).catchError((error) {
        FocusScope.of(context).unfocus();
        String message = error.toString();
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
        Text(message),));
      });
    }

    return Drawer(
      child: Column(children: [
        AppBar(
          title: Text("Hello Friend!"),
          automaticallyImplyLeading: false,
        ),
        ListTile(
          leading: Icon(Icons.bug_report_sharp),
          title: Text('Report a bug'),
          onTap: () async {
            String subject = 'Bug report!';
            String message = 'Hello Admin\n\nI am facing some issues with this app';
            String? encodeQueryParameters(Map<String, String> params) {
              return params.entries
                  .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                  .join('&');
            }

            final Uri emailLaunchUri = Uri(
              scheme: 'mailto',
              path: 'support@gmail.com',
              query: encodeQueryParameters(<String, String>{
                'subject': subject,
                'body' : message
              }),
            );
            launchUrl(emailLaunchUri);
          }
        ),
        Divider(height: 3, color: Colors.blueGrey),
        ListTile(
          leading: Icon(Icons.wb_sunny_sharp),
          title: Text('current weather'),
          onTap: () {
    Navigator.of(context).pushReplacementNamed(WeatherScreen.routeName);
    }
        ),
        Divider(height: 3, color: Colors.blueGrey),
        ListTile(
            leading: Icon(Icons.sports_basketball_rounded),
            title: Text('Facility'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(MainScreen.routeName);

            }
          // Navigator.of(context).pushReplacementNamed(GalleryScreen.routeName),
        ),
        Divider(height: 3, color: Colors.blueGrey),
        ListTile(
          leading: Icon(Icons.logout),
          title: Text('LogOut'),
          onTap: () {
            logOut();
          } // Navigator.of(context).pushReplacementNamed(HelpScreen.routeName),
        ),
        Divider(height: 3, color: Colors.blueGrey),
      ]),
    );

  }
}
