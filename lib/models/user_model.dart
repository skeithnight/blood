class UserModel{
  String uid;
  String name;
  String phoneNumber;
  String address;
  String bloodType;
  String fcmToken;
  double lat;
  double lon;

  UserModel();

  UserModel.fromSnapshot( Map<dynamic,dynamic> snapshot)
      : name = snapshot["name"],
        uid = snapshot["uid"],
        phoneNumber = snapshot["phoneNumber"],
        address = snapshot["address"],
        bloodType = snapshot["bloodType"],
        fcmToken = snapshot["fcmToken"],
        lat = snapshot["lat"],
        lon = snapshot["lon"];

  toJson() {
    return {
      "uid": uid,
      "name": name,
      "phoneNumber": phoneNumber,
      "address": address,
      "bloodType": bloodType,
      "fcmToken": fcmToken,
      "lat": lat,
      "lon": lon,
    };
  }
}