import 'package:flutter/material.dart';
import './login_screen.dart';

class ProfileScreen extends StatelessWidget {
  Widget fotoProfile() => Center(
        child: new Container(
          margin: EdgeInsets.all(10.0),
          width: 100.0,
          height: 100.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
            image: new DecorationImage(
              fit: BoxFit.fill,
              image: new NetworkImage(
                  "https://www.caldwellsecurities.com/images/default-source/default-album/john-davitskycc68baba6d596b9a885bff0000bcd1e6.jpg?sfvrsn=5e31d1c6_0"),
            ),
          ),
        ),
      );
  Widget golDarah() => Container(
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Text(
            "A+",
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
  Widget editButton() => new Expanded(
        flex: 1,
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              height: 50.0,
              child: new RaisedButton(
                color: Colors.green,
                child: Text(
                  "Edit",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              ),
            ),
          ),
        ),
      );
  Widget profileContent() => Container(
        width: double.infinity,
        height: 200.0,
        margin: EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity,
                child: golDarah(),
              ),
              flex: 1,
            ),
            Expanded(
              child: Text("data"),
              flex: 1,
            ),
            editButton()
          ],
        ),
      );

  Widget logout(context) => new Expanded(
        flex: 1,
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: SizedBox(
              width: double.infinity,
              height: 50.0,
              child: new RaisedButton(
                color: Colors.pink,
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
            ),
          ),
        ),
      );
  Widget profile() => new Expanded(
        flex: 8,
        child: Center(
          child: Container(
            height: 500.0,
            width: double.infinity,
            child: Center(
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(height: 50.0),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.lightBlue,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10.0,
                                offset: Offset(0.0, 10.0))
                          ],
                        ),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(30.0, 80.0, 30.0, 0.0),
                          width: double.infinity,
                          height: 400.0,
                          child: profileContent(),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Center(
                        child: new Container(
                          width: 100.0,
                          height: 100.0,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new NetworkImage(
                                  "https://www.caldwellsecurities.com/images/default-source/default-album/john-davitskycc68baba6d596b9a885bff0000bcd1e6.jpg?sfvrsn=5e31d1c6_0"),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );

  Widget content(context) => Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[profile(), logout(context)],
      );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Profile"),
      ),
      body: content(context),
    );
  }
}

// child: Container(
//             child: Stack(children: <Widget>[
//               Column(
//                 children: <Widget>[
//                   DecoratedBox(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20.0),
//                       color: Colors.white,
//                     ),
//                     child: Container(
//                       width: 300.0,
//                       height: 400.0,
//                     ),
//                   ),
//                 ],
//               ),
//               Column(
//                 children: <Widget>[
//                   Center(
//                     child: new Container(
//                       width: 100.0,
//                       height: 100.0,
//                       decoration: new BoxDecoration(
//                         shape: BoxShape.circle,
//                         image: new DecorationImage(
//                           fit: BoxFit.fill,
//                           image: new NetworkImage(
//                               "https://www.caldwellsecurities.com/images/default-source/default-album/john-davitskycc68baba6d596b9a885bff0000bcd1e6.jpg?sfvrsn=5e31d1c6_0"),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               )
//             ]),
//           ),
