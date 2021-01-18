import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/pages/nouveauProduit/produitsFamille.dart';

import 'nouveauProduit.dart';


class Produits extends StatefulWidget {
  @override
  _ProduitsState createState() => _ProduitsState();
}

class _ProduitsState extends State<Produits> {

  String emailEntreprise;
  // ignore: deprecated_member_use
  CollectionReference _users= Firestore.instance
      .collection("Utilisateurs");

  Future<User> getUser() async {
    return FirebaseAuth.instance.currentUser;
  }


  bool currentUser=false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((value) {
      setState(() {
        emailEntreprise = value.email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithSearch(context,"Familles"),
      body:Center(
        child: Card(
            margin: EdgeInsets.symmetric(horizontal: largeurPerCent(21, context), vertical: longueurPerCent(46, context)),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: StreamBuilder(
                stream: _users
                    .doc(emailEntreprise)
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
                    return Center(child:Text("Pas de familles ajoutées"));
                  return new ListView(
                    children: snapshot.data.documents.map((DocumentSnapshot document) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => ProduitsFamille(familyName: document.data()['familyName'],)));
                            },
                            child: ListTile(
                              title: TextClasse(
                                text: document.data()['familyName'],
                                family: "MonserratSemiBold",
                              ),
                             /* subtitle: StreamBuilder(
                              stream: _users.doc(emailEntreprise).collection("Familles").where("nomFamille", isEqualTo:document.data()['nomFamille']).snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError || !snapshot.hasData)
                                  return Text('Something went wrong');
                                if (snapshot.connectionState == ConnectionState.waiting)
                                  return Text("Loading");
                                  return TextClasse(text: (snapshot.data.documents.length==1)?"${snapshot.data.documents.length} produit":"${snapshot.data.documents.length} produits", family: "MonserratMedium", fontSize: 13,);
                                 },
                              ),*/
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => NouveauProduit()));
        },
        child: Icon(Icons.add, color: white,),
        backgroundColor: primaryColor,
      ),
    );
  }
}

/*ListView.builder(
                    itemCount: snapshot.data.size,
                    itemBuilder: (context,  i) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => ProduitsFamille()));
                            },
                            child: ListTile(
                              title: TextClasse(
                                text: "Alimentaire",
                                family: "MonserratSemiBold",
                              ),
                              subtitle:TextClasse(text: "25 produits", family: "MonserratMedium", fontSize: 13,),
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
                    }
                  );*/
