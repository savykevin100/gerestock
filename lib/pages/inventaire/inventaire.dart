import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gerestock/app_controller.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/pages/inventaire/detailsInventaire.dart';
import 'package:gerestock/pages/inventaire/nouvelInventaire.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class Inventaire extends StatefulWidget {
  @override
  _InventaireState createState() => _InventaireState();
}

class _InventaireState extends StateMVC<Inventaire> {


  CollectionReference _users= Firestore.instance
      .collection("Utilisateurs");





  AppController _con ;



  _InventaireState() : super(AppController()) {
    _con = controller;
  }



  Future<User> getUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((value) {
      setState(() {
        _con.userPhone = value.email;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithSearch(context,"Inventaire"),
      body: Container(
        margin: EdgeInsets.only(left: 10, top: 20),
        child: StreamBuilder(
            stream:  _users
                .doc(_con.userPhone)
                .collection("Inventaires")
                .orderBy("created", descending: true)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError || !snapshot.hasData)
                return Center(child: CircularProgressIndicator(),);
                if (snapshot.connectionState == ConnectionState.waiting)
                return Center(child: CircularProgressIndicator(),);
                else if(snapshot.connectionState == ConnectionState.none)
                return Center(child: Text("Veuillez vérifier votre connexion internet"),);
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context,  i) {
                      return Column(
                        children: [
                          ListTile(
                            title: TextClasse(
                              text: "Inventaire: Famille ${snapshot.data.docs[i].data()["familyName"]} du ${snapshot.data.docs[i].data()["created"]}",
                              family: "MonserratSemiBold",
                            ),
                            //subtitle: TextClasse(text:client.telephoneNumber, family: "MonserratMedium", fontSize: 13,),
                            trailing: InkWell(
                              onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsInventaire(id:snapshot.data.docs[i].data()["id"])),),
                              child: Icon(
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
                );
            }
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => NouvelInventaire(userPhone: _con.userPhone,)));
        },
        child: Icon(Icons.add, color: white,),
        backgroundColor: primaryColor,
      ),
    );
  }
  /*Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          height: double.infinity,
          width: double.infinity,
          child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context,  i) {
                return Column(
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                           crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              child: TextClasse(text: "03/10", family: "MonserratMedium", fontSize: 11, color: white,),
                              backgroundColor: HexColor("#B2C40F"),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: TextClasse(
                                text: "Alimentaire",
                                family: "MonserratSemiBold",
                              ),
                            ),
                            SizedBox(height: 40,),
                          ],
                        ),
                        Row(
                           crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(Icons.calendar_today, size: 13,),
                            TextClasse(text: "15 Jan 2020", color: HexColor("#ADB3C4"), family: "MonserratMedium", fontSize: 10,),
                            Icon(Icons.navigate_next, size: 13,),
                          ],
                        )
                      ],
                    ),
                    Divider(color: HexColor("#ADB3C4"),)
                  ],
                );
              }
          ),
        ),
      ),*/
  /**/


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