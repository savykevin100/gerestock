import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/constantsWidgets.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/submit_button.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/modeles/produits.dart';
import 'package:gerestock/pages/inventaire/recapInventaire.dart';


class NouvelInventaire extends StatefulWidget {
  @override
  _NouvelInventaireState createState() => _NouvelInventaireState();
}

class _NouvelInventaireState extends State<NouvelInventaire> {
  String dateInput;
  FirebaseFirestore _db = Firestore.instance;
  List<String> familles=[];
  String emailEntreprise;
  String familleSelect;
  List<Map<String, dynamic>> produitsFamilles = [];
  Map<String, bool> cva = {
    'Soja': false,
    'Miel': false,
    'Karité': false,
    'Feuilles de baobab': false,
    'Sésame': false,
    'Lentilles vertes': false,
  };



  Future<User> getUser() async {
    return FirebaseAuth.instance.currentUser;
  }



  Future<void> getNomFamille(String email) async {
    _db.collection("Utilisateurs").
    doc(email).collection("Familles").
    get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          familles.add(element.data()["familyName"]);
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((value) {
      setState(() {
        emailEntreprise = value.email;
      });
      getNomFamille(value.email);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Nouvel Inventaire"),
      body: (familles.length>0)?ListView(
        children: [
          SizedBox(height: longueurPerCent(20, context),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              nameOfFieldWithPadding("Famille du produit", context),
              Container(
                height: longueurPerCent(41, context),
                width: largeurPerCent(210, context),
                margin: EdgeInsets.only(right: largeurPerCent(22, context)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(width: 1.0, color: HexColor("#707070")),
                ),
                child:  DropdownButton(
                  underline: Text(""),
                  hint: familleSelect == null
                      ? Text(
                    '',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  )
                      : Padding(
                        padding:EdgeInsets.only(left: 5),
                        child: Text(
                    familleSelect,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                    ),
                  ),
                      ),
                  isExpanded: true,
                  iconSize: 30.0,
                  items:
                  familles.map(
                        (val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val,),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                  setState(() {
                    familleSelect = val;
                  });
                  _db.collection("Utilisateurs").doc(emailEntreprise).collection("TousLesProduits").where("familyName", isEqualTo: val).get().then((value) {
                    if(value.docs.isNotEmpty)
                      value.docs.forEach((element) {
                        print(element.data());
                        setState(() {
                          produitsFamilles = [];
                          produitsFamilles.add(
                            {
                              "productName": element.data()["productName"],
                              "theoricalStock": element.data()["theoreticalStock"],
                              "reste":0,
                              "image":element.data()["image"],
                              "id": element.data()["id"],
                              "physicalStock":0,
                            }
                          );
                        });
                      });
                  });
                  },
                ),
              )
            ],
          ),
          SizedBox(height: 40,),
          TextClasse(text: "Liste des produits", textAlign: TextAlign.center, family: "MonserratBold", color: HexColor("#001C36"),),
          SizedBox(height: 20,),
          (produitsFamilles.length!=0)? ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            separatorBuilder: (context , index){
              return Column(
                children: [
                  Divider(height: 10, color: Colors.black,),
                  SizedBox(height: 15,),
                ],
              );
            },
            itemCount: produitsFamilles.length,
            itemBuilder: (context, index){
              return  Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: CachedNetworkImage(
                      height: 80,
                      width: 80,
                      imageUrl: produitsFamilles[index]["image"],
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(color:Colors.red, height: 110, width: largeurPerCent(210, context),),
                    ),),
                  TextClasse(text: produitsFamilles[index]["productName"], textAlign: TextAlign.center, family: "MonserratLight", color: HexColor("#001C36"),),
                  Container(
                    height: 41,
                    width:70,
                    margin: EdgeInsets.only(right: largeurPerCent(22, context)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(width: 1.0, color: HexColor("#707070")),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      maxLines: null,
                      //controller: controller,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                          enabledBorder: InputBorder.none
                      ),
                      onChanged: (value){
                        setState(() {
                          produitsFamilles[index]["reste"] =  produitsFamilles[index]["theoricalStock"] - int.tryParse(value);
                          produitsFamilles[index]["physicalStock"] = int.tryParse(value);
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 50,)
                ],
              );
            },
          ):Center(child: Column(
            children: [
              SizedBox(height: 100,),
              Text("Aucune famille selectionnée"),
            ],
          ),),
        ],
      ):Center(child: CircularProgressIndicator(),),
     floatingActionButton: Center(
       child: Container(
         margin: EdgeInsets.only(
             top: MediaQuery
                 .of(context)
                 .size
                 .height - 60),
         child:InkWell(
           onTap:(){
             print(familleSelect);
             Navigator.push(context,
                 MaterialPageRoute(builder: (_) => RecapInventaire(produitsFamilles: produitsFamilles, familyName: familleSelect,)));
           },
           child: Container(
             height: 38,
             width: 200,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(7),
               color: primaryColor,
             ),
             child: Center(
                 child: Text(
                   "VALIDER ",
                   style: TextStyle(
                       color: white,
                       fontFamily: "MonserratBold",
                       fontSize: 15),
                 )
             ),
           ),
         ),
       ),
     ),
    );
  }
}
