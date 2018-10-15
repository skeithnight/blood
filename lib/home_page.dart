import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static String tag = 'home-page';

  @override
  Widget build(BuildContext context) {
    final alucard = Hero(
      tag: 'Hero',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: CircleAvatar(
          radius: 72.0,
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage('assets/john-davitsky.jpg'),
        ),
      ),
    );
    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Welcome to Blood',
        style: TextStyle(fontSize: 28.0, color: Colors.white),
      ),
    );
    final lorem = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'lLorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam tincidunt turpis et congue luctus. In fringilla id mi eget luctus. Suspendisse consequat nibh sed ipsum aliquam iaculis. Nullam pretium a justo sit amet posuere. Curabitur vitae mattis sem. Fusce rutrum consequat leo, fermentum vulputate quam ullamcorper vitae. Aliquam interdum nulla in euismod lacinia. Pellentesque malesuada lorem quam, a tristique eros fermentum vitae. Aenean imperdiet nunc eget urna euismod, at tincidunt sapien commodo.',
        style: TextStyle(fontSize: 28.0, color: Colors.white),
      ),
    );
    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.lightBlueAccent],
        ),
      ),
      child: Column(children: <Widget> [alucard,welcome,lorem]),
    );
    return Scaffold(
      body: body,
    );
  }
}
