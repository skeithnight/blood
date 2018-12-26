class UserModel{
  String uid;
  String name;
  String phoneNumber;
  String address;
  String bloodType;

  UserModel();

  UserModel.fromSnapshot( Map<dynamic,dynamic> snapshot)
      : name = snapshot["name"],
        uid = snapshot["uid"],
        phoneNumber = snapshot["phoneNumber"],
        address = snapshot["address"],
        bloodType = snapshot["bloodType"];

  toJson() {
    return {
      "uid": uid,
      "name": name,
      "phoneNumber": phoneNumber,
      "address": address,
      "bloodType": bloodType,
    };
  }
}