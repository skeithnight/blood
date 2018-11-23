import 'package:flutter/material.dart';
import 'package:blood/models/stok_darah_model.dart';

class StokDarahItem extends StatelessWidget {
  String golonganDarah;
  int jumlah;
  StokDarahItem(String golonganDarah, int jumlah) {
    this.golonganDarah = golonganDarah;
    this.jumlah = jumlah;
  }

  Widget _content() {
    // return Text(data.golonganDarah);
    return Card(
        elevation: 10.0,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Color.fromRGBO(206, 20, 20, 1.0),
            child: Text(
              golonganDarah,
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
          title: Text(jumlah.toString()),
        ));
  }

  @override
  Widget build(BuildContext context) {
    // print(stokDarah.golonganDarah);
    return _content();
  }
}
