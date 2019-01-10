import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';

import './login_screen.dart';
import 'package:blood/models/user_model.dart';
import 'package:blood/screens/widgets/common_divided_widget.dart';
import 'package:blood/main.dart';

import 'package:blood/data.dart' as data;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ProfileScreen extends StatefulWidget {
  String level;
  ProfileScreen(this.level);
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel userModel = new UserModel();
  String uid;
  // Firebase messaging
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final mainReference = FirebaseDatabase.instance.reference();

  final nameController = TextEditingController();
  final addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUser();
    _initPlatformState();
  }

  void getUser() async {
    FirebaseUser user = await _auth.currentUser();
    String token = await _firebaseMessaging.getToken();
    setState(() {
      userModel.fcmToken = token;
      this.uid = user.uid;
      if (widget.level == "Register") {
        this.userModel.uid = user.uid;
        this.userModel.phoneNumber = user.phoneNumber;
      }
    });

    print(uid);
  }
  // Platform messages are asynchronous, so we initialize in an async method.
  void _initPlatformState() async {
    Position position;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      // Geolocator geolocator = Geolocator()..forceAndroidLocationManager = true;
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print("position");
    } on Exception {
      print("object");
      position = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      userModel.lat = position.latitude;
      userModel.lon = position.longitude;
    });
  }

  // Profile
  Widget golDarah(String goldar) => Container(
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Text(
            goldar,
            style: TextStyle(
              color: Colors.red,
              fontSize: 50.0,
            ),
            textAlign: TextAlign.center,
          ),
          Text("Golongan Darah")
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0)));
  Future<UserModel> fecthData() async {
    FirebaseUser user = await _auth.currentUser();
    DataSnapshot snapshot =
        await mainReference.child("user").child(user.uid).once();
    UserModel model = UserModel.fromSnapshot(snapshot.value);
    if(userModel.name == null){
      this.userModel = model;
    }
    return model;
  }

  Widget profileContent() => new FutureBuilder<UserModel>(
        future: fecthData(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            nameController.text = userModel.name;
            addressController.text = userModel.address;
            return new Column(
              children: <Widget>[
                golDarah(userModel.bloodType),
                CommonDivider(),
                SizedBox(
                  height: 5.0,
                ),
                identityForm(),
                CommonDivider(),
                SizedBox(
                  height: 5.0,
                ),
                listDarahChoice(),
              ],
            );
          } else {
            return new Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
  // Register
  Widget registerContent() => new Column(
        children: <Widget>[
          identityForm(),
          CommonDivider(),
          SizedBox(
            height: 5.0,
          ),
          listDarahChoice(),
        ],
      );
  // Widget
  Widget listDarahChoice() => new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Blood type",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: data.listDarah
                .map((pc) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ChoiceChip(
                        selectedColor: Colors.yellow,
                        label: Text(
                          pc,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        selected: userModel.bloodType == pc,
                        onSelected: (selected) {
                          setState(() {
                            userModel.bloodType = selected ? pc : null;
                          });
                        },
                      ),
                    ))
                .toList(),
          ),
        ],
      );
  Widget identityForm() => new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Identity",
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          TextField(
            controller: nameController,
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.black),
            onChanged: (out) => userModel.name = out,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              labelText: "Name",
            ),
          ),
          TextField(
            controller: addressController,
            decoration: InputDecoration(
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              labelText: "Address",
            ),
            onChanged: (out) => userModel.address = out,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
          )
        ],
      );

  // Content

  Widget content() => Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            widget.level == "Register" ? registerContent() : profileContent(),
            processButton()
          ],
        ),
      );
  Widget processButton() => new Expanded(
        flex: 1,
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              height: 50.0,
              child: new RaisedButton(
                color: widget.level == "Register" ? Colors.blue : Colors.green,
                child: Text(
                  widget.level == "Register" ? "Register" : "Edit",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: widget.level == "Register"
                    ? () => registerData()
                    : () => editData(),
              ),
            ),
          ),
        ),
      );
  void tampilDialog(String tittle, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(tittle),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                if (tittle == "Alert") {
                  Navigator.of(context).pop();
                } else {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MyApp()));
                }
              },
            ),
          ],
        );
      },
    );
  }

  bool validateForm() {
    if (userModel.uid == null ||
        userModel.name == null ||
        userModel.phoneNumber == null ||
        userModel.bloodType == null ||
        userModel.address == null) {
      return false;
    }
    return true;
  }

  void registerData() {
    if (validateForm()) {
      mainReference
          .child("user")
          .child(userModel.uid)
          .set(userModel.toJson())
          .then((value) {
        tampilDialog("Success", "Success Input Data");
      }).catchError((onError) => tampilDialog("Alert", onError));
    } else {
      tampilDialog("Alert", "Sorry data is incomplete");
    }
  }

  void editData() {
    // print(userModel.toJson());
    if (validateForm()) {
      mainReference
          .child("user")
          .child(userModel.uid)
          .set(userModel.toJson())
          .then((value) {
        tampilDialog("Success", "Success Input Data");
      }).catchError((onError) => tampilDialog("Alert", onError));
    } else {
      tampilDialog("Alert", "Sorry data is incomplete");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            widget.level,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: new Center(
            child: Container(
                margin: EdgeInsets.all(10.0),
                width: double.infinity,
                child: Card(
                  child: content(),
                )),
          ),);
  }
}
