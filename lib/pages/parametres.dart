import 'package:flutter/material.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/text_classe.dart';


class Parametres extends StatefulWidget {
  @override
  _ParametresState createState() => _ParametresState();
}

class _ParametresState extends State<Parametres> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bleuPrincipale,
        elevation: 0.0,
        title: TextClasse(text: "Paramètres", color: white, fontSize: 20, family: "MonserratBold",),

      ),
    );
  }
}