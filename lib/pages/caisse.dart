import 'package:flutter/material.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/text_classe.dart';


class Caisse extends StatefulWidget {
  @override
  _CaisseState createState() => _CaisseState();
}

class _CaisseState extends State<Caisse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bleuPrincipale,
        elevation: 0.0,
        title: TextClasse(text: "Caisse", color: white, fontSize: 20, family: "MonserratBold",),
      ),
    );
  }
}