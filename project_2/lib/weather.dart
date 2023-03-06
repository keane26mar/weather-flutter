
//properties for Weather class
class Weather {
  String? cityName;
  double? temp;
  int? humidity;
  double? wind;
  String? weather;


  //the named parameters neccessary for the class to work as expected
  Weather({required this.cityName, required this.temp,
    required this.humidity,  required this.wind,required this.weather});

  // //create new instance of type user however in te format of Json
  Weather.fromJson(Map<String, dynamic> json) {
    print(json);
    cityName = json['name'];
    temp = json['main']['temp'];
    wind = json['wind']['speed'];
    humidity = json['main']['humidity'];
    weather = json['weather'][0]['main'];
  }


}











// class Booking {
//   String email;
//   String id;
//   String booking_description;
//   String booking_rate;
//   DateTime date;
//
//
//   Booking ({required this.email,required this.id, required this.booking_description, required this.booking_rate,
//     required this.date});
//
//   Booking.fromMap(Map <String, dynamic> snapshot,String id) :
//         id = id,
//         email = snapshot['email'] ?? '',
//         booking_description = snapshot['booking_description'] ?? '',
//         booking_rate = snapshot['booking_rate'] ?? '',
//         date = (snapshot['date'] ?? Timestamp.now() as
//         Timestamp).toDate();
//
//
//
// }