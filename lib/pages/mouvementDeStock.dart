import 'package:flutter/material.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/text_classe.dart';

class MouvementDeStock extends StatefulWidget {
  @override
  _MouvementDeStockState createState() => _MouvementDeStockState();
}

class _MouvementDeStockState extends State<MouvementDeStock> {

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    double deviceHeight = queryData.size.height;
    return Scaffold(
      appBar: appBar("Mouvements de Stock"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: <Widget>[
                _happyVeganCard( "Entrées",bleuPrincipale,Icons.arrow_downward,deviceHeight),
                _happyVeganCard( "Sorties", Color(0xFFB2C40F),Icons.arrow_upward,deviceHeight),
              ],
            ),
            Card(
              color: Colors.white,
              child: Column(
                children: [

                ],
              ),
            )
          ],
        ),
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
          child: ListView(
             children: [
               Card(
                 elevation: 2.0,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(5.0),
                 ),
                 child: Container(
                     height: (deviceHeight/3.8),
                     width: MediaQuery.of(context).size.width/2,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.only(
                           topRight: Radius.circular(5.0),
                           topLeft: Radius.circular(5.0)),
                       color: couleur,
                     ),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Icon(icone,color: Colors.white,size: 80,),
                         SizedBox(height: 5.0),
                         TextClasse(text: title, color: white, fontSize: 18, family: "MonserratBold",)
                       ],
                     )
                 ),
               ),
             ],
          )),
    );
  }
}