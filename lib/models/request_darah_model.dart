import 'package:firebase_database/firebase_database.dart';

class RequestDarahModel {
  String id;
  String description;
  String nama;
  String noTelp;
  String address;
  double latitude;
  double longitude;
  String tipeDarah;
  List<dynamic> listResponden;

  RequestDarahModel(
      {this.description,
      this.nama,
      this.noTelp,
      this.address,
      this.latitude,
      this.longitude,
      this.tipeDarah});

  RequestDarahModel.fromSnapshot(Map<dynamic, dynamic> snapshot)
      : description = snapshot["description"],
        nama = snapshot["nama"],
        noTelp = snapshot["noTelp"],
        address = snapshot["address"],
        latitude = snapshot["latitude"],
        longitude = snapshot["longitude"],
        tipeDarah = snapshot["tipeDarah"];

  RequestDarahModel.fromData(Map<dynamic, dynamic> snapshot,String id)
      : this.id = id,
        description = snapshot["description"],
        nama = snapshot["nama"],
        noTelp = snapshot["noTelp"],
        address = snapshot["address"],
        latitude = snapshot["latitude"],
        longitude = snapshot["longitude"],
        tipeDarah = snapshot["tipeDarah"],
        listResponden = snapshot["listResponden"];

  Map<String, dynamic> toJson() => {
        'description': description,
        'nama': nama,
        'noTelp': noTelp,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'tipeDarah': tipeDarah,
        'listResponden': listResponden,
      };
}
