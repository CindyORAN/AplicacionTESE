import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tese_app/alumno/alumno.dart';
import 'XookData.dart';


class RestorePassword extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<RestorePassword> {

  bool signin = true;

  TextEditingController password, passwordConfirm;
  bool processing = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    password = new TextEditingController();
    passwordConfirm = new TextEditingController();

  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Icon(Icons.vpn_key_outlined,size: 150,color: Colors.blue,),
            boxUi(),
          ],
        )
    ),
    );
  }

  void changeState(){
    if(signin){
      setState(() {
        signin = true;

      });
    }else
      setState(() {
        signin = true;

      });
  }

  getCadena() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('dataXook') ?? "";
  }

  void userSignIn() async{
    setState(() {
      processing = true;
    });

    getUser() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('matricula') ?? "";
    }

    getPasswrod() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('password') ?? "";
    }

    eliminarShared() async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("matricula");
      prefs.remove("password");
      prefs.remove("dataXook");
    }

    if(password.text == passwordConfirm.text){

      Uri url = Uri.parse("https://teseapi.000webhostapp.com/php/api.php");

      var data = {"matricula": await getUser(), "pass": await getPasswrod(), "xook": await getCadena(), "passRestore": password.text, "passConfirm": passwordConfirm.text};

      var res = await http.post(url,body:data);

      if(res.body == 'Password: Success'){

        //Mostramos mensaje de error
        Fluttertoast.showToast(
            msg: "Contraseña Cambiada Con Exito",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );

        eliminarShared();

        //Redireccionar al inicio
        final route = MaterialPageRoute(builder: (context)=> Inicio());
        Navigator.pushReplacement(context, route);

      } else {
        var pendejo = res.body;

        print(pendejo);
        //Mostramos mensaje de error
        Fluttertoast.showToast(
            msg: "Error: contacta con el admin",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

      }

    }
    else {
      password.clear();
      passwordConfirm.clear();
      //Mostramos mensaje de error
      Fluttertoast.showToast(
          msg: "Las contraseñas no coinciden",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }

    setState(() {
      processing = false;
    });
  }

  Widget boxUi(){
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                FlatButton(
                  onPressed:() => changeState(),
                  child: Text('CAMBIAR CONTRASEÑA',
                    style: GoogleFonts.varelaRound(
                      color: signin == true ? Colors.blue : Colors.grey,
                      fontSize: 18,fontWeight: FontWeight.bold,
                    ),),
                ),

              ],
            ),

            signin == true ? signInUi() : signUpUi(),

          ],
        ),
      ),
    );
  }

  Widget signInUi(){
    return Column(
      children: <Widget>[

        TextField(
          controller: password,
          obscureText: false,
          decoration: InputDecoration(prefixIcon: Icon(Icons.lock,),
              hintText: 'Contraseña'),
        ),

        TextField(
          controller: passwordConfirm,
          obscureText: true,
          decoration: InputDecoration(prefixIcon: Icon(Icons.lock,),
              hintText: 'Confirma Contraseña'),
        ),

        SizedBox(height: 10.0,),

        MaterialButton(
            onPressed:() => userSignIn(), //userSignIn(),
            child: processing == false ? Text('CAMBIAR CONTRASEÑA',
              style: GoogleFonts.varelaRound(fontSize: 18.0,
                  color: Colors.blue),) : CircularProgressIndicator(backgroundColor: Colors.green,)
        ),

      ],
    );
  }

  Widget signUpUi(){
    return Column(
      children: <Widget>[

        TextField(
          controller: password,
          decoration: InputDecoration(prefixIcon: Icon(Icons.account_box,),
              hintText: 'Contraseña'),
        ),

        TextField(
          controller: passwordConfirm,
          decoration: InputDecoration(prefixIcon: Icon(Icons.lock,),
              hintText: 'Confirmar Contraseña'),
        ),

        SizedBox(height: 10.0,),

      ],
    );
  }


//thank you
}