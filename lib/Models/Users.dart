class Cusers {
  String userName;
  String uid;
  String gsm;

  String email;

  /*


  * */
// from json to object cusers
  Cusers({
    required this.uid,
    required this.userName,
    required this.email,
    required this.gsm,
  });
  factory Cusers.fromJson(Map<String, dynamic> json) {
    return Cusers(
      uid: json["uid"],
      userName: json["userName"],
      email: json["email"],
      gsm: json["gsm"],
    );
  }
// from object to json
  Map<String, dynamic> Tojson() {
    return {
      "uid": uid,
      "userName": userName,
      "email": email,
      "gsm": gsm,
    };
  }
}
