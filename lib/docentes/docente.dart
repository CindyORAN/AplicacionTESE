import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:tese_app/connection/ImagesData.dart';
import '../Widgets.dart';

class Docente extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Docente> {
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
              Widgets().Title('Docentes'),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 13,left: 15),
            child: Text('Selecciona alguna de las siguientes opciones', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),
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
          ),
        ],
      ),
    );
  }

  void _CargarOpciones() {
    list.add(ImagesData(
        'https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/novedades.jpg?alt=media&token=1c11da55-a368-4c3e-a097-b446153c3da5',
        'Novedades'));
    list.add(ImagesData(
        'https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/cursos1.jpg?alt=media&token=4a120b21-5315-43e6-b97f-532fe084813e',
        'Cursos'));

  }

  Widget Carrusel() {
    return Carousel(
      images: [
        NetworkImage(
            'https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/tese%2F6554bb61-1f1c-4981-b0e8-e35c22631410.jpg?alt=media&token=18761c79-a900-45cd-9eb0-c8406c99d639'),
        NetworkImage(
            'https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/tese%2F932a9476-0973-4d8c-a3a5-77c90cb8bd71.jpg?alt=media&token=59edd8e5-10dc-467d-8969-6ee2c71bd68d'),
        NetworkImage(
            'https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/tese%2FWhatsApp%20Image%202021-06-10%20at%203.06.20%20PM.jpeg?alt=media&token=4e052188-e7a3-4f45-bf8c-3265cb8be426'),
        NetworkImage(
            'https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/tese%2FWhatsApp%20Image%202021-06-10%20at%203.16.44%20PM.jpeg?alt=media&token=49c32107-2b36-4236-abdf-5520bef30067'),
        NetworkImage(
            'https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/tese%2FWhatsApp%20Image%202021-06-10%20at%203.20.03%20PM.jpeg?alt=media&token=4fe8bc6f-7d65-4869-86ba-131bb56d1f58'),
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
