import 'package:flutter/material.dart';
import 'package:gerestock/constantes/color.dart';
class Fournisseur extends StatefulWidget {
  @override
  _FournisseurState createState() => _FournisseurState();
}

class _FournisseurState extends State<Fournisseur> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bleuPrincipale,
        elevation: 0.0,
        leading: IconButton(
          icon:Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("Fournisseur",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
      ),
    );
  }
}