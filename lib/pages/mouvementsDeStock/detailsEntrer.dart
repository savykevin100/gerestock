import 'package:flutter/material.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/constantsWidgets.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/modeles/entrer_models.dart';

import '../../helper.dart';


class DetailsEntrer extends StatefulWidget {
  String dateReceipt;
  String provider;
  int amount;
  String deliveryMan;
  List<dynamic> products;
  DetailsEntrer({this.dateReceipt, this.provider, this.amount, this.deliveryMan, this.products});

  @override
  _DetailsEntrerState createState() => _DetailsEntrerState();
}

class _DetailsEntrerState extends State<DetailsEntrer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Details entrée"),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50,),
            displayField("Date de réception:",Helper.currentFormatDate( widget.dateReceipt)),
            SizedBox(height: 40,),
            displayField("Fournisseur", widget.provider),
            SizedBox(height: 40,),
            displayField("Montant", Helper.currenceFormat(widget.amount)),
            SizedBox(height: 40,),
            (widget.deliveryMan!=null)? displayField("Livreur:", widget.deliveryMan):Text(""),
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                nameOfFieldWithPadding("Produits:", context),
              ],
            ),
            SizedBox(height: 40,),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.products.length,
                itemBuilder: (context, i) {
                 return Column(
                   children: [
                     displayRecapTextGrey("${widget.products[i]["productName"]} -----> ${widget.products[i]["quantite"]}"),
                     SizedBox(height: 40,),
                   ],
                 );
                }
            ),
          ],
        ),
      ),
    );
  }

  TextClasse  displayRecapTextGrey(String text){
    return TextClasse(text: text, color: Colors.green, family: "MonserratBold", fontSize: 15,);
  }

  Row displayField(String nameFiel, String value){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        nameOfFieldWithPadding(nameFiel, context),
        displayRecapTextGrey(value)
      ],
    );
  }

}
