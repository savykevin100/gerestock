import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gerestock/constantes/color.dart';

import 'calcul.dart';


Future<bool> onBackPressed(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      title: new Text("Fermer l'application",  style: TextStyle( color:primaryColor,
          fontSize: 15.0,
          fontFamily: "MonseraBold")),
      content: new Text("Voulez-vous quitter l'application?",  style: TextStyle(fontFamily: "MonseraLight")),
      actions: <Widget>[
        new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NON", style: TextStyle( color: primaryColor,
                fontSize: 12.0,
                fontFamily: "MonseraBold"),)
        ),
        SizedBox(height: longueurPerCent(10, context),),

        SizedBox(width: largeurPerCent(50, context),),
        new GestureDetector(
            onTap: () => exit(0),
            child: Text("OUI", style: TextStyle( color:primaryColor,
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
