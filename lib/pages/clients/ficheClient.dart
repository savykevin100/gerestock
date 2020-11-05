import 'package:flutter/material.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/submit_button.dart';
import 'package:gerestock/constantes/text_classe.dart';




class FicheClient extends StatefulWidget {
  static String id ="FicheClient";
  @override
  _FicheClientState createState() => _FicheClientState();
}

class _FicheClientState extends State<FicheClient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Fiche client"),
      body: Center(
        child:SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: longueurPerCent(20, context),),
              Icon(Icons.person, color: primaryColor, size: 120,),
              SizedBox(height: longueurPerCent(30, context),),
              Padding(
                padding:EdgeInsets.symmetric(horizontal: largeurPerCent(22, context)),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Nom du client",
                    labelStyle: TextStyle(fontFamily: "MonserratBold", fontSize: 12, color: HexColor("#001C36")),
                  ),
                ),
              ),
              SizedBox(height: longueurPerCent(20, context),),
              Padding(
                padding:EdgeInsets.symmetric(horizontal: largeurPerCent(22, context)),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Adresse",
                    labelStyle: TextStyle(fontFamily: "MonserratBold", fontSize: 12, color: HexColor("#001C36")),
                  ),
                ),
              ),
              SizedBox(height: longueurPerCent(20, context),),

              Padding(
                padding:EdgeInsets.symmetric(horizontal: largeurPerCent(22, context)),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Téléphone",
                    labelStyle: TextStyle(fontFamily: "MonserratBold", fontSize: 12, color: HexColor("#001C36")),
                  ),
                ),
              ),
              SizedBox(height: longueurPerCent(20, context),),

              Padding(
                padding:EdgeInsets.symmetric(horizontal: largeurPerCent(22, context)),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(fontFamily: "MonserratBold", fontSize: 12, color: HexColor("#001C36")),
                  ),
                ),
              ),
              SizedBox(height: longueurPerCent(50, context),),
              submitButton(context, "AJOUTER", (){

              })
            ],
          ),
        ),
      ),
    );
  }
}
