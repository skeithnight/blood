import 'package:firebase_database/firebase_database.dart';

class StokDarah{
  String key;
  int jumlah;

  StokDarah();

  StokDarah.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        jumlah = snapshot.value["jumlah"];

  toJson() {
    return {
      "jumlah": jumlah,
    };
  }
}