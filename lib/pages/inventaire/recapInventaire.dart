import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gerestock/constantes/appBar.dart';
import 'package:gerestock/constantes/calcul.dart';
import 'package:gerestock/constantes/color.dart';
import 'package:gerestock/constantes/firestore_service.dart';
import 'package:gerestock/constantes/hexadecimal.dart';
import 'package:gerestock/constantes/text_classe.dart';
import 'package:gerestock/modeles/inventaire.dart';
import 'package:gerestock/pages/accueil.dart';

import 'inventaire.dart';

class RecapInventaire extends StatefulWidget {
  List<Map<String, dynamic>> produitsFamilles = [];
  String familyName ;

  RecapInventaire({this.produitsFamilles, this.familyName});
  @override
  _RecapInventaireState createState() => _RecapInventaireState();
}

class _RecapInventaireState extends State<RecapInventaire> {

  String _emailEntreprise;





  Future<User> getUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((value) {
      setState(() {
        _emailEntreprise = value.email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, "Inventaire"),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: longueurPerCent(30, context), horizontal: largeurPerCent(20, context)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex:3,
                      child: displayRecapTextBold("Produits")),
                  Expanded(
                      flex:1,
                      child: displayRecapTextBold("QTÉ théorique")),
                  Expanded(
                      flex: 1,
                      child: displayRecapTextBold("ECART")),
                ],
              ),
          StaggeredGridView.countBuilder(
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 1,
            itemCount: widget.produitsFamilles.length,
            itemBuilder: (context, i) {
              return Container(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex:2,
                          child: Container(
                            child: CachedNetworkImage(
                              height: 100,
                              width: 30,
                              imageUrl: widget.produitsFamilles[i]["image"],
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(color:Colors.red, height: 110, width: largeurPerCent(210, context),),
                            ),),
                        ),
                        SizedBox(width: 10,),
                        autoSizeTextGreyEntrer(widget.produitsFamilles[i]["productName"],),
                        autoSizeTextGreyEntrer("${widget.produitsFamilles[i]["theoricalStock"]}",),
                        autoSizeTextGreyEntrer("${widget.produitsFamilles[i]["reste"] }",),
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
             )
            ],
          ),
        ),
      ),
      floatingActionButton: Center(
        child: Container(
          margin: EdgeInsets.only(
              top: MediaQuery
                  .of(context)
                  .size
                  .height - 60),
          child:InkWell(
            onTap:(){
              addInventaire();
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
                    "CONTINUER ",
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


  Future<void> addInventaire(){
    try {
      EasyLoading.show(status: 'Chargement', dismissOnTap: false);
      widget.produitsFamilles.forEach((element) {
        FirebaseFirestore.instance.collection("Utilisateurs").doc(_emailEntreprise).collection("TousLesProduits").doc(element["id"]).update({"theoreticalStock":element["physicalStock"]}).then((value){
          print("Réussie");
        });
      });

      FirestoreService().addInventaire( Inventaires(
        created: DateTime.now().toString().toString().substring(0, 10),
        products: widget.produitsFamilles,
        familyName: widget.familyName,
      ), _emailEntreprise);
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => Accueil()));

      EasyLoading.dismiss();
      EasyLoading.showSuccess("L'ajout a réussie");
    } catch (e){
      print(e);
      EasyLoading.dismiss();
      EasyLoading.showError("L'ajout a échoué");
      EasyLoading.dismiss();
    }
  }
  TextClasse  displayRecapTextBold(String text){
    return TextClasse(text: text, color: HexColor("#C9C9C9"), family: "MonserratBold", fontSize: 10,);
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
