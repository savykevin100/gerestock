import 'package:flutter/material.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/text_classe.dart';


class Abonnement extends StatefulWidget {
  @override
  _AbonnementState createState() => _AbonnementState();
}

class _AbonnementState extends State<Abonnement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Abonnement")
    );
  }
}
