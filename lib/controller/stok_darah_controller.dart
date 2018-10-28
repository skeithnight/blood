import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:blood/models/stok_darah_model.dart';

class StokDarahController {
  static Future<StreamSubscription<Event>> getStokDarahStream(String golDar,
      void onData(StokDarah data)) async {
        StokDarah stokdarah;
    StreamSubscription<Event> subscription = FirebaseDatabase.instance
        .reference()
        .child("stokDarah")
        .child(golDar)
        .onValue
        .listen((Event event) {
      stokdarah = new StokDarah.fromSnapshot(event.snapshot);
      onData(stokdarah);
    });
    print(stokdarah.key);
    return subscription;
  }
}