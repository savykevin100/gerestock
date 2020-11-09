import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/text_classe.dart';

import '../../constantes/calcul.dart';
import '../../constantes/hexadecimal.dart';

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
      appBar: appBar(context,"Mouvements de Stock"),
      body: ListView(
        children: [
          SizedBox(height: longueurPerCent(20, context),),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             _happyVeganCard( "Entrées",bleuPrincipale,Icons.arrow_downward,deviceHeight),
             _happyVeganCard( "Sorties", Color(0xFFB2C40F),Icons.arrow_upward,deviceHeight),
           ],
         ),
          Card(
              margin: EdgeInsets.symmetric(horizontal: largeurPerCent(21, context), vertical: longueurPerCent(46, context)),
              child: Container(
                height: 500,
                width: double.infinity,
                child: ListView(
                  children: [
                    SizedBox(height: 20,),
                    TextClasse(text: "Historique", textAlign: TextAlign.center, fontSize: 20, family: "MonserratBold",),
                    SizedBox(height: 20,),
                    Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                displayRecapTextBold("    "),
                                Expanded(
                                    flex:1,
                                    child: displayRecapTextBold("Date de l'opération")),
                                Expanded(
                                    flex:1,
                                    child: displayRecapTextBold("Numéro de borderau ou facture")),
                                Expanded(
                                    flex: 1,
                                    child: displayRecapTextBold("Fournisseur ou Client")),
                                Expanded(
                                    flex: 1,
                                    child: displayRecapTextBold("Quantité")),
                              ],
                            ),
                            SizedBox(height: 20,),
                            StaggeredGridView.countBuilder(
                              crossAxisCount: 1,
                              itemCount: 2,
                              itemBuilder: (context, i) {
                                return Container(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 13,
                                            width: 4,
                                            color: primaryColor,
                                          ),
                                          Text("   "),
                                          autoSizeTextGreyEntrer("18/02/2020"),
                                          autoSizeTextGreyEntrer("686868"),
                                          autoSizeTextGreyEntrer("SAHA Enterprise"),
                                          autoSizeTextGreyEntrer("3.000")
                                        ],
                                      ),
                                      Divider(color: HexColor("#ADB3C4"),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 13,
                                            width: 4,
                                            color: HexColor("#B2C40F"),
                                          ),
                                          Text("   "),
                                          autoSizeTextGreySorti("18/02/2020"),
                                          autoSizeTextGreySorti("686868"),
                                          autoSizeTextGreySorti("SAHA Enterprise"),
                                          autoSizeTextGreySorti("3.000")
                                        ],
                                      ),
                                    ],
                                  ),

                                );
                              },
                              staggeredTileBuilder: (_) => StaggeredTile.fit(2),
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 0.0,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                            )
                          ],
                        )
                    ),
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }


  TextClasse  displayRecapTextBold(String text){
    return TextClasse(text: text, color: HexColor("#C9C9C9"), family: "MonserratBold", fontSize: 9,);
  }

  TextClasse  displayRecapTextGrey(String text){
    return TextClasse(text: text, color: HexColor("#C9C9C9"), family: "MonserratBold", fontSize: 12,);
  }




  Expanded autoSizeTextGreyEntrer(String titre){
    return Expanded(
        flex: 1,
        child: AutoSizeText(
          titre,
          style: TextStyle(fontSize: 10.0, fontFamily: "MonserratBold", color: primaryColor),
          maxLines: 3,
          minFontSize: 9,
        )
    );
  }


  Expanded autoSizeTextGreySorti(String titre){
    return Expanded(
        flex: 1,
        child: AutoSizeText(
          titre,
          style: TextStyle(fontSize: 10.0, fontFamily: "MonserratBold", color: HexColor("#B2C40F")),
          maxLines: 3,
          minFontSize: 9,
        )
    );
  }



  Widget _happyVeganCard(String title, Color couleur,IconData icone ,double deviceHeight) {
    void moveToFoodDetailsScreen() {
      Navigator.of(context).pushNamed("/"+title);
    }
    return new GestureDetector(
      onTap: () => moveToFoodDetailsScreen(),
      child: Container(
          width: largeurPerCent(200, context),
          padding:EdgeInsets.only(left: 5.0,right: 5.0),
          child: Card(
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
          )),
    );
  }
}