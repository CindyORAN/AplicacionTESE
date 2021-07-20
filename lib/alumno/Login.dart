import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'XookData.dart';

class Login extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Login> {
  bool signin = true;

  TextEditingController matriculactrl, passctrl;
  bool processing = false;

  @override
  void initState() {
    super.initState();
    matriculactrl = new TextEditingController();
    passctrl = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.account_circle,
                size: 200,
                color: Colors.blue,
              ),
              boxUi(),
            ],
          )),
    );
  }

  void changeState() {
    if (signin) {
      setState(() {
        signin = true;
      });
    } else
      setState(() {
        signin = true;
      });
  }

  getCadena() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('dataXook') ?? "";
  }

  void userSignIn() async {
    setState(() {
      processing = true;
    });

    Uri url = Uri.parse("https://9853efa029e0.ngrok.io/xook/php/enviar.php");

    var data = {
      "matricula": matriculactrl.text,
      "pass": passctrl.text,
      "xook": await getCadena()
    };

    var res = await http.post(url, body: data);

    if (res.body == "Error: Pass") {
      //Borramos los campos
      passctrl.clear();
      matriculactrl.clear();
      //Mostramos mensaje de error
      Fluttertoast.showToast(
          msg: "Matricula o Contraseña Incorrecta",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (res.body == "Error: Method") {
      //Mostramos mensaje de error
      Fluttertoast.showToast(
          msg: "Campos Vacios...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      _saveBody(res.body);
    }

    setState(() {
      processing = false;
    });
  }

  Widget boxUi() {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  onPressed: () => changeState(),
                  child: Text(
                    'INICIAR SESIÓN',
                    style: GoogleFonts.varelaRound(
                      color: signin == true ? Colors.blue : Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            signin == true ? signInUi() : signUpUi(),
          ],
        ),
      ),
    );
  }

  Widget signInUi() {
    return Column(
      children: <Widget>[
        TextField(
          controller: matriculactrl,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_box,
              ),
              hintText: 'Matricula'),
        ),
        TextField(
          controller: passctrl,
          obscureText: true,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
              ),
              hintText: 'Contraseña'),
        ),
        SizedBox(
          height: 10.0,
        ),
        MaterialButton(
            onPressed: () => userSignIn(), //userSignIn(),
            child: processing == false
                ? Text(
                    'ENTRAR',
                    style: GoogleFonts.varelaRound(
                        fontSize: 18.0, color: Colors.blue),
                  )
                : CircularProgressIndicator(
                    backgroundColor: Colors.green,
                  )),
      ],
    );
  }

  Widget signUpUi() {
    return Column(
      children: <Widget>[
        TextField(
          controller: matriculactrl,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_box,
              ),
              hintText: 'email'),
        ),
        TextField(
          controller: passctrl,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
              ),
              hintText: 'pass'),
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  _saveBody(var body) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // write
    prefs.setString('body', body);

    //Redireccion a la clase
    final route = MaterialPageRoute(builder: (context) => XookData());
    Navigator.pushReplacement(context, route);
  }

//thank you
}
