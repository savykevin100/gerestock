import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gerestock/authentification/informations_supplementaire.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/submit_button.dart';
import 'package:gerestock/constantes/text_classe.dart';


class RegisterPassword extends StatefulWidget {

  String numeroDeTelephone;
  RegisterPassword({this.numeroDeTelephone});
  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<RegisterPassword> {
  String email='';
  String motDePass= '';
  String confirmation = '';
  final _formKey = GlobalKey<FormState>();


  Future<bool> onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text("Fermer l'application",  style: TextStyle( color:primaryColor,
            fontSize: 15.0,
            fontFamily: "MonserratBold")),
        content: new Text("Voulez-vous quitter l'application?",  style: TextStyle(fontFamily: "MonserratLight")),
        actions: <Widget>[
          new GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Text("NON", style: TextStyle( color: primaryColor,
                  fontSize: 12.0,
                  fontFamily: "MonserratBold"),)
          ),
          SizedBox(height: longueurPerCent(10, context),),

          SizedBox(width: largeurPerCent(50, context),),
          new GestureDetector(
              onTap: () => exit(0),
              child: Text("OUI", style: TextStyle( color:primaryColor,
                  fontSize: 12.0,
                  fontFamily: "MonserratBold"),)
          ),
          SizedBox(height: longueurPerCent(10, context),),
          SizedBox(width: largeurPerCent(20, context),),
        ],
      ),
    ) ??
        false;
  }


  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: onBackPressed,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                SizedBox(height: longueurPerCent(50, context),),
                Image.asset("lib/assets/images/gerestock_logo.jpg", height: 200, width: 200,),
                SizedBox(height: longueurPerCent(50, context),),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kDefautPadding),
                  child: TextFormField(
                    style: TextStyle(
                        color: HexColor("#001C36"),
                        fontSize: 18,
                        fontFamily: "MonserratBold"
                    ),
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Mot de passe',
                        hintStyle: TextStyle(color: HexColor("#ADB3C4"), fontFamily: "MonserratRegular")
                    ),
                    onChanged: (value){
                      motDePass = value;
                    },
                    // ignore: missing_return
                    validator: (String value) {
                      if(value.isEmpty) {
                        return ("Entrer un mot de passe valide");
                      } else if (value.length<6) {
                        return ("Le nombre de caractères doit être supérieur à 5");
                      }
                    },
                  ),
                ),
                SizedBox(height: longueurPerCent(20, context),),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kDefautPadding),
                  child: TextFormField(
                    style: TextStyle(
                        color: HexColor("#001C36"),
                        fontSize: 18,
                        fontFamily: "MonserratBold"
                    ),
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Confirmation mot de passe',
                        hintStyle: TextStyle(color: HexColor("#ADB3C4"), fontFamily: "MonserratRegular")
                    ),
                    onChanged:
                        (value) => confirmation = value,
                    // ignore: missing_return
                    validator: (String value) {
                      if (value.isEmpty || motDePass != value) {
                        return ("Veuillez confirmer votre mot de passe");
                      }
                    },
                  ),
                ),
                SizedBox(height: longueurPerCent(60, context),),
                submitButton(context, "CONTINUER", () async {
                  if(_formKey.currentState.validate()) {

                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => InformationSupplementaire(numeroDeTelephone: widget.numeroDeTelephone, password: motDePass, )
                    ));
                  }
                }),
                SizedBox(height: longueurPerCent(20, context),),
              ],
            ),
          ),
        ),
      ),
    );
  }


  showAlertDialog(BuildContext context, String text) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("ALERT"),
      content: Text(text),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
