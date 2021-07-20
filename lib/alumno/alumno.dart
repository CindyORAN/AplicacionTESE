import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tese_app/Widgets.dart';
import 'package:tese_app/alumno/Novedades.dart';
import 'Login.dart';

class Alumno extends StatefulWidget {
  @override
  _AlumnoState createState() => _AlumnoState();
}

class _AlumnoState extends State<Alumno> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ALUMNO',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        routes: <String, WidgetBuilder>{
          "/xook": (BuildContext context) => Xook(),
          "/calificaciones": (BuildContext context) => Login(),
          "/passwordRestore": (BuildContext context) => Login(),
          "/horario": (BuildContext context) => Login(),
        },
        home: Inicio());
  }
}

class Xook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 0, right: 5, left: 5),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: MaterialButton(
                      color: Colors.white,
                      shape: new RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      highlightColor: Colors.red.shade300,
                      onPressed: () {
                        Navigator.pushNamed(context, "/calificaciones");
                        setCadena("calificacion");
                        getCadena().then((value) => print(value));
                      },
                      child: SizedBox(
                          width: 120,
                          height: 120,
                          child: Center(
                            child: Column(
                              children: [
                                Container(
                                    width: 90.0,
                                    height: 90.0,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/calificaciones.png?alt=media&token=0ad5bd9a-19ac-4456-8d18-a01ce418db5b"),
                                            alignment: Alignment.topCenter))),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    'CALIFICACIONES',
                                    style: TextStyle(fontSize: 13),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ))),
                ),

                //HACIA ABAJO
              ]),

              // DE LADO DERECHO
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: MaterialButton(
                        color: Colors.white,
                        shape: new RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        highlightColor: Colors.red.shade300,
                        onPressed: () {
                          Navigator.pushNamed(context, "/horario");
                          setCadena("horario");
                        },
                        child: SizedBox(
                            width: 120,
                            height: 120,
                            child: Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 10, top: 5),
                                    child: Container(
                                        width: 70.0,
                                        height: 80.0,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    "https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/horario.png?alt=media&token=dadf1a5e-46db-475c-9807-c3236191c1b1"),
                                                alignment:
                                                    Alignment.topCenter))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: Text(
                                      'HORARIO',
                                      style: TextStyle(fontSize: 12),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ))),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: MaterialButton(
                color: Colors.white,
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                highlightColor: Colors.red.shade300,
                onPressed: () {
                  Navigator.pushNamed(context, "/passwordRestore");
                  setCadena("restore");
                },
                child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                                width: 75.0,
                                height: 75.0,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/restore.png?alt=media&token=c7a37ecd-acf5-42c5-bddb-e81e8bb78ffa"),
                                        alignment: Alignment.topCenter))),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Text(
                              'RESTABLECER CONTRASEÑA',
                              style: TextStyle(fontSize: 11),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ))),
          ),
        ],
      ),
    );
  }
}

getCadena() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('dataXook') ?? "";
}

setCadena(String _cadena) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('dataXook', _cadena);
}

//Clase principal
class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          _ImgenCabecera(),
          Container(
              child: Column(children: <Widget>[
            Container(
              child: _getTabBar(),
              color: Color(0xFF70232D),
            ),
            Container(
              height: 450,
              child: _getTabBarView(<Widget>[Novedades(), Xook()]),
            )
          ]))
        ],
      )),
    );
  }

  Widget _ImgenCabecera() {
    return Stack(alignment: const Alignment(0, 0), children: <Widget>[
      Image(
        height: 185,
        width: 365,
        alignment: Alignment.center,
        fit: BoxFit.fill,
        image: NetworkImage(
            "https://firebasestorage.googleapis.com/v0/b/app-tese.appspot.com/o/tese%2Ftesepics_67509949_248264832723576_6279915397766464018_n.jpg?alt=media&token=4b625551-19d0-40b2-a187-fbcbf18f4ce4"),
      ),
      Widgets().Title('Alumno')
    ]);
  }

  TabBar _getTabBar() {
    return TabBar(
      tabs: <Tab>[Tab(text: "Noticias"), Tab(text: "XOOK")],
      controller: _tabController,
      unselectedLabelColor: const Color(0xffb7c1c7),
      indicatorColor: Color(0xFFffac81),
      labelColor: Colors.white,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 3.0,
      indicatorPadding: EdgeInsets.all(10),
      isScrollable: false,
    );
  }

  TabBarView _getTabBarView(var display) {
    return TabBarView(
      children: display,
      controller: _tabController,
    );
  }
}
