import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/text_classe.dart';


class FicheProduit extends StatefulWidget {
  @override
  _FicheProduitState createState() => _FicheProduitState();
}

class _FicheProduitState extends State<FicheProduit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Produit"),
     body: Center(
        child: ListView(
          children: [
            SizedBox(height: longueurPerCent(50, context),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextClasse(text: "Huile", fontSize: 26, family: "MonserratSemiBold",),
                      TextClasse(text: "256456", fontSize: 16, family: "MonserratSemiBold", color: HexColor("#C9C9C9"),),
                      RichText(
                        text: TextSpan(
                          text: 'Stock alerte: ',
                          style: TextStyle(fontSize: 10,color: HexColor("#001C36"), fontFamily: "MonserratLight"),
                          children: <TextSpan>[
                            TextSpan(text: '  23', style: TextStyle(fontFamily: "MonserratSemiBold", color: HexColor("#FF0202"))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10,)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
