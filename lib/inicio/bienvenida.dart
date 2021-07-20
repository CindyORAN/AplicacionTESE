import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tese_app/Widgets.dart';
import 'package:tese_app/connection/Data.dart';
import 'package:tese_app/connection/ImagesData.dart';
import 'package:tese_app/connection/Words.dart';

class Bienvenida extends StatefulWidget {
  @override
  _BienvenidaState createState() => _BienvenidaState();
}

class _BienvenidaState extends State<Bienvenida> {
  final fb = FirebaseDatabase.instance.reference();
  List<Data> list = List();
  List<ImagesData> listImages = List();

  @override
  void initState() {
    super.initState();
    _ConexionImages("Inicio", "Tese");
    _ConexionNovedad("Inicio", "Novedades");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        listImages.length == 0
            ? Widgets().Progress()
            : Stack(alignment: const Alignment(0, 0), children: <Widget>[
              CarrouselWidget(),
                Widgets().Title('Inicio'),
              ]),
        Divider(
          height: 25,
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

  Widget CarrouselWidget(){
   return SizedBox(
        height: 150.0,
        width: 360.0,
        child: CarouselSlider.builder(
            itemCount: listImages.length,
            itemBuilder: (_, x, index) {
              return Widgets().ImageCarousel(listImages[x].imagen);
            },
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1,
              aspectRatio: 0.7,
              enableInfiniteScroll: true,
              disableCenter: true,
              enlargeCenterPage: true,
              initialPage: 1,
            )));
  }


  void _ConexionNovedad(String NodoPrincipal, String NodoSecundario) {
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

  void _ConexionImages(String NodoPrincipal, String NodoSecundario) {
    fb
        .child(NodoPrincipal)
        .child(NodoSecundario)
        .once()
        .then((DataSnapshot snap) {
      var data = snap.value;
      listImages.clear();
      data.forEach((key, value) {
        ImagesData data = new ImagesData(
          value[Words().IMAGEN],
          value[Words().TITULO],
        );
        listImages.add(data);
      });
      setState(() {});
    });
  }
}
