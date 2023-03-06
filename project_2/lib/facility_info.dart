import 'package:flutter/material.dart';
import 'package:project_2/calender.dart';
import 'package:project_2/facility_class.dart';

class FacilityInfo extends StatelessWidget {
  static String routeName = '/facilityinfo';

  @override
  Widget build(BuildContext context) {
    //modalRoute used navigate an object to another page
    facility selectedfacility = ModalRoute.of(context)?.settings.arguments as facility;
    return Scaffold(
      appBar: AppBar(
        title: Text('facilities'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          children: <Widget> [
              Image.network(selectedfacility.imageUrl),
              SizedBox(height:10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text ('Facility',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height:15),
            Row(
              children: [
                Text(selectedfacility.description, style:
                Theme.of(context).textTheme.titleMedium)
              ],
            ),
            SizedBox(height:15),
            Row(
              children: [
                Expanded(child: Text ('Operating Hours',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
                ),
                SizedBox(width: 20),
                Expanded(child: Text ('Website',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                )
              ],
            ),
            SizedBox(height:15),
            Row(
              children: [
                Expanded(child:
                Text(selectedfacility.operationTime, style:
                Theme.of(context).textTheme.titleMedium),
                ),
                SizedBox(width: 20),
                Expanded(child:
                Text(selectedfacility.website, style:
                Theme.of(context).textTheme.titleMedium),
                )
              ],
            ),
            SizedBox(height:15),
            Row(
              children: [
                Expanded(child: Text ('Contact No:',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ),
                SizedBox(width: 20),
                Expanded(child: Text ('Email',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                )
              ],
            ),
            SizedBox(height:15),
            Row(
              children: [
                Expanded(child:
                Text(selectedfacility.contact, style:
                Theme.of(context).textTheme.titleMedium),
                ),
                SizedBox(width: 20),
                Expanded(child:
                Text(selectedfacility.email, style:
                Theme.of(context).textTheme.titleMedium),
                )
              ],
            ),

            SizedBox(height:15),
            Row(
              children: [
                Expanded(child: Text ('Booking Rates:',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ),
              ],
            ),
            SizedBox(height:15),
            Row(
              children: [
                Expanded(child:
                Text( '\$' + selectedfacility.bookingRates + 'per hour', style:
                Theme.of(context).textTheme.titleMedium),
                ),
              ],
            ),
            SizedBox(height:15),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150, 50),
          primary: Colors.black,
      onPrimary: Colors.white,
                  ),
                    child: Text('Proceed', style: TextStyle(fontWeight:
                    FontWeight.bold)),
                    onPressed: () {
                      Navigator.of(context).pushNamed(CalenderScreen.routeName,
                          arguments: selectedfacility);
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
