import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/constantsWidgets.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/text_classe.dart';



class Facturation2 extends StatefulWidget {
  static String id = "Facturation2";
  @override
  _Facturation2State createState() => _Facturation2State();
}

class _Facturation2State extends State<Facturation2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextClasse(text: "Facturation", color: white, fontSize: 20, textAlign: TextAlign.center, family: "MonserratBold",),
        backgroundColor: primaryColor,
      ),
      body: Card(
        elevation: 5.0,
        margin: EdgeInsets.symmetric(horizontal: largeurPerCent(9, context), vertical: longueurPerCent(50, context)),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: white,
          child: ListView(
            children: [
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Container(
                    height:80,
                    width: 80,
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(color: HexColor("#C9C9C9"),)
                    ),
                    child: Center(child: TextClasse(text: "Logo", family: "MonserratBold", fontSize: 20,)),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'FACTURE N° ',
                      style: TextStyle(fontSize: 10,color: HexColor("#C9C9C9"), fontFamily: "MonserratBold"),
                      children: <TextSpan>[
                        TextSpan(text: '1487', style: TextStyle(fontFamily: "MonserratBold", color: HexColor("#000000"))),
                      ],
                    ),
                  ),
                  displayText("18/02/2020"),
                  SizedBox(width: 10,)
                ],
              ),
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    RichText(
                      text: TextSpan(
                        text: "Nom du client:     ",
                        style: TextStyle(fontSize: 10,color: HexColor("#C9C9C9"), fontFamily: "MonserratBold"),
                        children: <TextSpan>[
                          TextSpan(text: 'GBODJE', style: TextStyle(fontFamily: "MonserratBold", color: HexColor("#000000"))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 56,),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex:1,
                            child: displayRecapTextBold("Nom du produit")),
                        Expanded(
                            flex:1,
                            child: displayRecapTextBold("Quantité")),
                        Expanded(
                            flex: 1,
                            child: displayRecapTextBold("Prix Unitaire")),
                        Expanded(
                            flex: 1,
                            child: displayRecapTextBold("Montant")),
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
                                  autoSizeTextGrey("PC Mac portable pro"),
                                  autoSizeTextGrey("30.000.000"),
                                  autoSizeTextGrey("300.000.000"),
                                  autoSizeTextGrey("300.000.000.000")
                                ],
                              ),
                              Divider(color: HexColor("#ADB3C4"),)
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

              SizedBox(height: longueurPerCent(20, context),),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   TextClasse(text: "Montant", family: "MonserratBold", fontSize: 25, color: HexColor("#001C36"),),
                   TextClasse(text: "XOF", family: "MonserratBold", fontSize: 9, color: HexColor("#001C36"),),
                   TextClasse(text: "900.000.000.000.000", family: "MonserratBold", fontSize: 15, color: HexColor("#001C36"),),
                 ],
              )
            ],
          ),
        ),
      ),
        floatingActionButton: Center(
          child: Container(
            margin: EdgeInsets.only(
                top: MediaQuery
                    .of(context)
                    .size
                    .height - 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(width: largeurPerCent(20, context),),
                InkWell(
                  child: Padding(
                    padding:  EdgeInsets.only(left: largeurPerCent(15, context),right: largeurPerCent(5, context),),
                    child: Container(
                      height: longueurPerCent(38, context),
                      width: largeurPerCent(160, context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: primaryColor,
                      ),
                      child: Center(
                          child: Text(
                            "ENVOYER",
                            style: TextStyle(
                                color: white,
                                fontFamily: "MonserratBold",
                                fontSize: 15),
                          )
                      ),
                    ),
                  ),
                ),
                SizedBox(width: largeurPerCent(20, context),),
                InkWell(
                  onTap: () {

                  },
                  child: Padding(
                    padding:  EdgeInsets.only(left: largeurPerCent(10, context),right: largeurPerCent(15, context)),
                    child: Container(
                      height: longueurPerCent(38, context),
                      width: largeurPerCent(160, context),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(7)),
                      child: Center(
                        child: Text(
                          "IMPRIMER",
                          style: TextStyle(
                              color: white,
                              fontFamily: "MonserratBold",
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }

  TextClasse  displayRecapTextBold(String text){
    return TextClasse(text: text, color: HexColor("#001C36"), family: "MonserratBold", fontSize: 9,);
  }

  TextClasse  displayRecapTextGrey(String text){
    return TextClasse(text: text, color: HexColor("#C9C9C9"), family: "MonserratBold", fontSize: 12,);
  }




  Expanded autoSizeTextGrey(String titre){
   return Expanded(
       flex: 1,
       child: AutoSizeText(
     titre,
     style: TextStyle(fontSize: 10.0, fontFamily: "MonserratBold", color: HexColor("C9C9C9")),
     maxLines: 3,
     minFontSize: 9,
    )
   );
  }
}
