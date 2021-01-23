import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/pages/accueil.dart';
import 'package:gerestock/pages/payement/select_payement_mode.dart';


class TestModeOrPayement extends StatefulWidget {
  @override
  _TestModeOrPayementState createState() => _TestModeOrPayementState();
}

class _TestModeOrPayementState extends State<TestModeOrPayement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onBackPressed,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: ()=>  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Accueil()
                  )),
                  child: Card(
                    elevation: 8.0,
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      child: Center(child: Text("Continuer en mode gratuit (valable pour 1 mois)")),
                    ),
                  ),
                ),

                InkWell(
                  onTap: ()=>  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SelectPayementMode()
                  )),
                  child: Card(
                    elevation: 8.0,
                    child: Container(
                      height: 100,
                      width: double.infinity,
                      child: Center(child: Text("Passer au payement valable pour un an")),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text("Fermer l'application",  style: TextStyle( color: HexColor("#001C36"),
            fontSize: 15.0,
            fontFamily: "MonseraBold")),
        content: new Text("Voulez-vous quitter l'application?",  style: TextStyle(fontFamily: "MonseraLight")),
        actions: <Widget>[
          new GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Text("NON", style: TextStyle( color: HexColor("#001C36"),
                  fontSize: 12.0,
                  fontFamily: "MonseraBold"),)
          ),
          SizedBox(height: longueurPerCent(10, context),),

          SizedBox(width: largeurPerCent(50, context),),
          new GestureDetector(
              onTap: () => exit(0),
              child: Text("OUI", style: TextStyle( color: HexColor("#001C36"),
                  fontSize: 12.0,
                  fontFamily: "MonseraBold"),)
          ),
          SizedBox(height: longueurPerCent(10, context),),
          SizedBox(width: largeurPerCent(20, context),),
        ],
      ),
    ) ??
        false;
  }

}
