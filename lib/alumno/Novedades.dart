import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tese_app/connection/Data.dart';
import 'package:tese_app/connection/Words.dart';
import 'package:tese_app/inicio/Details.dart';

import '../Widgets.dart';

class Novedades extends StatefulWidget {
  Novedades({Key key}) : super(key: key);

  @override
  _NovedadesState createState() {
    return _NovedadesState();
  }
}

class _NovedadesState extends State<Novedades> {
  final fb = FirebaseDatabase.instance.reference();
  List<Data> list = List();
  @override
  void initState() {
    super.initState();
    ConexionNovedad("alumnos", "Noticias");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
    SizedBox(
    height: 400.0,
    width: 200.0,
    child: list.length == 0
    ? Text("Cargando...", style: TextStyle(fontSize: 16, color: Color(
        0xffb1acac),),)
        : new ListView.builder(
    itemCount: list.length,
    itemBuilder: (_, index) {
    return Widgets().UI(
    list[index].Descripcion,
    list[index].fecha,
    list[index].imagen,
    list[index].subtitulo,
    list[index].titulo,
    context);
    }))
    ]);
  }


  void ConexionNovedad(String NodoPrincipal, String NodoSecundario) {
    fb
        .child(NodoPrincipal)
        .child(NodoSecundario)
        .once()
        .then((DataSnapshot snap) {
      var data = snap.value;
      list.clear();
      data.forEach((key, value) {
        Data data = new Data(
          value[Words().DESCRIPTION],
          value[Words().DATE],
          value[Words().IAMGE],
          value[Words().SUBTITLE],
          value[Words().TITLE],
        );
        list.add(data);
      });
      setState(() {});
    });
  }


}