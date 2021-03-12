import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gerestock/app_controller.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/helper.dart';
import 'package:gerestock/modeles/entrer_models.dart';
import 'package:gerestock/pages/mouvementsDeStock/detailsEntrer.dart';
import 'package:gerestock/pages/mouvementsDeStock/ficheEntrees.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
class Entrees extends StatefulWidget {
  @override
  _EntreesState createState() => _EntreesState();
}

class _EntreesState extends StateMVC<Entrees> {

   CollectionReference _users= Firestore.instance
      .collection("Utilisateurs");


   AppController _con ;



   _EntreesState() : super(AppController()) {
     _con = controller;
   }


   @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithSearch(context,"Entrées"),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: longueurPerCent(30, context), horizontal: largeurPerCent(20, context)),
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
                      child: displayRecapTextBold("Nombre de produits")),
                  Expanded(
                      flex: 1,
                      child: displayRecapTextBold("Fournisseur")),
                  Expanded(
                      flex: 1,
                      child: displayRecapTextBold("Montant")),
                  Expanded(
                      flex: 1,
                      child: displayRecapTextBold("Recap")),
                ],
              ),
              (_con.userPhone!="")?StreamBuilder(
                stream:  _users
                    .doc(_con.userPhone)
                    .collection("Entrees")
                    .orderBy("created", descending: true)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError || !snapshot.hasData)
                    return Center(child: CircularProgressIndicator(),);
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(child: CircularProgressIndicator(),);
                  else if(snapshot.connectionState == ConnectionState.none)
                    return Center(child: Text("Veuillez vérifier votre connexion internet"),);
                  return StaggeredGridView.countBuilder(
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 1,
                    itemCount: snapshot.data.docs.length,
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
                                autoSizeTextGreyEntrer(snapshot.data.docs[i].data()["dateReceipt"]),
                                Text("   "),
                                autoSizeTextGreyEntrer("${snapshot.data.docs[i].data()["products"].length}"),
                                autoSizeTextGreyEntrer(snapshot.data.docs[i].data()["provider"]),
                                autoSizeTextGreyEntrer(Helper.currenceFormat(snapshot.data.docs[i].data()["amount"])),
                                Expanded(
                                    flex: 1,
                                    child:IconButton(icon:  Icon(Icons.navigate_next, color: primaryColor, size: 30,), onPressed: (){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) => DetailsEntrer(
                                            dateReceipt: snapshot.data.docs[i].data()["dateReceipt"],
                                            provider: snapshot.data.docs[i].data()["provider"],
                                            amount: snapshot.data.docs[i].data()["amount"],
                                            deliveryMan: snapshot.data.docs[i].data()["deliveryMan"],
                                            products: snapshot.data.docs[i].data()["products"],
                                            )));
                                    })
                                )
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
                  );
                  // snapshot.data.documents.map((DocumentSnapshot document)
                },
              ):Center(child: CircularProgressIndicator())
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(_con.userPhone);
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FicheEntrees(userPhone: _con.userPhone,)));
         // Navigator.of(context).pushNamed("/FicheEntrees");

        },
        child: Icon(Icons.add, color: white,),
        backgroundColor: primaryColor,
      ),
    );
  }
/* */

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
