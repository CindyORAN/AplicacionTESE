import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tese_app/connection/Data.dart';
import 'package:tese_app/connection/Words.dart';

import 'detailsNovedades.dart';


class Novedades extends StatefulWidget {
  final heroTag;
  final raceName;

  Novedades({this.heroTag, this.raceName});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Novedades> {
  final fb = FirebaseDatabase.instance.reference();
  List<Data> list = List();

  @override
  void initState() {
    super.initState();
    ConexionCarreras("Docentes", "Novedades");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF70232D),
      ),
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: ListView(children: [
            Stack(alignment: const Alignment(0, 0), children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.black45,
                ),
                child: Text(
                  'Novedades',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ]),
            Divider(
              height: 25,
            ),
            SizedBox(
                height: 400.0,
                width: 200.0,
                child: list.length == 0
                    ? Text("Cargando...")
                    : new ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, index) {
                      return UI(
                          list[index].Descripcion,
                          list[index].fecha,
                          list[index].imagen,
                          list[index].subtitulo,
                          list[index].titulo);
                    }))
          ]),
        ),
      ),
    );
  }

  Widget UI(String descripcion, String fecha, String imagen, String subtitulo,
      String titulo) {
    return GestureDetector(
      onTap: () {},
      child: new Card(
          margin:
          EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 20.0),
          elevation: 15,
          child: new Column(
            children: <Widget>[
              new ListTile(
                leading: new Image.network(
                  imagen,
                  fit: BoxFit.cover,
                  width: 100.0,
                ),
                title: new Text(
                  titulo,
                  style: new TextStyle(
                      fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
                subtitle: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(subtitulo,
                          style: new TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.normal)),
                    ]),
                //trailing: ,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailsNovedades(Data(
                          descripcion, fecha, imagen, subtitulo, titulo))));
                },
              )
            ],
          )),
    );
  }

  void ConexionCarreras(String NodoPrincipal, String NodoSecundario) {
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
