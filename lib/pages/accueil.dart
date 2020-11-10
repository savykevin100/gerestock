import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/constantes/color.dart';

class Accueil extends StatefulWidget {
  Accueil() : super();

  @override
  State<StatefulWidget> createState() {
    return _AccueilPageState();
  }
}

class _AccueilPageState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    double deviceHeight = queryData.size.height;

    return new Scaffold(
      appBar:  AppBar(title: Text("Accueil"),backgroundColor: bleuPrincipale,),
        drawer: Drawer(),
        body: GridView.count(
                shrinkWrap: true,
               crossAxisCount: 2,
                children: <Widget>[
                  _happyVeganCard( "Nouveau Produit",Colors.green,Icons.add,deviceHeight),
                  _happyVeganCard( "Clients", Color(0xFFC502FF),Icons.person,deviceHeight),
                  _happyVeganCard( "Fournisseur", Color(0xFF02C5FF),Icons.shopping_cart,deviceHeight),
                  _happyVeganCard( "Mouvement de Stock", Color(0xFF707070),Icons.cached,deviceHeight),
                  _happyVeganCard( "Facturation", Color(0xFFFF8002),Icons.cached,deviceHeight),
                  _happyVeganCard( "Caisse", Color(0xFF092648),Icons.cached,deviceHeight),
                  _happyVeganCard( "Inventaire", Color(0xFF026DFF),Icons.list,deviceHeight),
                  _happyVeganCard( "Abonnement", Color(0xFFFF0202),Icons.cached,deviceHeight),
                  _happyVeganCard( "Dépenses", Color(0xFFFC2872),Icons.book,deviceHeight),
                  _happyVeganCard( "Paramètres", Color(0xFFC9C9C9),Icons.settings,deviceHeight),
                ],
              ),
        );
  }

  Widget _happyVeganCard(String title, Color couleur,IconData icone ,double deviceHeight) {
    void moveToFoodDetailsScreen() {
      Navigator.of(context).pushNamed("/"+title);
    }
    return new GestureDetector(
      onTap: () => moveToFoodDetailsScreen(),
      child: Container(
          width: largeurPerCent(175, context),
          padding:EdgeInsets.only(left: 5.0,right: 5.0),
          child: Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 0.0),
                      child: Container(
                          height: (deviceHeight/5),
                          width: MediaQuery.of(context).size.width/2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5.0),
                                  topLeft: Radius.circular(5.0)),
                                  color: couleur,
                              ),
                        child: Icon(icone,color: Colors.white,size: 40,),
                          ),
                    ),
                    SizedBox(height: 5.0),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.0),
                        child: AutoSizeText(
                          title,
                          style: TextStyle(fontSize: 15.0, fontFamily: "MonserratBold", color: couleur),
                          maxLines: 1,
                          minFontSize: 11,
                        )
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
