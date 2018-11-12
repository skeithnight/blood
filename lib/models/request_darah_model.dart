import 'package:firebase_database/firebase_database.dart';

class RequestDarahModel {
  String description;
  String nama;
  String noTelp;
  String address;
  double latitude;
  double longitude;
  String tipeDarah;

  RequestDarahModel({this.description,this.nama,this.noTelp,this.address,this.latitude,this.longitude,this.tipeDarah});

  RequestDarahModel.fromSnapshot(Map<dynamic,dynamic> snapshot)
      : description = snapshot["description"],
        nama = snapshot["nama"],
        noTelp = snapshot["noTelp"],
        address = snapshot["address"],
        latitude = snapshot["latitude"],
        longitude = snapshot["longitude"],
        tipeDarah = snapshot["tipeDarah"];

  Map<String, dynamic> toJson() => {
        'description': description,
        'nama': nama,
        'noTelp': noTelp,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'tipeDarah': tipeDarah,
      };
}
