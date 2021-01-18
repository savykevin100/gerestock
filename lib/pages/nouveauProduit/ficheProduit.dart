import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/constantsWidgets.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/submit_button.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/modeles/produits.dart';


  class FicheProduit extends StatefulWidget {
    Produit produit ;
    String emailEntreprise;

    FicheProduit({this.produit, this.emailEntreprise});
  @override
  _FicheProduitState createState() => _FicheProduitState();
}

class _FicheProduitState extends State<FicheProduit> {

    bool _enableSellPriceUpdate=false;
    TextEditingController _sellPriceController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Produit"),
     body: Center(
        child: ListView(
          children: [
            SizedBox(height: longueurPerCent(100, context),),
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
                  child:CachedNetworkImage(
                    imageUrl: widget.produit.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(color:Colors.red, height: 110, width: largeurPerCent(210, context),),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextClasse(text: widget.produit.productName, fontSize: 26, family: "MonserratSemiBold",),
                      TextClasse(text: (widget.produit.id==null)?"":"${widget.produit.id}", fontSize: 10, family: "MonserratSemiBold", color: HexColor("#C9C9C9"),),
                      RichText(
                        text: TextSpan(
                          text: 'Stock alerte: ',
                          style: TextStyle(fontSize: 16,color: HexColor("#001C36"), fontFamily: "MonserratLight"),
                          children: <TextSpan>[
                            TextSpan(text: '${widget.produit.stockAlert}', style: TextStyle(fontFamily: "MonserratSemiBold", color: HexColor("#FF0202"))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: largeurPerCent(22, context)),
                  child: displayText("Prix de vente"),
                ),
                Container(
                  height: longueurPerCent(41, context),
                  width: largeurPerCent(210, context),
                  margin:
                  EdgeInsets.only(right: largeurPerCent(22, context)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border:
                    Border.all(width: 1.0, color: HexColor("#707070")),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    maxLines: null,
                    textAlign: TextAlign.center,
                    controller: _sellPriceController,
                    // controller: controller,
                    decoration: InputDecoration(
                        enabled: _enableSellPriceUpdate,
                        hintText: widget.produit.sellPrice,
                        contentPadding: EdgeInsets.only(left: 10),
                        enabledBorder: InputBorder.none),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50,),
            Center(child: TextClasse(text: "Stock thérioque: ${widget.produit.theoreticalStock}", textAlign: TextAlign.center, color: HexColor("#707070"), fontSize: 20, family: "MonserratBold",)),
            SizedBox(height: 50,),
            submitButton(context, (_enableSellPriceUpdate)?"ENREGISTRER":"MODIFIER", (){
              modifySellPriceProduct();
            })
          ],
        ),
      ),
    );
  }

  void modifySellPriceProduct() {
    if(_enableSellPriceUpdate){
      EasyLoading.show(status: 'Chargement', dismissOnTap: false);
      try {
        FirebaseFirestore.instance.collection("Utilisateurs").doc(widget.emailEntreprise).collection("Familles")
            .doc(widget.produit.familyName).collection("TousLesProduits").doc(widget.produit.id).update({"sellPrice": _sellPriceController.text});
        FirebaseFirestore.instance.collection("Utilisateurs").doc(widget.emailEntreprise).collection("TousLesProduits").where("image", isEqualTo: widget.produit.image).get().then((value) {
          FirebaseFirestore.instance.collection("Utilisateurs").doc(widget.emailEntreprise).collection("TousLesProduits").doc(value.docs.first.id).update({"sellPrice": _sellPriceController.text});
        });
      } catch (e) {
        EasyLoading.showError("La modification a échoué");
      }
      EasyLoading.dismiss();
      setState(() {
        _enableSellPriceUpdate=false;
      });
    } else
      setState(() {
        _enableSellPriceUpdate=true;
      });
  }
}
