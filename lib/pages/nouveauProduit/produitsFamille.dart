import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/modeles/produits.dart';
import 'package:gerestock/pages/nouveauProduit/familles.dart';
import 'package:gerestock/pages/nouveauProduit/ficheProduit.dart';


class ProduitsFamille extends StatefulWidget {
  String familyName;
  ProduitsFamille({this.familyName});
  @override
  _ProduitsFamilleState createState() => _ProduitsFamilleState();
}

class _ProduitsFamilleState extends State<ProduitsFamille> {


  String emailEntreprise;
  List<Map<String, dynamic>> productsList=[];
  CollectionReference _users= Firestore.instance
      .collection("Utilisateurs");

  Future<User> getUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  void fetchProductsInFamily(){
    _users
        .doc(emailEntreprise)
        .collection("TousLesProduits")
        .where("familyName", isEqualTo: widget.familyName)
        .get().then((value){
        value.docs.forEach((element) {
          if(this.mounted)
            setState(() {
              productsList.add(element.data());
            });
        });
    });
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
      fetchProductsInFamily();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Produits"),
      body: (productsList.length!=0)?Center(
        child:  Container(
          height: double.infinity,
          width: double.infinity,
          child: StreamBuilder(
            stream:  _users
                .doc(emailEntreprise)
                .collection("TousLesProduits")
                .where("familyName", isEqualTo: widget.familyName)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError || !snapshot.hasData)
                return Center(child: CircularProgressIndicator(),);
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator(),);
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
                              MaterialPageRoute(builder: (_) => FicheProduit(produit: Produit(
                                image: document.data()["image"],
                                buyingPrice: document.data()["buyingPrice"],
                                physicalStock: document.data()["physicalStock"],
                                productName: document.data()["productName"],
                                id: document.data()["id"],
                                sellPrice: document.data()["sellPrice"],
                                stockAlert: document.data()["stockAlert"],
                                theoreticalStock  : document.data()["theoreticalStock"],
                                familyName  : document.data()["familyName"],
                              ), emailEntreprise: emailEntreprise,),));
                        },
                        child: ListTile(
                            title: TextClasse(
                              text: document.data()['productName'],
                              family: "MonserraLight",
                            ),
                            trailing: Icon(
                              Icons.navigate_next,
                              color: HexColor("#ADB3C4"),
                              size: 30,
                            ),
                            subtitle:TextClasse(text: "Quantité: "+document.data()['theoreticalStock'].toString(), family: "MonserratMedium1", fontSize: 13,)
                        ),
                      ),
                      Divider(color: HexColor("#ADB3C4"),)
                    ],
                  );
                }).toList(),
              );
            },
          ),
        ),
      ):Center(child: CircularProgressIndicator(),)
    );
  }
}
/**/
