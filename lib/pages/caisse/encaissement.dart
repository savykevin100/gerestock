import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/text_classe.dart';



class Encaissement extends StatefulWidget {
  @override
  _EncaissementState createState() => _EncaissementState();
}

class _EncaissementState extends State<Encaissement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Encaissement"),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: longueurPerCent(30, context), horizontal: largeurPerCent(20, context)),
        child: StaggeredGridView.countBuilder(
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
                      SizedBox(width: 10,),
                      autoSizeTextGreyEntrer("3.000")
                    ],
                  ),
                  Divider(color: HexColor("#ADB3C4"),),
                ],
              ),

            );
          },
          staggeredTileBuilder: (_) => StaggeredTile.fit(2),
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 0.0,
          shrinkWrap: true,
        ),
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

}
