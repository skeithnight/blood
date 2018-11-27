import 'package:flutter/material.dart';
import 'package:blood/models/stok_darah_model.dart';
import 'package:blood/models/detail_stok_darah_model.dart';

class DetailStokDarahItem extends StatelessWidget {
  String golonganDarah;
  String typeDarah;
  DetailStokDarah stokDarah;
  DetailStokDarahItem(
      String typeDarah, String golonganDarah, DetailStokDarah stokDarah) {
    this.golonganDarah = golonganDarah;
    this.typeDarah = typeDarah;
    this.stokDarah = stokDarah;
  }

  Widget _content() {
    if (golonganDarah == "A+") {
      return Card(
          elevation: 10.0,
          child: ListTile(
            title: Text(typeDarah),
            subtitle: Text(stokDarah.a_pos.toString()),
          ));
    }else if(golonganDarah == "B+"){
      return Card(
          elevation: 10.0,
          child: ListTile(
            title: Text(typeDarah),
            subtitle: Text(stokDarah.b_pos.toString()),
          ));
    }else if(golonganDarah == "AB+"){
      return Card(
          elevation: 10.0,
          child: ListTile(
            title: Text(typeDarah),
            subtitle: Text(stokDarah.ab_pos.toString()),
          ));
    }else if(golonganDarah == "O+"){
      return Card(
          elevation: 10.0,
          child: ListTile(
            title: Text(typeDarah),
            subtitle: Text(stokDarah.o_pos.toString()),
          ));
    }else if(golonganDarah == "A-"){
      return Card(
          elevation: 10.0,
          child: ListTile(
            title: Text(typeDarah),
            subtitle: Text(stokDarah.a_neg.toString()),
          ));
    }else if(golonganDarah == "B-"){
      return Card(
          elevation: 10.0,
          child: ListTile(
            title: Text(typeDarah),
            subtitle: Text(stokDarah.b_neg.toString()),
          ));
    }else if(golonganDarah == "AB-"){
      return Card(
          elevation: 10.0,
          child: ListTile(
            title: Text(typeDarah),
            subtitle: Text(stokDarah.ab_neg.toString()),
          ));
    }else if(golonganDarah == "O-"){
      return Card(
          elevation: 10.0,
          child: ListTile(
            title: Text(typeDarah),
            subtitle: Text(stokDarah.o_neg.toString()),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(stokDarah.golonganDarah);
    return _content();
  }
}
