import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/constantsWidgets.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/modeles/produits.dart';


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
          SizedBox(height: 30,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              nameOfFieldWithPadding("Date de réception", context),
              InkWell(
                onTap: (){
                  DatePicker.showDatePicker(context,
                      showTitleActions: true,
                      minTime: DateTime(2000, 1, 1),
                      maxTime: DateTime(2040, 12, 31), onChanged: (date) {
                        setState(() {
                          dateInput = date.toString().substring(0, 10);
                        });
                      }, onConfirm: (date) {
                        setState(() {
                          dateInput = date.toString().substring(0, 10);
                          print(dateInput);
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.fr);
                },
                child: Container(
                    height: longueurPerCent(41, context),
                    width: largeurPerCent(210, context),
                    margin: EdgeInsets.only(right: largeurPerCent(22, context)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(width: 1.0, color: HexColor("#707070")),
                    ),
                    child: (dateInput!=null)?Center(child: TextClasse(text: dateInput, color:  HexColor("#707070"), family: "MonserratBold",),):Text("")
                ),
              )
            ],
          ),
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
                          produitsFamilles.add(element.data());
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
          (produitsFamilles.length!=0)?Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: cva.keys.map((String key) {
              return new CheckboxListTile(
                controlAffinity: ListTileControlAffinity.trailing,
                title:  Row(
                  children: [
                    Container(
                      child: CachedNetworkImage(
                        height: 60,
                        width: 60,
                        imageUrl: "https://firebasestorage.googleapis.com/v0/b/gerestock-aa75e.appspot.com/o/savykevin100%40gmail.com%2FPc%2FTOSHIBA?alt=media&token=60e80d48-0f1e-4c7c-a508-cb2d5a0002dd",
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(color:Colors.red, height: 110, width: largeurPerCent(210, context),),
                      ),
                    ),
                    SizedBox(width: 20,),
                    TextClasse(text: key, family: "MonserratLight", fontSize: 15,),
                  ],
                ),
                value: cva[key],
                activeColor:HexColor("#119600"),
                checkColor: Colors.white,
                onChanged: (bool value) {
                  setState(() {
                    cva[key] = value;
                  });

                },
              );
            }).toList(),
          ):Center(child: Column(
            children: [
              SizedBox(height: 80,),
              Text("Aucune famille selectionnée"),
            ],
          ),)
        ],
      ):Center(child: CircularProgressIndicator(),)
    );
  }
}
