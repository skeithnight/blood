import 'package:firebase_database/firebase_database.dart';

class EventModel{
  String tanggal;
  String judulAcara;

  EveEventModelnt();

  EventModel.fromSnapshot( Map<dynamic,dynamic> snapshot)
      : tanggal = snapshot["tanggal"],
        judulAcara = snapshot["judulAcara"];

  toJson() {
    return {
      "judulAcara": judulAcara,
      "tanggal": tanggal,
    };
  }
}