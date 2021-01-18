


import 'package:flutter/material.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/text_classe.dart';


InkWell submitButton(BuildContext context, String text, Function onTap, ){
  return InkWell(
    onTap: onTap,
    child: Center(
      child: Container(
        height:41,
        width: largeurPerCent(239, context),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            color: primaryColor
        ),
        child: Center(child: TextClasse(text: text, color: white, family: "MonserratBold", fontSize: 17, )),
      ),
    ),
  );
}