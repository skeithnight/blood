import 'package:firebase_database/firebase_database.dart';

class RequestDarahModel{
  String tanggal;
  String judulAcara;

  RequestDarahModel();

  RequestDarahModel.fromSnapshot( Map<dynamic,dynamic> snapshot)
      : tanggal = snapshot["tanggal"],
        judulAcara = snapshot["judulAcara"];

  toJson() {
    return {
      "judulAcara": judulAcara,
      "tanggal": tanggal,
    };
  }
}