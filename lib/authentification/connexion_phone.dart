import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gerestock/authentification/phone_authentification.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/submit_button.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/pages/accueil.dart';
import 'package:gerestock/repository.dart';



class ConnexionPhone extends StatefulWidget {
  @override
  ConnexionPhoneState createState() => ConnexionPhoneState();
}

class ConnexionPhoneState extends State<ConnexionPhone> {

  String email;
  String motDePass ;
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String code = "+229";
  TextEditingController _numeroTelephone = TextEditingController();
  String numeroAvecCode = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();





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



  showAlertDialog(BuildContext context, String text) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("RETOUR"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("ALERTE"),
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  child:  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child:  Column(
                          children: [
                            SizedBox(height: 15,),
                            CountryCodePicker(
                              textStyle: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18,
                                  fontFamily: "MonserratSemiBold"
                              ),
                              onChanged: (e)  {
                                print(e.code.toString());
                                setState(() {
                                  code = e.code.toString();
                                });
                              },
                              initialSelection: 'BJ',
                              showCountryOnly: true,
                              showOnlyCountryWhenClosed: false,
                              favorite: ['+229', 'FR'],
                            ),
                          ],
                        ),),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding:EdgeInsets.only(top: 15),
                          child: TextFormField(
                            style:  TextStyle(
                                color:Theme.of(context).primaryColor,
                                fontSize: 18,
                                fontFamily: "MonserratSemiBold"
                            ),
                            controller: _numeroTelephone,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: "Numéro de Téléphone",
                                hintStyle:TextStyle(color: HexColor("#ADB3C4"), fontFamily: "MonserratRegular")
                            ),
                            // ignore: missing_return
                            validator: (value){
                              // ignore: missing_
                              if(value.isEmpty)
                                return ("Veuillez entrer le numéro de téléphone");
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: longueurPerCent(20, context),),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kDefautPadding),
                  child: TextFormField(
                    style: TextStyle(
                        color:Theme.of(context).primaryColor,
                        fontSize: 18,
                        fontFamily: "MonserratSemiBold"
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

                SizedBox(height: longueurPerCent(80, context),),
                submitButton(context, "SE CONNECTER", () async {
                  setState(() {
                    numeroAvecCode = code + _numeroTelephone.text;
                  });
                  if(_formKey.currentState.validate() ) {
                    checkInformation();
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
                      onPressed: ()  {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => PhoneAuthentification()
                        ));
                      },
                      child: TextClasse(text: "S'INSCRIRE", color: bleuPrincipale, fontSize: 15, family: "MonserratBold",)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  void checkInformation(){
    EasyLoading.show(status: 'Chargement', dismissOnTap: false);
    Firestore.instance.collection("Utilisateurs").doc(numeroAvecCode).get().then((value) {
      if(value.exists) {
        if(value.data()["password"] == motDePass){
          setNumeroUser(numeroAvecCode);
          EasyLoading.dismiss();
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => Accueil()
          ));
        } else {
          EasyLoading.dismiss();
          displaySnackBarNom(context, "Le mot de passe entré est incorrect", Colors.white);
        }
      }
      else {
        EasyLoading.dismiss();
        displaySnackBarNom(context, "Aucun compte ne correspond au numéro entré", Colors.white);
      }
    });
  }


  displaySnackBarNom(BuildContext context, String text, Color couleur) {
    final snackBar = SnackBar(
      content: Text(text, style: TextStyle(color: couleur, fontSize: 13)),
      duration: Duration(seconds: 2),
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }


}
