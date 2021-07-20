import 'package:flutter/material.dart';
import 'package:tese_app/splash/inicio.dart';

void main() {
  runApp(Aplication());
}

class Aplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TESE',
        home: Inicio(),
        theme: ThemeData(
          primaryColor: Color(0xFF70232D),
          accentColor: Color(0xFF349E03),
        ));
  }
}
