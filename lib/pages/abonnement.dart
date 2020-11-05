import 'package:flutter/material.dart';
import 'package:gerestock/constantes/color.dart';

class Abonnement extends StatefulWidget {
  @override
  _AbonnementState createState() => _AbonnementState();
}

class _AbonnementState extends State<Abonnement> {
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
        title: Text("Abonnement",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
      ),
    );
  }
}
