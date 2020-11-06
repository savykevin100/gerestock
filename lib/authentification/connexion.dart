import 'package:flutter/material.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/submit_button.dart';
import 'package:gerestock/constantes/text_classe.dart';



class Connexion extends StatefulWidget {
  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Connexion> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget> [
              SizedBox(height: longueurPerCent(100, context),),
              Text("LOGO", style: TextStyle(color: bleuPrincipale,fontWeight: FontWeight.bold,fontSize: 53.0),),
              SizedBox(height: longueurPerCent(50, context),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefautPadding),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(color: HexColor("#ADB3C4"), fontFamily: "MonserratRegular")
                  ),
                ),
              ),
              SizedBox(height: longueurPerCent(20, context),),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefautPadding),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Mot de passe',
                      hintStyle: TextStyle(color: HexColor("#ADB3C4"), fontFamily: "MonserratRegular")
                  ),
                ),
              ),
              SizedBox(height: longueurPerCent(80, context),),
              submitButton(context, "SE CONNECTER", (){
                Navigator.of(context).pushNamed("/accueil");
              }),
              SizedBox(height: longueurPerCent(20, context),),
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
                      Navigator.of(context).pushNamed("/inscription");
                    },
                    child: TextClasse(text: "S'INSCRIRE", color: bleuPrincipale, fontSize: 15, family: "MonserratBold",)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
