import 'package:flutter/material.dart';
import 'package:tese_app/connection/Data.dart';


class DetailsPropedeutico extends StatelessWidget {

  Data data;
  DetailsPropedeutico(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.network(
              data.imagen,
              width: 200,
              fit: BoxFit.cover,
              height: 180,
              alignment: Alignment.center
          ),Divider(height: 10,),
          titleSection(data.titulo,data.subtitulo),
          DetaiText(data.Descripcion),

          Container(
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(
                  color: Colors.grey.withOpacity(0.5), //color of shadow
                  spreadRadius: 5, //spread radius
                  blurRadius: 7, // blur radius
                  offset: Offset(0, 2), // changes position of shadow
                ),
                ]
            ),
            margin: EdgeInsets.all(25),
            child: Text(data.fecha,
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: "PlayfairDisplay"
              ),),
          )
        ],
      ),
    );
  }

  Widget DetaiText(String detalles){
    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        detalles,
        softWrap: true,
        style:  TextStyle(fontFamily: "OpenSansCondensed", fontSize: 15),
      ),
    );
    return textSection;
  }
  Widget titleSection(String titulo, String subtitulo){
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    titulo,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  subtitulo,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );}

}
