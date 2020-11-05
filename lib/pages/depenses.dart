import 'package:flutter/material.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/text_classe.dart';

class Depenses extends StatefulWidget {
  @override
  _DepensesState createState() => _DepensesState();
}

class _DepensesState extends State<Depenses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bleuPrincipale,
        elevation: 0.0,
        title: TextClasse(text: "Dépenses", color: white, fontSize: 20, family: "MonserratBold",),
      ),
    );
  }
}