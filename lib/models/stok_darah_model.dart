import 'package:firebase_database/firebase_database.dart';

class StokDarah{
  String golonganDarah;
  int jumlah;

  StokDarah();

  StokDarah.fromSnapshot( Map<dynamic,dynamic> snapshot)
      : golonganDarah = snapshot["golongan"],
        jumlah = snapshot["jumlah"];

  toJson() {
    return {
      "jumlah": jumlah,
    };
  }
}