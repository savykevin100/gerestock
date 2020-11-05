import 'package:flutter/material.dart';
import 'package:gerestock/constantes/color.dart';
class NouveauProduit extends StatefulWidget {
  @override
  _NouveauProduitState createState() => _NouveauProduitState();
}

class _NouveauProduitState extends State<NouveauProduit> {
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
        title: Text("Nouveau Produit",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
      ),
    );
  }
}