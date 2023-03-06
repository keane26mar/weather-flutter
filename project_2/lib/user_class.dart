class user {
  //properties for user class
  String uid;
  String firstname;
  String email;
  String phone;
  String profileImage;


  //the named parameters neccessary for the class to work as expected
  user({required this.uid, required this.firstname, required this.email, required this.phone, required this.profileImage});

  //create new instance of type user
  user.fromMap(Map <String, dynamic> snapshot, String uid) :
        uid = uid,
        firstname = snapshot['firstname'] ?? '',
        email = snapshot['email'] ?? '',
        phone = snapshot['phone'] ?? '',
        profileImage = snapshot['profileImage'] ?? '';
}
