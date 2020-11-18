import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/submit_button.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/pages/parametres.dart';
class Inscription extends StatefulWidget {
  @override
  _InscriptionState createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {
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
                SizedBox(height: longueurPerCent(100, context),),
                Text("LOGO", style: TextStyle(color: bleuPrincipale,fontWeight: FontWeight.bold,fontSize: 53.0),),
                SizedBox(height: longueurPerCent(50, context),),
                 Padding(
                   padding: EdgeInsets.symmetric(horizontal: kDefautPadding),
                   child: TextFormField(
                     style: TextStyle(
                         color: HexColor("#001C36"),
                         fontSize: 18,
                         fontFamily: "MonserratBold"
                     ),
                     keyboardType: TextInputType.emailAddress,
                     decoration: InputDecoration(
                       hintText: 'Email',
                         hintStyle: TextStyle(color: HexColor("#ADB3C4"), fontFamily: "MonserratRegular")
                     ),
                     onChanged: (value){
                       email = value;
                     },
                     // ignore: missing_return
                     validator: (String value) {
                       if (email.isEmpty) {
                         return ("L'email entré est vide");
                       } else if(EmailValidator.validate(email) == false){
                         return ("Entrer un email valide");
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
                submitButton(context, "S'INSCRIRE", () async {
                  if(_formKey.currentState.validate()) {
                    EasyLoading.show(status: 'Chargement');
                    try {
                      final user= await _auth.createUserWithEmailAndPassword(email: email, password: motDePass);
                      /*if(user!=null ) {
                        _auth.currentUser().then((value) {
                          value.sendEmailVerification();
                        });
                      }*/
                      EasyLoading.dismiss();
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
                        return Parametres(email: email);
                      }));
                    } catch(e){
                      EasyLoading.dismiss();
                      print(e.toString());
                      showAlertDialog(context, "Votre email est déjà utilisé par un autre compte");
                    }
                  }
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
                      Navigator.of(context).pushNamed("/connexion");
                    },
                    child: TextClasse(text: "SE CONNECTER", color: bleuPrincipale, fontSize: 15, family: "MonserratBold",)
                  ),
                ),
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
