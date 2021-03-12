import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gerestock/app_controller.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/helper.dart';
import 'package:gerestock/pages/nouveauProduit/produitsFamille.dart';
import 'package:gerestock/repository.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'nouveauProduit.dart';


class Produits extends StatefulWidget {
  @override
  _ProduitsState createState() => _ProduitsState();
}

class _ProduitsState extends StateMVC<Produits> {

  AppController _con ;

  // ignore: deprecated_member_use
  CollectionReference _users= Firestore.instance
      .collection("Utilisateurs");



  _ProduitsState() : super(AppController()) {
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
      appBar: appBarWithSearch(context,"Familles"),
      body:Center(
        child: (_con.userPhone!="")?Card(
            margin: EdgeInsets.symmetric(horizontal: largeurPerCent(21, context), vertical: longueurPerCent(46, context)),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: StreamBuilder(
                stream: _users
                    .doc(_con.userPhone)
                    .collection("Familles")
                    .orderBy("familyName", descending: false)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError || !snapshot.hasData)
                    return Center(child:CircularProgressIndicator());
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(child:CircularProgressIndicator());
                  else if(snapshot.connectionState == ConnectionState.none)
                    return Center(child: Text("Veuillez vérifier votre connexion internet"),);
                  else if(snapshot.data.docs.isEmpty)
                    return Center(child:TextClasse(text: "Pas de familles ajoutées", color: Colors.black, fontSize: 15, family: "MonserratBold",),);
                  return new ListView(
                    children: snapshot.data.documents.map((DocumentSnapshot document) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => ProduitsFamille(familyName: document.data()['familyName'], userPhone: _con.userPhone,)));
                            },
                            child: ListTile(
                              title: TextClasse(
                                text: document.data()['familyName'],
                                family: "MonserratSemiBold",
                              ),
                              trailing: Icon(
                                Icons.navigate_next,
                                color: HexColor("#ADB3C4"),
                                size: 30,
                              ),
                            ),
                          ),
                          Divider(color: HexColor("#ADB3C4"),)
                        ],
                      );
                    }).toList(),
                  );
                },
              )
            )
        ):CircularProgressIndicator()
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => NouveauProduit(userPhone: _con.userPhone,)));
        },
        child: Icon(Icons.add, color: white,),
        backgroundColor: primaryColor,
      ),
    );
  }
  
}


