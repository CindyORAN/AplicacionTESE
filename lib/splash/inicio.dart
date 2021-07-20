import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tese_app/navigation/home.dart';

class Inicio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StartState();
  }
}

class StartState extends State<Inicio> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = Duration(seconds: 7);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF70232D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset('animaciones/logo.png'),
              width: 120,
              height: 120,
            ),
            Padding(padding: EdgeInsets.only(top: 20)),
            Text(
              'Bienvenidos a la app del TESE',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            Padding(padding: EdgeInsets.only(top: 35.0)),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 1,
            )
          ],
        ),
      ),
    );
  }
}
