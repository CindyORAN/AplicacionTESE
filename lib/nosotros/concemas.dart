import 'package:carousel_pro/carousel_pro.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tese_app/Widgets.dart';
import 'package:tese_app/connection/Data.dart';
import 'package:tese_app/connection/ImagesData.dart';
import 'package:tese_app/connection/Words.dart';


class ConceMas extends StatefulWidget {
  @override
  _BienvenidaState createState() => _BienvenidaState();
}

class _BienvenidaState extends State<ConceMas> {
  final fb = FirebaseDatabase.instance.reference();
  List<Data> list = List();
  List<ImagesData> listImages = List();

  @override
  void initState() {
    super.initState();
    ConexionNovedad("Conoce", "Informacion");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Stack(alignment: const Alignment(0, 0), children: <Widget>[
          SizedBox(
            height: 150.0,
            width: 360.0,
            child: Carrusel(),
          ),
          Widgets().Title('Nosotros')
        ]),
        Divider(
          height: 30,
        ),
        SizedBox(
            height: 400.0,
            width: 200.0,
            child: list.length == 0
                ? Widgets().Progress()
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
      ]),
    );
  }

  

  Widget Carrusel() {
    return Carousel(
      images: [
        NetworkImage(
            'https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/tese%2Ftesepics_70335491_141527077122249_8326548529380950727_n.jpg?alt=media&token=a4a5db53-d164-42af-bc6e-aead398e61c0'),
        NetworkImage(
            'https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/tese%2Finsta_tese_43778375_1865238960219454_3003227947128038243_n.jpg?alt=media&token=314f5aef-a5b8-4c2a-99e6-7a3448e3884d'),
        NetworkImage(
            'https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/tese%2Ftesepics_71116541_865235730537689_2935188316331782456_n.jpg?alt=media&token=deb0b88d-5e9e-492e-b59d-1796695d7403'),
        NetworkImage(
            'https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/tese%2Ftesepics_66236182_368001160565526_3984091680599857593_n.jpg?alt=media&token=4b88a12a-5c92-4dbc-809d-2830c13ca4e5'),
        NetworkImage(
            'https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/tese%2Ftesepics_66340107_373391766658789_3889978318667249151_n.jpg?alt=media&token=05624cba-1d21-4163-924d-ecd6e367aadb'),
      ],
      showIndicator: false,
      borderRadius: false,
      moveIndicatorFromBottom: 180.0,
      noRadiusForIndicator: true,
      overlayShadow: true,
      overlayShadowColors: Colors.white,
      overlayShadowSize: 0.7,
    );
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
