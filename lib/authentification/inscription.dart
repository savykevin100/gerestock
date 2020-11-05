import 'package:flutter/material.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:hexcolor/hexcolor.dart';
class Inscription extends StatefulWidget {
  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top:50.0,left: 20.0,right: 20.0),
          child: Center(
            child: Form(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [
                  Text("LOGO", style: TextStyle(color: bleuPrincipale,fontWeight: FontWeight.bold,fontSize: 53.0),),
                  SizedBox(height: 16.0,),
                  new TextFormField(
                     decoration: InputDecoration(
                       hintText: 'Email',
                      hintStyle: TextStyle(color: HexColor("#ADB3C4"))
                     ),
                  ),
                  new TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Mot de passe',
                        hintStyle: TextStyle(color: HexColor("#ADB3C4"))
                    ),
                  ),
                  new TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Confirmation du mot de passe',
                        hintStyle: TextStyle(color: HexColor("#ADB3C4"))
                    ),
                  ),
                  SizedBox(height: 16.0,),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.3,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: bleuPrincipale,
                    ),
                    child: FlatButton(
                      onPressed: (){
                        Navigator.of(context).pushReplacementNamed("/acceuil");
                      },
                      child: Text("SE CONNECTER",
                        style: TextStyle(color: Colors.white, fontSize: 15,fontFamily: "Monteserrat"),),
                    ),
                  ),
                  SizedBox(height: 16.0,),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 1.3,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: FlatButton(
                      color: Colors.white,
                      onPressed: (){
                        Navigator.of(context).pushNamed("/connexion");
                      },
                      child: Text("S'INSCRIRE",
                        style: TextStyle(color: bleuPrincipale, fontSize: 15),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
