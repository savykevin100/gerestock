

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/constantsWidgets.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/firestore_service.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/helper.dart';
import 'package:gerestock/modeles/facture.dart';





class DetailsFacture extends StatefulWidget {
  static String id = "DetailsFacture";
  Facture facture;
  String dateInput;
  String client;
  List<dynamic> products;
  bool typeFacturation;
  String emailEntreprise;

  DetailsFacture({
    this.facture,
    this.dateInput,
    this.client,
    this.products,
    this.typeFacturation,
    this.emailEntreprise
  });

  @override
  _DetailsFactureState createState() => _DetailsFactureState();
}

class _DetailsFactureState extends State<DetailsFacture> {
  String _emailEntreprise;
  Map<String, dynamic> _userData;
  int _amountTotal =0;
  String pathPDF = "";




  Future<User> getUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> fetchDataUser(){
    FirebaseFirestore.instance.collection("Utilisateurs").doc(_emailEntreprise).get().then((value) {
      print(value.data());
      if(this.mounted)
        setState(() {
          _userData = value.data();
        });
    });
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
        fetchDataUser();
      }
    });
    widget.products.forEach((element) {
      print(element);
      setState(() {
        _amountTotal=_amountTotal + int.tryParse(element["quantite"]) * int.tryParse(element["sellPriceProduct"]);
      });
      print(_amountTotal);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextClasse(text: "Facturation", color: white, fontSize: 20, textAlign: TextAlign.center, family: "MonserratBold",),
          backgroundColor: primaryColor,
        ),
        body: Card(
          elevation: 5.0,
          margin: EdgeInsets.symmetric(horizontal: largeurPerCent(9, context), vertical: longueurPerCent(50, context)),
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: white,
            child: bodyInCard(),
          ),
        ),
        floatingActionButton: Center(
          child: Container(
            margin: EdgeInsets.only(
                top: MediaQuery
                    .of(context)
                    .size
                    .height - 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(width: largeurPerCent(20, context),),
              ],
            ),
          ),
        )
    );
  }


  Widget bodyInCard(){
    return ListView(
      children: [
        SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            Container(
                height:80,
                width: 80,
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(color: HexColor("#C9C9C9"),)
                ),
                child: //(_userData["logo"]=="")?Center(child: TextClasse(text: "Logo", family: "MonserratBold", fontSize: 20,))/
                (_userData!=null)?CachedNetworkImage(
                  imageUrl: _userData["logo"],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color:Colors.red, height: 110, width: largeurPerCent(210, context),),
                ):Center(child: TextClasse(text: "Logo", family: "MonserratBold", fontSize: 20,))
            ),
            /* RichText(
                    text: TextSpan(
                      text: 'FACTURE N° ',
                      style: TextStyle(fontSize: 10,color: HexColor("#C9C9C9"), fontFamily: "MonserratBold"),
                      children: <TextSpan>[
                        TextSpan(text: '1487', style: TextStyle(fontFamily: "MonserratBold", color: HexColor("#000000"))),
                      ],
                    ),
                  ),*/
           /* (_userData != null)
                ? Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      displayText(Helper.currentFormatDate(widget.dateInput)),
                      SizedBox(
                        height: 10,
                      ),
                      (_userData != null)
                          ? displayText(_userData["address"])
                          : Text(""),
                      SizedBox(
                        height: 10,
                      ),
                      (_userData != null)
                          ? displayText(_userData["telephoneNumber"])
                          : Text(""),
                      SizedBox(
                        height: 10,
                      ),
                      (_userData != null)
                          ? displayText(_userData["ifu"])
                          : Text(""),
                    ],
                  )
                : Text(""),*/
            SizedBox(width: 10,)
          ],
        ),
        SizedBox(height: 10,),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              RichText(
                text: TextSpan(
                  text: "Nom du client:     ",
                  style: TextStyle(fontSize: 10,color: HexColor("#C9C9C9"), fontFamily: "MonserratBold"),
                  children: <TextSpan>[
                    TextSpan(text: '${widget.client}', style: TextStyle(fontFamily: "MonserratBold", color: HexColor("#000000"))),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 56,),
        Padding(
            padding: EdgeInsets.only(left: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex:1,
                        child: (widget.typeFacturation==false)?displayRecapTextBold("Nom du produit"):displayRecapTextBold("Service")),
                    (widget.typeFacturation==false)?Expanded(
                        flex:1,
                        child: displayRecapTextBold("Quantité")):Text(""),
                    (widget.typeFacturation==false)?Expanded(
                        flex: 1,
                        child: displayRecapTextBold("Prix Unitaire")):Text(""),
                    (widget.typeFacturation==true)?SizedBox(width: 50,):Text(""),
                    Expanded(
                        flex: 1,
                        child: displayRecapTextBold("Montant")),
                  ],
                ),
                SizedBox(height: 20,),
                StaggeredGridView.countBuilder(
                  crossAxisCount: 1,
                  itemCount: widget.products.length,
                  itemBuilder: (context, i) {
                    return Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          (widget.typeFacturation==false)?Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              (widget.typeFacturation==false)?autoSizeTextGrey(widget.products[i]["productName"]):autoSizeTextGrey(widget.products[i]["service"]),
                              (widget.typeFacturation==false)?autoSizeTextGrey(widget.products[i]["quantite"]):autoSizeTextGrey("1"),
                              autoSizeTextGrey(Helper.currenceFormat(int.tryParse(widget.products[i]["sellPriceProduct"]))),
                              autoSizeTextGrey(Helper.currenceFormat(int.tryParse(widget.products[i]["sellPriceProduct"])*int.tryParse(widget.products[i]["quantite"]))),
                            ],
                          ):Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              autoSizeTextGrey(widget.products[i]["service"]),
                              SizedBox(width: 50,),
                              autoSizeTextGrey(Helper.currenceFormat(int.tryParse(widget.products[i]["sellPriceProduct"]))),
                            ],
                          ),
                          Divider(color: HexColor("#ADB3C4"),)
                        ],
                      ),

                    );
                  },
                  staggeredTileBuilder: (_) => StaggeredTile.fit(2),
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 0.0,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                )
              ],
            )
        ),

        SizedBox(height: longueurPerCent(20, context),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextClasse(text: "Montant", family: "MonserratBold", fontSize: 25, color: HexColor("#001C36"),),
            TextClasse(text:Helper.currenceFormat(_amountTotal), family: "MonserratBold", fontSize: 15, color: HexColor("#001C36"),),
          ],
        )
      ],
    );
  }



  TextClasse  displayRecapTextBold(String text){
    return TextClasse(text: text, color: HexColor("#001C36"), family: "MonserratBold", fontSize: 9,);
  }

  TextClasse  displayRecapTextGrey(String text){
    return TextClasse(text: text, color: HexColor("#C9C9C9"), family: "MonserratBold", fontSize: 12,);
  }




  Expanded autoSizeTextGrey(String titre){
    return Expanded(
        flex: 1,
        child: AutoSizeText(
          titre,
          style: TextStyle(fontSize: 10.0, fontFamily: "MonserratBold", color: HexColor("C9C9C9")),
          maxLines:(widget.typeFacturation==false)? 3:6,
          minFontSize: 9,
        )
    );
  }
}
