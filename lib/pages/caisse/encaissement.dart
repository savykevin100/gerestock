import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/firestore_service.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/helper.dart';
import 'package:gerestock/modeles/facture.dart';
import 'package:gerestock/pages/caisse/recapEncaissement.dart';



class Encaissement extends StatefulWidget {
  @override
  _EncaissementState createState() => _EncaissementState();
}

class _EncaissementState extends State<Encaissement> {


  CollectionReference _users= Firestore.instance
      .collection("Utilisateurs");

  String _emailEntreprise;

  Future<User> getUser() async {
    return FirebaseAuth.instance.currentUser;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((value){
      if(value!=null){
        setState(()  {
          _emailEntreprise = value.email;
        });
      }
      print(_emailEntreprise);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context,"Encaissement"),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: longueurPerCent(30, context), horizontal: largeurPerCent(20, context)),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                displayRecapTextBold("    "),
                Expanded(
                    flex:2,
                    child: displayRecapTextBold("Date de l'opération")),
                Expanded(
                    flex:2,
                    child: displayRecapTextBold("Facturation type")),
                Expanded(
                    flex: 2,
                    child: displayRecapTextBold("Client")),
                Expanded(
                    flex: 2,
                    child: displayRecapTextBold("Montant")),
                Expanded(
                    flex: 1,
                    child: displayRecapTextBold("Recap")),
              ],
            ),
            StreamBuilder(
              stream:  _users
                  .doc(_emailEntreprise)
                  .collection("Factures")
                  .orderBy("created", descending: true)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError || !snapshot.hasData)
                  return Text('Pas de données');
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator(),);
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
                              autoSizeTextGreyEntrer(Helper.currentFormatDate(snapshot.data.docs[i].data()["created"])),
                              Text("   "),
                              autoSizeTextGreyEntrer("${snapshot.data.docs[i].data()["billingType"]}"),
                              autoSizeTextGreyEntrer(snapshot.data.docs[i].data()["customerName"]),
                              autoSizeTextGreyEntrer(Helper.currenceFormat(snapshot.data.docs[i].data()["amountTotal"])),
                              IconButton(icon:  Icon(Icons.navigate_next, color: primaryColor, size: 30,), onPressed: (){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) => DetailsFacture(
                                      typeFacturation: snapshot.data.docs[i].data()["billingType"]=="Ventes"?false:true,
                                      dateInput: snapshot.data.docs[i].data()["created"],
                                      client: snapshot.data.docs[i].data()["customerName"],
                                      emailEntreprise: _emailEntreprise,
                                      products: snapshot.data.docs[i].data()["products"]
                                     ,)));
                              })
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
            ),
          ],
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
