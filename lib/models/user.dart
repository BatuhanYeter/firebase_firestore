class AnonUser { // Adı User classından farklı olsun diye AnonUser dedim
  final String uid; // When we have this, we need to use it in the constructor

  AnonUser({ this.uid });
}

class SingleUserData {
  final String uid;
  final String name;
  final String email;
  final String password;

  SingleUserData({this.uid, this.name, this.email, this.password});

}