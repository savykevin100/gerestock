import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/firestore_service.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/modeles/depenses.dart';

import '../../helper.dart';



class Depenses extends StatefulWidget {
  @override
  _DepensesState createState() => _DepensesState();
}

class _DepensesState extends State<Depenses> {


  String emailEntreprise;
  Future<User> getUser() async {
    return FirebaseAuth.instance.currentUser;
  }
  CollectionReference _users= Firestore.instance
      .collection("Utilisateurs");


  bool currentUser=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((value) {
      setState(() {
        emailEntreprise = value.email;
      });
      print(emailEntreprise);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithSearch(context,"Dépenses"),
      body: Container(
        margin: EdgeInsets.only(left: 10, top: 20),
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
                    flex: 1,
                    child: displayRecapTextBold("Motif")),
                Expanded(
                    flex: 1,
                    child: displayRecapTextBold("Montant")),
              ],
            ),
            StreamBuilder(
              stream:  _users
                  .doc(emailEntreprise)
                  .collection("Depenses")
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
                              autoSizeTextGreyEntrer(snapshot.data.docs[i].data()["operationDate"]),
                              autoSizeTextGreyEntrer(snapshot.data.docs[i].data()["expenseTitle"]),
                              autoSizeTextGreyEntrer(Helper.currenceFormat(snapshot.data.docs[i].data()["amount"])),
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
        /* StreamBuilder(
            stream: FirestoreService().getDepenses(emailEntreprise),
            builder: (BuildContext context,
                AsyncSnapshot<List<Depense>> snapshot) {
              if(snapshot.hasError || !snapshot.hasData)
                return Center(child: CircularProgressIndicator());
             else if(snapshot.data.isEmpty)
              return Center(child:Text("Pas de depenses"));
              else {
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 1,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    Depense depense = snapshot.data[i];
                    return Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 5),
                                height: 13,
                                width: 4,
                                color: primaryColor,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: autoSizeTextGreyEntrer(Helper.currentFormatDate(depense.operationDate))),
                              SizedBox(width: 5,),
                              Expanded(
                                  flex: 1,
                                  child: AutoSizeText(
                                    "${depense.id}",
                                    style: TextStyle(fontSize: 10.0, fontFamily: "MonserratBold", color: primaryColor),
                                    maxLines: 2,
                                    minFontSize: 7,
                                  )),
                              SizedBox(width: 10,),
                              Expanded(
                                  flex: 2,
                                  child: Center(child: autoSizeTextGreyEntrer(depense.expenseTitle))),
                              Expanded(
                                  flex: 2,
                                  child: Center(child: autoSizeTextGreyEntrer(depense.amount)))
                            ],
                          ),
                          Divider(color: HexColor("#ADB3C4"),),
                        ],
                      ),

                    );
                  },
                  staggeredTileBuilder: (_) => StaggeredTile.fit(2),
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 0.0,
                  shrinkWrap: true,
                );
              }
            }
        )*/
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/NouvelleDepense");
        },
        child: Icon(Icons.add, color: white,),
        backgroundColor: primaryColor,
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
