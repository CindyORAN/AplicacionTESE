import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:tese_app/Widgets.dart';
import 'package:tese_app/connection/ImagesData.dart';

class Aspirante extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Aspirante> {
  List<ImagesData> list = List();

  @override
  void initState() {
    super.initState();
    _CargarOpciones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFB4B4B4),
      body: ListView(
        children: [
          Stack(
            alignment: const Alignment(0, 0),
            children: <Widget>[
              SizedBox(
                height: 150.0,
                width: 360.0,
                child: Carrusel(),
              ),
              Widgets().Title('Aspirantes'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 13,left: 15),
            child: Text(
              'Selecciona alguna de las siguientes opciones',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 400.0,
            width: 200.0,
            child: list.length == 0
                ? Widgets().Progress()
                : ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, index) {
                      return Widgets().buildFootItem(
                          list[index].titulo, list[index].imagen,context);
                    }),
          )
        ],
      ),
    );
  }

  void _CargarOpciones() {
    list.add(ImagesData(
        'https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/docente.jpg?alt=media&token=788cc245-b71a-4c7f-8112-c23689ca7e7f',
        'Carreras'));
    list.add(ImagesData(
        'https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/deportes.jpg?alt=media&token=7fb5c55d-a72d-480f-bc96-0e6d4221ab50',
        'Deportes'));
    list.add(ImagesData(
        'https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/inscripcion.png?alt=media&token=d922bc20-df05-481d-ac19-37a4bb985423',
        'Inscripciones'));
    list.add(ImagesData(
        'https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/instalaciones.png?alt=media&token=71118b56-c41c-445a-8d02-9855ab54b331',
        'Instalaciones'));
    list.add(ImagesData(
        'https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/cursos.png?alt=media&token=8bb130b7-7cfe-4f7b-8d66-960a61e8e198',
        'Propedeutico'));
  }

  Widget Carrusel() {
    return Carousel(
      images: [
        NetworkImage(
            'https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/tese%2Ftesepics_66213008_693710521068835_15641523461543570_n.jpg?alt=media&token=4c6dcbe2-eebe-487c-a846-1827c4487007'),
        NetworkImage(
            'https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/tese%2Finsta_tese_184174217_4054093154646745_1223029304452633103_n.jpg?alt=media&token=64e605fe-7832-4573-b53f-72138ca99661'),
        NetworkImage(
            'https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/tese%2Ftesepics_67838339_227113614923742_7866409185035403038_n.jpg?alt=media&token=14346851-e87d-49a3-be19-3b089a2205da'),
        NetworkImage(
            'https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/tese%2Ftesepics_80817404_512683962939827_8499907459152892619_n.jpg?alt=media&token=929c2245-63d3-4e06-9483-9e5901f446bb'),
        NetworkImage(
            'https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/tese%2Finsta_tese_96902452_538795173473664_8729865513200343702_n%20(1).jpg?alt=media&token=1dc28c8d-d595-4ceb-995b-401d8219974d'),
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
}
