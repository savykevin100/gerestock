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
import 'package:gerestock/modeles/decaissement_models.dart';

import '../../helper.dart';



class Decaissement extends StatefulWidget {
  @override
  DecaissementState createState() => DecaissementState();
}

class DecaissementState extends State<Decaissement> {
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
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context,"Decaissement"),
      body: ListView(
        children: [
          /*Container(
            margin: EdgeInsets.symmetric(vertical: longueurPerCent(30, context), horizontal: largeurPerCent(20, context)),
            child:   StreamBuilder(
              stream:  FirestoreService().getDecaissement(_emailEntreprise),
              builder: (BuildContext context,
                  AsyncSnapshot<List<DecaissementModels>> snapshot) {
                if (snapshot.hasError || !snapshot.hasData)
                  return Center(child: CircularProgressIndicator(),);
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator(),);
                else if(snapshot.data.isEmpty)
                  return Center(child:Text("Aucun decaissement effectuée"));
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 1,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    DecaissementModels decaissementModels = snapshot.data[i];
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
                                color: HexColor("#B2C40F"),
                              ),
                              Text("   "),
                              autoSizeTextGreySorti(decaissementModels.operationDate),
                              autoSizeTextGreySorti(decaissementModels.etat),
                              autoSizeTextGreySorti(decaissementModels.expenseTitle),
                              SizedBox(width: 10,),
                              autoSizeTextGreySorti("${decaissementModels.amount}")
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
          ),*/
          Container(
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
                        child: displayRecapTextBold("Type")),
                    Expanded(
                        flex: 1,
                        child: displayRecapTextBold("Détail")),
                    Expanded(
                        flex: 1,
                        child: displayRecapTextBold("Montant")),
                   /* Expanded(
                        flex: 1,
                        child: displayRecapTextBold("Recap")),*/
                  ],
                ),
                StreamBuilder(
                  stream:  _users
                      .doc(_emailEntreprise)
                      .collection("Decaissement")
                      .orderBy("created", descending: true)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError || !snapshot.hasData)
                      return Center(child: CircularProgressIndicator(),);
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
                                    color: snapshot.data.docs[i].data()["etat"] == "Entrée" ? primaryColor: HexColor("#B2C40F"),
                                  ),
                                  Text("   "),
                                  snapshot.data.docs[i].data()["etat"] == "Entrée" ? autoSizeTextGreyEntrer(Helper.currentFormatDate(snapshot.data.docs[i].data()["operationDate"])):autoSizeTextGreySorti(snapshot.data.docs[i].data()["operationDate"]),
                                  Text("   "),
                                  snapshot.data.docs[i].data()["etat"] == "Entrée" ? autoSizeTextGreyEntrer("${snapshot.data.docs[i].data()["etat"]}"):autoSizeTextGreySorti(snapshot.data.docs[i].data()["etat"]),
                                  snapshot.data.docs[i].data()["etat"] == "Entrée" ? autoSizeTextGreyEntrer(snapshot.data.docs[i].data()["expenseTitle"]):autoSizeTextGreySorti(snapshot.data.docs[i].data()["expenseTitle"]),
                                  snapshot.data.docs[i].data()["etat"] == "Entrée" ? autoSizeTextGreyEntrer(Helper.currenceFormat(snapshot.data.docs[i].data()["amount"])):autoSizeTextGreySorti(Helper.currenceFormat(snapshot.data.docs[i].data()["amount"])),
                                  /*Expanded(
                                      flex: 1,
                                      child:IconButton(icon:  Icon(Icons.navigate_next, color: primaryColor, size: 30,), onPressed: (){
                                       /* Navigator.push(context,
                                            MaterialPageRoute(builder: (_) => DetailsFacture(
                                              typeFacturation: snapshot.data.docs[i].data()["billingType"]=="Ventes"?false:true,
                                              dateInput: snapshot.data.docs[i].data()["created"],
                                              client: snapshot.data.docs[i].data()["customerName"],
                                              emailEntreprise: _emailEntreprise,
                                              products: snapshot.data.docs[i].data()["products"]
                                              ,)));*/
                                      })
                                  )*/
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
