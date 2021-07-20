import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:shared_preferences/shared_preferences.dart';

class XookData extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              FutureBuilder<dynamic>(
                future: _setBody(),
                builder: (context, snapshot){
                  if (snapshot.hasData) {
                    return lookHtml(snapshot.data); //Text("${snapshot.data}");
                  } else {
                    //En caso de que no guarde información
                    return Text("Sin data");
                  }
                },
                initialData: Center(child: CircularProgressIndicator()),

              )
            ],
          ),
        ),
      ),
    );
  }

  Widget lookHtml(var snapshot){

    return HtmlWidget(
      // the first parameter (`html`) is required

      '''
      $snapshot
      ''',

      customStylesBuilder: (element) {

        if(element.id.contains("Table1")){
          return {'margin':'10px', 'text-align': 'center', 'border-collapse':'collapse', 'background-color': '#70232D'};
        }
        if(element.id.contains("tbAlumno")){
          return {'margin':'10px', 'font-size': '10px'};
        }
        if(element.text == "DATOS GENERALES "){
          return {'color': 'white', "text-align": "center", "font-weight": "bold", "font-size": "13px"};
        }
        if (element.text == "...:::Calificaciones:::..."){
          return {'font-size': '1px'};
        }
        if(element.text == "CALIFICACIONES "){
          return {'color': 'white', 'font-size': '13px', "font-weight": "bold"};
        }
        if(element.id.contains("dtgCalificaciones")){
          return {'margin':'10px', 'text-align': 'center', 'font-size': '6px', 'background-color': '#70232D'};
        }
        if(element.text == "PlanEstudio"){
          return {'color': 'white', 'font-size': '5.2px', "font-weight": "bold"};
        }
        if(element.text == "2doParcial"){
          return {'color': 'white', 'font-size': '5.2px', "font-weight": "bold"};
        }
        if(element.id.contains("dtgHorarios")){
          return {'margin':'10px', 'text-align': 'center', 'font-size': '6px', 'background-color': '#70232D'};
        }
        if(element.text == "HORARIOS"){
          return {'color': 'white', 'font-size': '13px', "font-weight": "bold"};
        }
        if(element.text == "Miercoles"){
          return {'color': 'white', 'font-size': '5.3px', "font-weight": "bold"};
        }

        return {'color': 'white'};
      },

      // set the default styling for text


      // turn on `webView` if you need IFRAME support
      webView: true,
    );
  }

  Future<dynamic> _setBody() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('body') ?? '';
  }
}