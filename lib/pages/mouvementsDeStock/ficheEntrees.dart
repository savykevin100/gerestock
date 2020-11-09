import 'package:flutter/material.dart';
import 'package:gerestock/constantes/appBar.dart';
class FicheEntrees extends StatefulWidget {
  @override
  _FicheEntreesState createState() => _FicheEntreesState();
}

class _FicheEntreesState extends State<FicheEntrees> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithSearch(context,"Entrées"),
    );
  }
}
