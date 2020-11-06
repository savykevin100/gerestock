import 'package:flutter/material.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/submit_button.dart';
import 'package:gerestock/constantes/text_classe.dart';




class FormFournisseursClientsWidget extends StatefulWidget {
  static String id ="FormFournisseursClientsWidget";
  
  String title;
  
  FormFournisseursClientsWidget({this.title});
  @override
  _FicheClientState createState() => _FicheClientState();
}

class _FicheClientState extends State<FormFournisseursClientsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextClasse(text: widget.title, color: white, fontSize: 20, textAlign: TextAlign.center, family: "MonserratBold",),
        backgroundColor: primaryColor,
      ),
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
