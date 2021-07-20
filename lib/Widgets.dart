import 'package:flutter/material.dart';
import 'docentes/cursos/cursos.dart';
import 'docentes/novedades/Novedades.dart';
import 'apirantes/Carreras/carreras.dart';
import 'apirantes/Deportes/deportes.dart';
import 'apirantes/Inscripciones/inscripciones.dart';
import 'apirantes/Instalaciones/instalaciones.dart';
import 'apirantes/Propedeutico/propedeutico.dart';
import 'connection/Data.dart';
import 'inicio/Details.dart';

class Widgets {
  Widget Title(String title) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.7), //color of shadow
          spreadRadius: 6, //spread radius
          blurRadius: 8, // blur radius
          offset: Offset(0, 2), //  changes position of shadow
        )
      ]),
      margin: EdgeInsets.only(right: 190, top: 100.0),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget UI(String descripcion, String fecha, String imagen, String subtitulo,
      String titulo, BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: new Card(
          margin:
              EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0, bottom: 10.0),
          elevation: 15,
          child: new Column(
            children: <Widget>[
              new ListTile(
                leading: _CargarImagen(imagen),
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
                      builder: (context) => Details(Data(
                          descripcion, fecha, imagen, subtitulo, titulo))));
                },
              )
            ],
          )),
    );
  }

  Image _CargarImagen(String imagen) {
    return new Image.network(imagen, fit: BoxFit.cover, width: 100.0,
        frameBuilder: (BuildContext context, Widget child, int frame,
            bool wasSynchronouslyLoaded) {
      if (wasSynchronouslyLoaded) {
        return child;
      }
      return AnimatedOpacity(
        child: child,
        opacity: frame == null ? 0 : 1,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    });
  }

  Widget Progress() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircularProgressIndicator(
            backgroundColor: Colors.white, strokeWidth: 1, value: null)
      ],
    );
  }

  Widget ImageCarousel(String imagen) {
    return Container(
        child: Image(
      alignment: Alignment.center,
      fit: BoxFit.fill,
      frameBuilder: (BuildContext context, Widget child, int frame,
          bool wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return child;
        }
        return AnimatedOpacity(
          child: child,
          opacity: frame == null ? 0 : 1,
          duration: const Duration(seconds: 1),
          curve: Curves.easeOut,
        );
      },
      image: NetworkImage(imagen),
    ));
  }

  Widget buildFootItem(String titulo, String imagen, BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: InkWell(
            onTap: () {
              switch (titulo) {
                case 'Carreras':
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          Carreras(heroTag: imagen, raceName: titulo)));
                  break;
                case 'Deportes':
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          Deportes(heroTag: imagen, raceName: titulo)));
                  break;
                case 'Inscripciones':
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          Inscripciones(heroTag: imagen, raceName: titulo)));
                  break;
                case 'Instalaciones':
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          Instalaciones(heroTag: imagen, raceName: titulo)));
                  break;
                case 'Propedeutico':
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          Propedeutico(heroTag: imagen, raceName: titulo)));
                  break;
                case 'Novedades':
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          Novedades(heroTag: imagen, raceName: titulo)));
                  break;
                case 'Cursos':
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          Cursos(heroTag: imagen, raceName: titulo)));
                  break;
                default:
                  print(titulo);
                  break;
              }
            },
            child: Column(
              children: [
                Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          child: Row(children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Hero(
                              tag: imagen,
                              child: Image(
                                  image: NetworkImage(imagen),
                                  fit: BoxFit.cover,
                                  height: 60.0,
                                  width: 60.0)),
                        ),
                        SizedBox(
                          width: 10.0,
                          height: 70,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(titulo,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold)),
                              Text("Conoce Más",
                                  overflow: TextOverflow.fade,
                                  maxLines: 10,
                                  softWrap: false,
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 15.0,
                                      color: Colors.black))
                            ])
                      ])),
                    ],
                  ),
                ),
              ],
            )));
  }
}
