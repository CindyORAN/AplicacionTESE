import 'package:flutter/material.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:tese_app/alumno/alumno.dart';
import 'package:tese_app/apirantes/aspirante.dart';
import 'package:tese_app/docentes/docente.dart';
import 'package:tese_app/inicio/bienvenida.dart';
import 'package:tese_app/nosotros/concemas.dart';

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF70232D),
      ),
      routes: <String, WidgetBuilder>{
        "/bienvenida": (BuildContext context) => Bienvenida(),
        "/Aspirante": (BuildContext context) => Aspirante(),
        "/Alumno": (BuildContext context) => Alumno(),
        "/Docente": (BuildContext context) => Docente(),
        "/conocemas": (BuildContext context) => ConceMas(),
      },
      home: MyHomePage(title: 'Bienvenido a la APP Del tese'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  List<Widget> _paginas = [
    Bienvenida(),
    Alumno(),
    Aspirante(),
    Docente(),
    ConceMas(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _paginas[selectedIndex],
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBorderColor: Colors.transparent,
          selectedItemBackgroundColor: Colors.green,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.black,
          showSelectedItemShadow: false,
          barHeight: 55,
        ),
        selectedIndex: selectedIndex,
        onSelectTab: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          FFNavigationBarItem(
            iconData: Icons.house,
            label: 'Inicio',
          ),
          FFNavigationBarItem(
            iconData: Icons.people,
            label: 'Alumno',
            selectedBackgroundColor: Colors.orange,
          ),
          FFNavigationBarItem(
            iconData: Icons.emoji_people_outlined,
            label: 'Aspirantes',
            selectedBackgroundColor: Colors.purple,
          ),
          FFNavigationBarItem(
            iconData: Icons.account_circle_outlined,
            label: 'Docente',
            selectedBackgroundColor: Colors.blue,
          ),
          FFNavigationBarItem(
            iconData: Icons.settings,
            label: 'Nosotros',
            selectedBackgroundColor: Colors.red,
          ),
        ],
      ),
    );
  }

  //TODO no tocar >:(
  Nested(){
    return NestedScrollView(headerSliverBuilder: (BuildContext context, bool inerboxIsScrolled){
      return <Widget>[
        SliverAppBar(

            expandedHeight: 200,
            floating: false,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(widget.title,style: TextStyle(color: Colors.white,fontSize: 16),),
            )
        )

      ];
    }, body: _paginas[selectedIndex],
    );
  }
}
